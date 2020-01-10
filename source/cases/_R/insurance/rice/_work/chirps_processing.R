# Aggregate CHIRPS data by season-year

# Initial export was done in GEE
# daily: https://code.earthengine.google.com/41751e41f471be916d8ef9c5af827e70
# pentad: https://code.earthengine.google.com/9d248fb66809d78843e56198605b8727

library(data.table)

# indir <- "G:\\My Drive\\biogeo\\QUIIC\\Trainings\\Workshop3\\case-studies\\rice\\qweb\\"

indir <- "where_is_the_data"
ff <- list.files(path = indir, pattern = "TZA_rice_chirps_", 
                 full.names = TRUE)

#################################################################################
# clean daily CHIRPS data
dd <- fread(ff[1])
dd$`system:index`<- NULL
dd$lat <- NULL
dd$lon <- NULL
dd$.geo <- NULL
dd$dummy <- NULL

# get dates
n <- 1:(ncol(dd)-1)
ddt <- gsub("_precipitation","", names(dd)[n])
names(dd)[n] <- ddt
dd[is.na(dd)] <- 0

ddl <- melt(dd, 
            id.vars = "fid",
            variable.name = "dates")
names(ddl)[3] <- "rain"
ddl <- setcolorder(ddl, c("dates", "fid", "rain"))
fwrite(ddl, paste0(indir, "TZA_rice_chirps_daily_clean.csv"))

#################################################################################
# clean pentad
d <- ff[2]
d$lat <- NULL
d$lon <- NULL
d$.geo <- NULL
dates <- sapply(strsplit(d$`system:index`, "_"), "[[", 1)
dates <- as.Date(as.character(dates), format="%Y%m%d")
d$`system:index` <- dates
names(d)[c(1,3)] <- c("dates", "rain")
fwrite(d, paste0(indir, "TZA_rice_chirps_pentad_1km_clean.csv"))

#################################################################################
# aggregate the data by growing season---no automatic start or end of season
# October 1 to April 30

seasonalRain <- function(year, d){
  # should we do one with monthly rainfall?
  year <- as.numeric(year)
  start <- as.Date(paste0(year-1, "-10-01"))
  end <- as.Date(paste0(year, "-04-30"))
  yd <- d[d$dates >= start & d$dates <= end,]
  agr <- aggregate(yd$rain, yd[,"fid", drop = FALSE], sum, na.rm = TRUE)
  colnames(agr)[2] <- "rain_season"
  agr$year <- year
  return(agr)
}

years <- seq(2003,2014)

dd <- list()
for(i in 1:length(years)){
  print(i)
  dd[[i]] <- seasonalRain(years[i], d)
}

dd <- rbindlist(dd)
fwrite(dd, paste0(indir, "seasonal_rain.csv"))

##############################################################################
# merge with yield data
# get yield data
library(agrins)
yd <- data_rice("yield")

# add rainfall; some of the farmers doesn't have rainfall?

# # why dims are different
# dim(d)
# dim(dr)
# 
# # check which are different
# x1 <- paste0(d$year, "_", d$fid)
# x2 <- paste0(rs$year, "_", rs$fid)
# 
# # in yield, but not in rainfall
# x1[!x1%in%x2]
# 
# # going back, found out that some of the farmers didn't have lat lon!!!

# median yield
yzt <- aggregate(dr$y, dr[, c("zone", "year")], median)
colnames(yzt)[3] = "y_zt"
# mean rainfall
rain <- aggregate(dr$rain_season, dr[, c("zone", "year")], mean, na.rm=TRUE)
adr <- merge(yzt, rain, by=c("zone","year"))
names(adr)[4] <- "mean_rainfall"
fwrite(adr, paste0(indir, "seasonal_rain_zone_year.csv"))

# indices data
idx <- data_rice("indices")
head(idx, n=3)

# adr rice
yidx <- merge(idx, adr, by = c("zone","year")) 
yidx$y_zt <- NULL
fwrite(yidx, paste0(indir, "crop_yield_index_pred.csv"))



