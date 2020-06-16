
libfun <- function(x) {
	d <- readLines(x, warn=FALSE)
	i <- grep('^library\\(', d)
	j <- grep('^require\\(', d)
	d[unique(c(i,j))]
}

f <- list.files("source", patt='\\.rmd$', recursive=TRUE, full=TRUE, ignore.case=TRUE)
pkgs <- unique(unlist(sapply(f, libfun)))
pkgs <- pkgs[nchar(pkgs) < 100]
pkgs <- gsub("library\\(", "", pkgs)
pkgs <- trimws(gsub(")", "", pkgs))
pkgs <- sort(unique(c(pkgs, c("raster"))))
pkgs <- gsub('\"', "", pkgs)
#pkgs <- pkgs[!(pkgs=='rspatial')]


if(!require(remotes)) install.packages("remotes")
if(!require(agro)) remotes::install_github("reagro/agro")
if(!require(agrodata)) remotes::install_github("reagro/agrodata")	
if(!require(luna)) remotes::install_github("rspatial/luna")
if(!require(predicts)) remotes::install_github("rspatial/predicts")
if(!require(geodata)) remotes::install_github("rspatial/geodata")
if(!require(Recocrop)) remotes::install_github("cropmodels/Recocrop")
if(!require(phenorice)) remotes::install_github("cropmodels/phenorice")



ipkgs <- rownames(installed.packages())
for (pk in pkgs) {
  if (!(pk %in% ipkgs)) {
	print(paste("installing", pk))
    install.packages(pkgs=pk, repos="https://cloud.r-project.org/", quiet=TRUE)
    library(pk, character.only=TRUE)
  }
}

#if (!("agscale" %in% ipkgs)) {
#	devtools::install_github('rhijmans/agscale')
#}




