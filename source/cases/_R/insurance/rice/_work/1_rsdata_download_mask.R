library(agrins)

# source("web/source/yield/_work/fill_filter.R")

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Step 1
# Add download of MODIS data
# datadir <- file.path(dirname(tempdir()), "agrins/modis")
# dir.create(datadir, recursive=TRUE, showWarnings=FALSE)

library(luna)

# Download folder
datadir <- "/share/spatial02/users/anighosh/projects/quiic"
moddir <- file.path(datadir,"tza_rice/raw")
dir.create(moddir, T, T)

# zone boundaries
aoi <- data_rice("zones")

# dates to download MODIS data
start <- "2000-01-01"
end <- Sys.Date()

# Reflectance, Gross Primary Productivity (GPP), FPAR & LAI, gap-filled ET, 
mods <- c("MOD09A1","MOD17A2H", "MOD15A2H", "MOD16A2")
myds <- c("MYD09A1","MYD17A2H", "MYD15A2H", "MYD16A2")

# getModis("MYD15A2H", start, end, aoi=aoi, download = TRUE, path = moddir)

lapply(mods, getModis, start, end, aoi, download=TRUE, path=moddir)
lapply(myds, getModis, start, end, aoi, download=TRUE, path=moddir)

# check download status
filesByyear <- function(prod, dir){
  ff <- list.files(path = dir, pattern = prod)
  dt <- sapply(strsplit(ff, "\\."), '[[', 2)
  yr <- substr(dt, 2, 5)
  return(table(yr))
}

lapply(mods, filesByyear, moddir)
lapply(myds, filesByyear, moddir)

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Step 2
library(agrins)
library(luna)
# Quality Mask and process the MOD09A1 data
# table 13 in https://lpdaac.usgs.gov/documents/306/MOD09_User_Guide_V6.pdf 
se <- matrix(c(1,2,3,6,11,11,12,14,16,16), ncol=2, byrow=TRUE)
reject <- list(c("10", "11"), c("1100","1101","1110","1111"), "1", c("000","110","111"), "11")

getVI <- function(i, mfiles, pols, vidir) {
  # first we specify output filename
  evifile <- gsub(".hdf$", "_evi.tif", basename(mfiles[i]))
  ndfifile <- gsub(".hdf$", "_ndfi.tif", basename(mfiles[i]))
  
  evifile <- file.path(vidir, evifile)
  ndfifile <- file.path(vidir, ndfifile)
  
  if(!(file.exists(evifile)|file.exists(ndfifile))){
    # read hdf file
    r <- rast(mfiles[i])
    # plotRGB(r, r = 1, g = 4, b = 3, stretch="lin")
    
    # to make the process fast
    # Clip the image using AOI before other calculations
    r <- crop(r, pols)
    
    # Generate quality mask
    quality_mask <- modis_mask(r[[12]], 16, se, reject)
    
    # band index for this product
    # red = b01; nir = b02; blue = b03; swir1 = b06
    r <- r[[c(1:3, 7)]]
    names(r) <- c("red", "nir", "blue", "swir2")
    
    # Mask out bad quality pixels
    r <- mask(r, quality_mask)
    
    # Ensure all data lies between 0 & 1 
    r <- clamp(r, 0, 1) 
    
    # Compute vegetation indices
    
    # Enhanced vegetation index (EVI), instead of NDVI
    evi <- 2.5*((r$nir - r$red)/(r$nir + (6*r$red)-(7.5*r$blue)+1))
    # Normalized difference flood index, instead of LSWI
    ndfi <- (r$red - r$swir2)/(r$nir + r$swir2)
    
    writeRaster(evi, filename = evifile, overwrite = TRUE)
    writeRaster(ndfi, filename = ndfifile, overwrite = TRUE)
    cat(basename(fmod[i]), "\n"); flush.console();
  } else {
    cat(basename(fmod[i]), " already processed\n"); flush.console();
  }
}

# setup directory structure
datadir <- "/share/spatial02/users/anighosh/projects/quiic"
moddir <- file.path(datadir,"tza_rice/modis")
vidir <- file.path(datadir, "tza_rice/vi")
dir.create(vidir, TRUE, TRUE)

# list hdf files in the folder
ffmod <- list.files(moddir, pattern = "*.hdf", full.names = TRUE, recursive=TRUE)
fmod <- grep("MOD09A1|MYD09A1", ffmod, value = TRUE)
# table(substr(basename(fmod), 10, 13))

# 
aoi <- data_rice("zones")
prj <- "+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +a=6371007.181 +b=6371007.181 +units=m +no_defs"
pols <- project(aoi, prj)

# for one file
# getVI(1694, fmod, pols, vidir)

# run all
# lapply(1:3, getVI, fmod, pols, vidir)

# run in parallel
parallel::mclapply(1:length(fmod), getVI, fmod, pols, vidir, mc.cores = 6, mc.preschedule = FALSE)

# in case removing files required
# ff <- list.files(vidir, full.names = TRUE)
# ff <- grep("MOD09A1|MYD09A1", ff, value = TRUE)
# file.remove(ff)

# how many finished the analysis
lapply(c("MOD09A1","MYD09A1"), filesByyear, vidir)

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Prepare GPP
library(agrins)
library(luna)

