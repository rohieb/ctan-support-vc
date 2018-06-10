@echo off
REM This is file 'vc.bat' from the vc bundle for TeX.
REM The original file can be found at CTAN:support/vc.
REM This file is Public Domain.

setlocal
REM Parse command line options.
set mod=0
:loopParams
if "%1" NEQ "" (
  if "%1"=="-m" (set mod=1) else (
    echo usage: vc [-m]
    exit /b 1
  )
  shift
  goto loopParams
)
REM English locale.
set LC_ALL=C

hg log --pager=off -r . --template "Hash: {node}\nAbr. Hash: {node|short}\nBranch: {branch}\nParent1 Hash: {p1node}\nParent2 Hash: {p2node}\nAbr. Parent1 Hash: {p1node|short}\nAbr. Parent2 Hash: {p2node|short}\nAuthor Name: {author|user}\nAuthor Email: {author|email}\nAuthor Date: {date|isodatesec}" | gawk -v script=log -f vc-hg.awk > vc.tex

if "%mod%"=="1" (
  hg status --pager=off | gawk -v script=status -f vc-hg.awk >> vc.tex
)
