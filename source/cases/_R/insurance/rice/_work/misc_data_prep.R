Sys.info()["nodename"]
# nodename 
# "ESP-RH-7795"

# creating spatial database of the rice plots from the data shared by Jon Einar
# only saving fid and lat-lon; origin data can't be shared due to PII issues

library(sf)
d <- read.csv("G:/My Drive/biogeo/data/insurance/jon_einar/tza_ken/yield_recall_combined.csv", stringsAsFactors = FALSE) 
d <- d[d$dataset == "TZ Makindube Rice",]

d1 <- d[, c("fid","longitude_plot","latitude_plot", "ward_nm", "village_nm", "subvillage_nm")]
d1 <- d1[complete.cases(d1),]
d1 <- d1[!(duplicated(d1[c("longitude_plot","latitude_plot")])),]

library(sf)
sd1 <- st_as_sf(d1, coords = c("longitude_plot","latitude_plot"), crs = 4326, agr = "constant")
st_write(sd1, "G:/My Drive/biogeo/data/insurance/jon_einar/tza_ken/makindube_locations.shp")

v <- read.csv("G:/My Drive/biogeo/QUIIC/Trainings/Workshop1/Practicals/Data/Makindube_data_with_pred.csv", stringsAsFactors = FALSE)
length(unique(v$fid))


# random points to test phenorice model
datadir <- "/share/spatial02/users/anighosh/projects/quiic"
vidir <- file.path(datadir, "tza_rice/vi")

r <- raster(paste0(vidir, "/filter_stack_NDFI_",year,".tif"))
set.seed(1)
v <- sampleRandom(r, 200, sp = TRUE)
plot(v, add = T)
v$ID <- 1:nrow(v)
v$filter_stack_NDFI_2012 <- NULL
shapefile(v, paste0(datadir, "/tza_rice/vector/random_points.shp"), overwrite = TRUE)
