#! /usr/bin/bash


mkdir -p tmp
cd tmp

cp ../references.bib .
cp ../.assets/bibliography.py .
cp ../.assets/header.tex .

pandoc references.bib -t csljson -o references.json
python3 bibliography.py


pandoc ../report.md \
    -s -o report.tex \
    -F \
    ~/apps/pandoc-crossref --citeproc \
        --bibliography=references.json \
        -H header.tex

pdflatex report.tex

mv report.pdf ..
cd ..

rm -rf tmp
