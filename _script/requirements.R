
libfun <- function(x) {
	d <- readLines(x, warn=FALSE)
	i <- grep('^library\\(', d)
	d[unique(i)]
}

f <- list.files("source", patt='\\.rmd$', recursive=TRUE, full=TRUE, ignore.case=TRUE)
pkgs <- unique(unlist(sapply(f, libfun)))
pkgs <- pkgs[nchar(pkgs) < 100]
pkgs <- gsub("library\\(", "", pkgs)
pkgs <- trimws(gsub(")", "", pkgs))
pkgs <- sort(unique(pkgs))
pkgs <- gsub('\"', "", pkgs)

ipkgs <- rownames(installed.packages())

if (!require("remotes", quietly = TRUE)) install.packages("remotes", repos="https://cloud.r-project.org/")
gpkgs <- c("luna", "geodata", "predicts", "rspat")
for (pk in gpkgs) {
	if (!(pk %in% ipkgs)) {
		remotes::install_github(paste0("rspatial/", pk))
	}
}
gpkgs <- c("agro", "agrodata")
for (pk in gpkgs) {
	if (!(pk %in% ipkgs)) {
		remotes::install_github(paste0("reagro/", pk))
	}
}
gpkgs <- "phenorice"
for (pk in gpkgs) {
	if (!(pk %in% ipkgs)) {
		remotes::install_github(paste0("cropmodels/", pk))
	}
}

ipkgs <- rownames(installed.packages())
for (pk in pkgs) {
  if (!(pk %in% ipkgs)) {
	print(paste("installing", pk))
    install.packages(pkgs=pk, repos="https://cloud.r-project.org/", quiet=TRUE)
  }
}

