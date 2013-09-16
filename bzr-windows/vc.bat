@echo off
REM This is file 'vc.bat' from the vc bundle for TeX.
REM The original file can be found at CTAN:support/vc.
REM This file is Public Domain.

setlocal
REM Parse command line options.
set full=0
set mod=0
:loopParams
if "%1" NEQ "" (
  if "%1"=="-f" (set full=1) else if "%1"=="-m" (set mod=1) else (
    echo usage: vc [-f] [-m]
    exit /b 1
  )
  shift
  goto loopParams
)
REM English locale.
set LC_ALL=C
if "%mod%"=="1" (
  bzr version-info --check-clean|gawk -v full=%full% -f vc-bzr.awk > vc.tex
) else (
  bzr version-info |gawk -v full=%full% -f vc-bzr.awk > vc.tex
)
