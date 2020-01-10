dir <- "G:/My Drive/biogeo/QUIIC/Trainings/Workshop3/case-studies/rice/MODIS/pheno"

ef <- list.files(path = dir, pattern = "*evi_rice_*", full.names = TRUE)
nf <- list.files(path = dir, pattern = "*ndfi_rice_*", full.names = TRUE)

year <- 2012

evi <- readRDS(grep(year, ef, value = TRUE))
ndfi <- readRDS(grep(year, nf, value = TRUE))
head(evi)

i <- 2
par(ask = TRUE)
dt <- as.Date(evi[1,-1])
for (i in 2:nrow(evi)){
  print(i)
  e <- as.numeric(evi[i,-1])
  n <- as.numeric(ndfi[i,-1])
  plot(dt,e, col = "green", type = "l")
  points(dt,n, col = "blue")
}

# sourcing from phenorice package
source("phenoRice.R")
p <- getPars()
phenorice(e,n,p)
