@echo off

title Conversion of  ALTO files to HTML.(ALTO tags are handled) 

if %1"O" EQU "O" goto erreur

IF NOT EXIST %1 GOTO dossierMq

set dirSortie=HTML

:start
echo Welcome, %USERNAME%


set monoption=-exec

echo. 
:debut
cd %1
for  /d %%a IN (*) do (
  echo. 
  echo Processing of document %%a
  echo. 
  cd %%a
  IF NOT EXIST %dirSortie%  MKDIR %dirSortie%
 for  /f  %%x IN ('dir /b X\*.xml') do (
    echo %%~nx
    
    @REM  ALTO processing with xalan-java
    call ..\..\xslt.cmd X\%%x ..\..\XSL\ALTO2HTML.xsl  %dirSortie%\%%~nx html %%a %monoption%
    
  )
  cd ..
)  
cd ..
goto fin

:erreur
@echo Use: %0 folder_name   
goto fin


:dossierMq
@echo Folder %1 doesn't exist!
goto fin

:fin
echo.


