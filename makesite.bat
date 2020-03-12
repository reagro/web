@ECHO OFF


Rscript.exe --vanilla _script\requirements.R
Rscript.exe --vanilla _script\run.R knit all clean
Rscript.exe --vanilla _script\make_site.R clean
Rscript.exe --vanilla _script\check_errors.R 	

