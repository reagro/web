@ECHO OFF

rem example usage:
rem knit 
rem knit tools
rem knit data clean
rem knit all clean 

Rscript.exe --vanilla _script\knit_site.R %1 %2

:end

