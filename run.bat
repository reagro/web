@ECHO OFF

rem example usage:
rem run knit intr 
rem run build intr 
rem run build intr pdf 
rem run knit all 
rem run build all 

set arg1=%1
set arg2=%2
set arg3=%3

Rscript.exe --vanilla _script\run.R %arg1% %arg2% %arg3%


:end
