#!/bin/sh
git clone git@github.com:gawel/webtest-2013.git pages
cd pages
git checkout gh-pages
rm -f index.html
../bin/impress -i ../index.rst -o .
git add -A
git commit -m "update docs"
git push origin gh-pages
cd ..
rm -Rf pages
