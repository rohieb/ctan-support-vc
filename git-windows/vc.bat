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
git --no-pager log -1 HEAD --pretty=format:"Hash: %H%nAbr. Hash: %h%nParent Hashes: %P%nAbr. Parent Hashes: %p%nAuthor Name: %an%nAuthor Email: %ae%nAuthor Date: %ai%nCommitter Name: %cn%nCommitter Email: %ce%nCommitter Date: %ci%n" |gawk -v script=log -v full=%full% -f vc-git.awk > vc.tex
if "%mod%"=="1" (
  git status --porcelain=v1 |gawk -v script=status -f vc-git.awk >> vc.tex
)
