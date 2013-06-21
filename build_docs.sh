#!/bin/sh
git clone git@github.com:gawel/pytong2013_webtest.git pages
cd pages
git checkout gh-pages
rm index.html
../bin/impress -i index.rst -o .
git add -A
git commit -m "update docs"
git push origin gh-pages
cd ..
rm -Rf pages
