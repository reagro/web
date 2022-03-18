
dopdf <- FALSE
args <- commandArgs(TRUE)
if (length(args) > 0) {
	cmd <- args[1]
	if (cmd == "clean") {
		unlink("_build", recursive=TRUE)
	} else if (cmd == "pdf") {
		dopdf=TRUE
	}
}


if (!dopdf) {
	shell("make html")

	fff <- list.files("_build/html", patt='\\.html$', recursive=TRUE, full=TRUE)
	for (f in fff) {
		d <- readLines(f, warn=FALSE)
		dd <- trimws(d)
		d <- d[dd != ""]
		if (basename(f) != "index.html") {
			d <- gsub("\\.rst\\.txt", ".R.txt", d)
		}
		writeLines(d, f)	
	}

	cat("copying source\n\n")
	f <- list.files("source", patt='\\.txt$', recursive=TRUE, full=TRUE)
	f <- grep("/txt/", f, value=TRUE)
	g <- gsub("txt/", "", f)
	g <- gsub("source/", "", g)
	h <- file.path("_build/html/_sources", g)
	h <- gsub("\\.txt$", ".R.txt", h)
	y <- file.copy(f, h, overwrite=TRUE)

	#cat("copying images\n\n")
	#f <- list.files("source", patt='\\.png$', recursive=TRUE, full=TRUE)
	#g <- file.path("_build/html/images", basename(f))
	#y <- file.copy(f, g, overwrite=TRUE)



	ff <- list.files("_build/html", patt='\\.html$', recursive=TRUE, full=TRUE)

	ignore_errors <- c('Error in quefts_crop(name = "x"))')

	txtin <-  'R.txt" rel="nofollow"> View page source</a>'
	txtout <- 'R.txt" rel="nofollow"> <em>R</em> code</a>'

	for (f in ff) {
		x <- readLines(f, warn=FALSE)
		i <- grep("## Error", x)
		if (length(i) > 0) {
			if (substr(f, 1, 33) %in% ignore_errors) {
				if (length(i) < 5) next
			}
			print(f)
			print(head(x[i]))
			cat("----\n\n")
		}
		x <- gsub(txtin, txtout, x)
		writeLines(x, f)	
	
	}



} else { #if (dopdf) {
	print("dopdf")

	if (tolower(Sys.info()["sysname"])=="windows"){
		sysfun <- shell
	} else {
		sysfun <- system		  
	}

	sites <- list.files("source", full=TRUE)
	sites <- sites[!grepl("\\_", sites)]
	sites <- sites[!grepl("\\.", sites)]
	wd <- getwd()
	for (site in sites) {
		setwd(wd)
		cat("\n\n===================================\n")
		cat(site)
		cat("\n-----------------------------------\n")
		setwd(site)
		x <- sysfun("make latexpdf", intern = TRUE)
		cat("\n\n-----------------------------------	\n")
	}
	setwd(wd)
	#shell("make latexpdf")
	cat("copying pdfs\n\n")
	f <- list.files("source", patt='.pdf$', recursive=TRUE, full=TRUE)
	if(length(f) < 6) {warning("pdf files missing")}
	g <- gsub("/_build/latex", "", f)
	g <- gsub("source/", "", g)
	h <- file.path("_build/html", g)
	x <- sapply(h, function(f) dir.create(dirname(f), FALSE, TRUE))
	y <- file.copy(f, h, overwrite=TRUE)
	stopifnot(all(y))
}

