#!/bin/sh -e
if [ -z "$1" ]; then
	echo "Usage: $0 <version>"
	exit
fi

version=$1
date=`date +%Y-%m-%d`

sed -i 's/^\(Version:\).*$/\1 v'"$version"'/' README
sed -i 's/^\(Last modified:\).*$/\1 '"$date"'/' README
sed -i 's/^\(\\newcommand\*{\\pkgversion}\).*$/\1{v'"$version"'}/' vc-manual.tex

tmpfile=`mktemp`
(
	echo "v$version ($date)"
	echo "----------------------"
	echo "* TODO: Describe the changes here."
	echo
	echo
	cat CHANGES
) > $tmpfile
mv $tmpfile CHANGES
sensible-editor CHANGES

git add CHANGES README vc-manual.tex
git commit -sm "release v$version"

cd git-unix/
./vc -m
mv vc.tex ..
cd ..

pdflatex vc-manual.tex
pdflatex vc-manual.tex

git add vc-manual.pdf
git commit -sm "update manual for version $version"
git tag -sm "release v$version" v$version

git archive -v -o vc-v$version.zip --prefix=vc/ v$version
