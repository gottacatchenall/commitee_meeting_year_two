#! /usr/bin/bash


mkdir -p tmp
cd tmp

cp ../references.bib .
cp ../.assets/bibliography.py .
cp ../.assets/header.tex .


cp -r ../figures .
pandoc references.bib -t csljson -o references.json
python3 bibliography.py


pandoc ../report.md \
    -s \
    -F \
    ~/apps/pandoc-crossref --citeproc \
        --bibliography=references.json \
        -H header.tex \
        -o report.tex


pdflatex report.tex

mv report.pdf ..
cd ..

rm -rf tmp
