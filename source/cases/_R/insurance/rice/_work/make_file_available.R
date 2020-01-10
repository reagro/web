# put raster in zipped files in public folder
source("web/source/crops/_work/fill_filter.R")

# files for specific time period and collections
createZips <- function(year, prod, indir, zdir){
  if(missing(year)){
    year <- c(2000, 2019)
  } else if (length(year)==1){
    year <- rep(year, 2)
  }
  print(year)
  startDate <- as.Date(paste0(year[1], "-01-01"))
  endDate <- as.Date(paste0(year[2], "-12-31"))
  
  # list files for specific product
  ffmod <- list.files(indir, pattern = prod, full.names = TRUE, recursive=TRUE)
  
  files <- getModisYMD(ffmod)
  # make sure files are arrnaged in order, why is it necessary?
  files <- files[order(files$date),]
  
  tozip <- files[files$date >= startDate & files$date <= endDate, "filename"]
  
  # save in the public dir
  zout <- file.path(zdir, paste("tza_rice", prod, year[1], year[2], "vi.zip", sep ="_"))
  zip(zipfile = zout, files = tozip, flags = "-j")
}

# where to put
pdir <- "/share/spatial02/library/public"
zdir <- file.path(pdir, "qweb")
dir.create(zdir, T, T)

# list files we need, zip and place in qdir
datadir <- "/share/spatial02/users/anighosh/projects/quiic"
vidir <- file.path(datadir, "tza_rice/vi")

createZips(prod = "MOD09A1", indir = vidir, zdir = zdir)
createZips(prod = "MOD16A2", indir = vidir, zdir = zdir)
createZips(prod = "MOD17A2H", indir = vidir, zdir = zdir)

createZips(prod = "MYD09A1", indir = vidir, zdir = zdir)
createZips(prod = "MYD16A2", indir = vidir, zdir = zdir)
createZips(prod = "MYD17A2H", indir = vidir, zdir = zdir)