# https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MOD17A2H
# search "Description: QC (quality control) flags for Psn_500M biophysical variable"
se <- matrix(c(1,1,4,5), ncol=2, byrow=TRUE)
reject <- list("1",c("01","10"))


getGPP <- function(i, mfiles, pols, vidir) {
  # first we specify output filename
  gppfile <- gsub(".hdf$", "_gpp.tif", basename(mfiles[i]))
  
  gppfile <- file.path(vidir, gppfile)
  
  if(!file.exists(gppfile)){
    # read hdf file
    r <- rast(mfiles[i])
    # plotRGB(r, r = 1, g = 4, b = 3, stretch="lin")
    
    # to make the process fast
    # Clip the image using AOI before other calculations
    r <- crop(r, pols)
    
    # Generate quality mask
    quality_mask <- modis_mask(r[[3]], 8, se, reject)
    
    # band index for this product
    # red = b01; nir = b02; blue = b03; swir1 = b06
    r <- r[[1]]
    names(r) <- c("gpp")
    # Mask out bad quality pixels
    r <- mask(r, quality_mask)
    
    writeRaster(r, filename = gppfile, overwrite = TRUE)

    cat(basename(mfiles[i]), "\n"); flush.console();
  } else {
    cat(basename(mfiles[i]), " already processed\n"); flush.console();
  }
}

# setup directory structure
datadir <- "/share/spatial02/users/anighosh/projects/quiic"
moddir <- file.path(datadir,"tza_rice/modis")
vidir <- file.path(datadir, "tza_rice/vi")
dir.create(vidir, TRUE, TRUE)

# list hdf files in the folder
ffmod <- list.files(moddir, pattern = "*.hdf", full.names = TRUE, recursive=TRUE)
fmod <- grep("MOD17A2H|MYD17A2H", ffmod, value = TRUE)
# table(substr(basename(fmod), 10, 13))

# get zone boundaries
aoi <- data_rice("zones")
prj <- "+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +a=6371007.181 +b=6371007.181 +units=m +no_defs"
pols <- project(aoi, prj)

# for one file
# getGPP(900, fmod, pols, vidir)

# run all
# lapply(1:3, getGPP, fmod, pols, vidir)

# run in parallel
parallel::mclapply(1:length(fmod), getGPP, fmod, pols, vidir, mc.cores = 6, mc.preschedule = FALSE)

# how many finished the analysis
lapply(c("MOD17A2H","MYD17A2H"), filesByyear, vidir)



#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Prepare ET
library(agrins)
library(luna)

# page 21 of https://ladsweb.modaps.eosdis.nasa.gov/missions-and-measurements/modis/MOD16_ET_User-Guide_2017.pdf
# Same from LAI/FPAR and GPP
se <- matrix(c(1,1,4,5), ncol=2, byrow=TRUE)
reject <- list("1",c("01","10"))

getET <- function(i, mfiles, pols, vidir) {
  # first we specify output filename
  etfile <- gsub(".hdf$", "_et.tif", basename(mfiles[i]))
  
  etfile <- file.path(vidir, etfile)
  
  if(!file.exists(etfile)){
    # read hdf file
    r <- rast(mfiles[i])
    # plotRGB(r, r = 1, g = 4, b = 3, stretch="lin")
    
    # to make the process fast
    # Clip the image using AOI before other calculations
    r <- crop(r, pols)
    
    # Generate quality mask
    quality_mask <- modis_mask(r[[5]], 8, se, reject)
    
    # band index for this product
    # red = b01; nir = b02; blue = b03; swir1 = b06
    r <- r[[1]]
    names(r) <- c("et")
    # Mask out bad quality pixels
    r <- mask(r, quality_mask)
    
    # ET more than 1500 doesn't make that much sense, but how can we mask it?
    
    writeRaster(r, filename = etfile, overwrite = TRUE)
    
    cat(basename(mfiles[i]), "\n"); flush.console();
  } else {
    cat(basename(mfiles[i]), " already processed\n"); flush.console();
  }
}

# setup directory structure
datadir <- "/share/spatial02/users/anighosh/projects/quiic"
moddir <- file.path(datadir,"tza_rice/modis")
vidir <- file.path(datadir, "tza_rice/vi")
dir.create(vidir, TRUE, TRUE)

# list hdf files in the folder
ffmod <- list.files(moddir, pattern = "*.hdf", full.names = TRUE, recursive=TRUE)
fmod <- grep("MOD16A2|MYD16A2", ffmod, value = TRUE)
# table(substr(basename(fmod), 10, 13))

# get zone boundaries
aoi <- data_rice("zones")
prj <- "+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +a=6371007.181 +b=6371007.181 +units=m +no_defs"
pols <- project(aoi, prj)

# for one file
# getET(900, fmod, pols, vidir)

# run all
# lapply(1:3, getET, fmod, pols, vidir)

# run in parallel
parallel::mclapply(1:length(fmod), getET, fmod, pols, vidir, mc.cores = 6, mc.preschedule = FALSE)

# how many finished the analysis
lapply(c("MOD17A2H","MYD17A2H"), filesByyear, vidir)

