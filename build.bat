@ECHO OFF

rem example usage:
rem build topcis 
rem build topics pdf
 
rem build all clean
rem build all pdf

set arg1=%1
set arg2=%2

if %arg1% == all (
    Rscript.exe --vanilla R\run.R build all %arg2%
	Rscript.exe --vanilla R\make_site.R clean
) else (
	Rscript.exe --vanilla R\run.R build %arg1% %arg2% 
)

Rscript.exe --vanilla R\check_errors.R 	


:end

