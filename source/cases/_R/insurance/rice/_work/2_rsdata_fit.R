##############################################################################################
# Step 1: Gap-fill and smooth the time series
library(agrins)
library(luna)
source("web/source/crops/_work/fill_filter.R")

##############################################################################################
# Step 3: save yearly stack after gap-filling and filtering

# main function

createFilterStack <- function(year, evifiles, ndfifiles, outdir){
  print(year); flush.console();
  # For rice in this region, we are interested in the time period between Oct - Apr
  # first get the tiles that were captured within the time window
  # year <- 2001 # e.g. 2001 means started in 2000 and harvested in 2001
  startDate <- as.Date(paste0(year-1, "-07-01"))
  endDate <- as.Date(paste0(year, "-6-30"))
  
  evf <- evifiles[evifiles$date >= startDate & evifiles$date <= endDate,]
  ndf <- ndfifiles[ndfifiles$date >= startDate & ndfifiles$date <= endDate,]
  
  evirast <- rast(evf$filename)
  ndfirast <- rast(ndf$filename)
  
  fevi <- app(evirast, filterVI, filename = paste0(outdir, "/filter_stack_EVI_",year,".tif"), overwrite = TRUE)
  fndfi <- app(ndfirast, fillVI, filename = paste0(outdir, "/filter_stack_NDFI_",year,".tif"), overwrite = TRUE)
  saveRDS(unique(evf$date), paste0(outdir, "/vi_dates_", year,".rds"))
} 

datadir <- "/share/spatial02/users/anighosh/projects/quiic"
vidir <- file.path(datadir, "tza_rice/vi")

# list hdf files in the folder
# only trying MOD products now
ffmod <- list.files(vidir, pattern = "MOD09A1*", full.names = TRUE, recursive=TRUE)
evi <- grep("_evi.tif$", ffmod, value = TRUE)
ndfi <- grep("_ndfi.tif$", ffmod, value = TRUE)

# create database of evi and ndfi and arrange by dates to create 8-day composite from both MOD and MYD 
# also to make sure files are arrnaged in order
evifiles <- getModisYMD(evi)
evifiles <- evifiles[order(evifiles$date),]

ndfifiles <- getModisYMD(ndfi)
ndfifiles <- ndfifiles[order(ndfifiles$date),]

# unique years
years <- seq(2001,2019,1)

# test
# rr <- createFilterStack(2012, evifiles, ndfifiles, vidir)
# run for all tiles and save individual years
lapply(years, createFilterStack, evifiles, ndfifiles, vidir)