###############################################################################
# What if we want monthly
ff <- list.files(path = indir, pattern = "TZA_rice_chirps_pentad_1km.csv", 
                 full.names = TRUE)

# non-clean data
d <- fread(ff)

# remove lat lon geo and convert date to actual date objects
d$lat <- NULL
d$lon <- NULL
d$.geo <- NULL

dates <- sapply(strsplit(d$`system:index`, "_"), "[[", 1)
dates <- as.Date(as.character(dates), format="%Y%m%d")
d$`system:index` <- dates
names(d)[c(1,3)] <- c("dates", "rain")

# create monthly mean of rainfall
d$mo <- as.character(strftime(d$dates, "%m"))
d$year <- as.character(strftime(d$dates, "%Y"))

# aggregate by month, year and fid
dm.agg <- aggregate(rain ~ mo + yr + fid, d, FUN = sum)

# dm.agg$dates <- as.POSIXct(paste(dm.agg$yr, dm.agg$mo, "01", sep = "-"))
subdm <- dm.agg[dm.agg$mo %in% c("01","02","03","10","11","12"),]
subdm <- subdm[subdm$year %in% seq(2003,2012),]

# subdm$mo <- NULL
# subdm$yr <- NULL

# Now merge it by zone
library(agrins)
yd <- data_rice("yield")

# median yield
yzt <- aggregate(yd$y, yd[, c("zone", "year")], median)
colnames(yzt)[3] = "y_zt"

# average zone yield
yz <- aggregate(yd$y, yd[, "zone", drop=FALSE], median, na.rm=TRUE)
colnames(yz)[2] = "y_z"

# the number of farmers per zone per year
n <- aggregate(yd$fid, yd[,c("zone", "year")], length)
colnames(n)[3] = "n"

# merge them
z <- merge(n, yzt)
z <- merge(z, yz)
head(z, 3)

# mean z-score 
z$y_dz <- z$y_zt / z$y_z
dz <- merge(yd, z)

# read indices
idx <- data_rice("indices")
# merge zonal yields, we use this for future
z <- merge(z, idx[,-1])


# add zone information to fid in the rainfall data
zf <- yd[,c("zone", "fid")]
zf <- zf[!duplicated(zf),]
subdmzf <- merge(subdm, zf, by = "fid", all.x = TRUE)

# remove the one without rainfall
subdmzf <- subdmzf[!is.na(subdmzf$zone),]

# aggregate by zone
subdmzf <- aggregate(subdmzf$rain, subdmzf[,c("zone","mo","year"), drop = FALSE], mean )
names(subdmzf)[4] <- "mean_rain"
# rz <- reshape(subdmzf, idvar = "zone", timevar = "dates", direction = "wide")
# fwrite(rz, paste0(indir, "monthly_rainfall.csv"))

#################################################################################
# develop model by months
monthModel <- function(m, subdmzf, z){
  dd <- subdmzf[subdmzf$mo %in% m,]
  dd <- aggregate(dd$mean_rain, dd[ , c("zone","year"), drop = FALSE], mean)
  names(dd)[3] <- "mean_rain"
  yz <- merge(dd, z, by = c("zone","year"))
  mod <-  lm (y_zt ~ mean_rain + evi + gpp + zone, data = yz)
  summary(mod)
  return(mod)
}

# run for each month
months <- unique(subdmzf$mo)
monthly <- lapply(months, monthModel, subdmzf, yzt)
lapply(monthly, coefficients)
lapply(monthly, function(x)summary(x)$r.squared)


# run bi-monthly
mms <- combn(months, 2)
bimonthly <- list()

for (i in 1:ncol(mms)){
  m <- mms[,i]
  bimonthly[[i]] <- monthModel(m, subdmzf, yzt)
}
lapply(bimonthly, function(x)summary(x)$r.squared)


# run tri-monthly
mms <- combn(months, 3)
trimonthly <- list()

for (i in 1:ncol(mms)){
  m <- mms[,i]
  trimonthly[[i]] <- monthModel(m, subdmzf, yzt)
}
lapply(trimonthly, function(x)summary(x)$r.squared)

#####################################################################################

