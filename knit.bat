@ECHO OFF

rem example usage:
rem knit 
rem knit tools
rem knit data clean
rem knit all clean 

Rscript.exe --vanilla _script\run.R knit %1 %2

:end

