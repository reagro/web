# Number of interesting dataset availbale through the fewsnet portal

# first start with CHIRPS 2.0 global layer
# pentadal data by year makes it more managable than other choices

datadir <- "/share/spatial02/users/anighosh/data"
downdir <- file.path(datadir, "chirps")
dir.create(downdir, T, T)

url <- "https://edcintl.cr.usgs.gov/downloads/sciweb1/shared//fews/web/global/pentadal/chirps/final/downloads/yearly/"
years <- seq(1981,2018,1)

for (year in years){
  print(year); flush.console()
  furl <- paste0(url, "chirps_final_pentadal_", year,".zip")
  dfile <- file.path(downdir,basename(furl))
  if(!file.exists(dfile)){
    download.file(furl, dfile, mode = "wb")
  }
}

