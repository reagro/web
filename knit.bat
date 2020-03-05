@ECHO OFF

rem example usage:
rem knit tools
rem knit tools clean
rem knit all 
rem knit all clean 

Rscript.exe --vanilla R\run.R knit %1 %2

:end

