@ECHO OFF

Rscript.exe --vanilla _script\make_site.R clean
Rscript.exe --vanilla _script\check_errors.R 	

:end

