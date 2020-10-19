#!/bin/bash
perl ./Markdown_1.0.1/Markdown.pl ./$1/$1.md > ./$1/$1.html
./makeHTML.sh $1 $1
