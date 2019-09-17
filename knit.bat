@ECHO OFF

rem example usage:
rem knit tools
rem knit tools clean
rem knit all 
rem knit all clean 

set arg1=%1
set arg2=%2

if %arg1% == all (
	for %%i in (data tools recipes cases) do Rscript.exe --vanilla R\run.R knit %%i %arg2%
) else (
	Rscript.exe --vanilla R\run.R knit %arg1% %arg2%
)

:end

