datadir <- "/share/spatial02/users/anighosh/projects/quiic"
vidir <- file.path(datadir, "tza_rice/vi")
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# What is the benefit of these additional processing?
year <- 2012

startDate <- as.Date(paste0(year-1, "-07-01"))
endDate <- as.Date(paste0(year, "-6-30"))
evf <- evifiles[evifiles$date >= startDate & evifiles$date <= endDate,]

# original evi
or <- rast(evf$filename)

# processed evi
pr <- rast(paste0(vidir, "/filter_stack_EVI_",year,".tif"))
# processed ndfi
nr <- rast(paste0(vidir, "/filter_stack_NDFI_",year,".tif"))

# create random locations to test the rice detection method
set.seed(1)
s <- sampleRandom(raster(nr), 200, sp = TRUE)
s$id <- 1:nrow(s)
s$lyr.1 <- NULL
s <- vect(s)

# extract phenology information 
sor <- extract(or, s, drop = TRUE)
spr <- extract(pr, s, drop = TRUE)
snr <- extract(nr, s, drop = TRUE)

# check some of them
set.seed(1)
jj <- sample(1:nrow(sor), 100)

op <- par(ask=TRUE)
for(i in jj){
  # raw EVI
  plot(evf$date, sor[i,], pch = 16, col = "red", cex = 0.8, ylim = c(0,0.7), main = paste0("location_",i))
  # gap-filled and smoothed EVI
  lines(evf$date, spr[i,], col = "green")
  # gap-filled NDFI
  lines(evf$date, snr[i,], col = "blue")
  
  # fix legend
  legend("topleft", legend = c("raw_EVI", "fitted_EVI", "gap-filled_NDFI"),
         pch = c(16, NA, NA), lty = c(NA, 1, 1),
         col = c("red","green", "blue"), bty = "n", cex = 0.75)
}

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Step 2: apply phenorice to check rice phenology
source("web/source/crops/_work/phenorice.R")
# location specific rice parameters
p <- getPars()

# let's apply phenorice for all pixels and find the rice one only
rice <- list()

for(i in 1:nrow(spr)){
  rice[[i]] <- phenorice(evi = spr[i,], ndfi = snr[i,], p)
}

rice <- data.frame(do.call(rbind, rice))
names(rice) <- c("start", "peak", "flower", "head", "end")

# Only keep records that has been detected as rice
k <- which(rowSums(rice) > 0)
rice <- rice[k,]

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Next we use this phenological information to compute area under curve (AUC) based indices
# We show some simple index computation with following function - 
# AUC measure for the entire growing season, vegetative period and reproductive period 

# only rice pixels
vi <- spr[k,]

# What does these indices look like?
# We check the 20th record
v1 <- vi[20,]
v1 <- v1 - min(v1)
d1 <- rice[20,]


plot(v1, type = "l", col = "darkgreen", ylim = c(min(v1), max(v1)*1.25), 
      ylab = "EVI", xlab = "date", xaxt = "n",
      main = "EVI based index")

at <- seq(1, length(v1), 4) 
labs <- months(evf$date[at])
axis(1, at = at, labels = substr(labs, 1,3), las = 2)

# add vegetative growth
polygon(x=c(d1$start,d1$start:d1$peak,d1$peak), 
        y=c(0, v1[d1$start:d1$peak], 0), 
        col="green")

# add grain-filling 
polygon(x=c(d1$peak,d1$peak:d1$end,d1$end), 
        y=c(0, v1[d1$peak:d1$end], 0), col="yellow")

# add full growing season
polygon(x=c(d1$start,d1$start:d1$end,d1$end), 
        y=c(0, v1[d1$start:d1$end], 0), 
        col="red", density=10)

# add legend
legend("topleft", legend=c("vegetative","grain","full"), fill=c("green", "yellow", "red"),
       density=c(NA, NA, 10), bty="n", border="black")


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Next we show how to compute the area under the curve
aucVIth <- function(i, vi, dates){
  # get vi for the pixel
  v <- vi[i,]
  d <- dates[i,]
  
  # subtract background information
  v <- v - min(v)
  
  # vegetative growth
  i1 <- sum(v[d$start:d$peak], na.rm = TRUE)
  
  # reproductive
  i2 <- sum(v[d$peak:d$end], na.rm = TRUE)
  
  # full season
  i3 <- sum(v[d$start:d$end], na.rm = TRUE)
  
  return(c(i1, i2, i3))
}

# to store the results
ind <- list()

# compute indices
for (i in 1:nrow(vi)){
  ind[[i]] <- aucVIth(i, vi, dates)
}

ind <- as.data.frame(do.call(rbind, ind))
names(ind) <- paste0("evi_", c("vegetative","grain","full"))


# How to compute the indices for GPP and ET?

# Additional considerations
# Compute over raster, zones, masking for crops, crop type