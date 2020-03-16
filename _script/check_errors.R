
ff <- list.files("build/html", patt='\\.html$', recursive=TRUE, full=TRUE)

known_errors <- c("")

for (f in ff) {
	x <- readLines(f, warn=FALSE)
	i <- grep("## Error", x)
	if (length(i) > 0) {
		if (f %in% known_errors) {
			if (length(i) < 5) next
		}
		print(f)
		print(head(x[i]))
		cat("----\n\n")
	}
}

