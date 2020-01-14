@ECHO OFF

rem example usage:
rem build topcis 
rem build topics pdf
 
rem build all clean
rem build all pdf

rem set arg1=%1
rem set arg2=%2

rem if %arg1% == all (
rem     Rscript.exe --vanilla R\run.R build all %arg2%
rem 	Rscript.exe --vanilla R\make_site.R clean
rem ) else (
rem 	Rscript.exe --vanilla R\run.R build %arg1% %arg2% 
rem )

Rscript.exe --vanilla R\make_site.R clean
Rscript.exe --vanilla R\check_errors.R 	


:end

