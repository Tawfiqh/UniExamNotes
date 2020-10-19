#!/bin/bash

# $1 is the first argument - name of folder/filename.hmtl
# $2 is the <title> of the html

sed -ie "1i\\
<!DOCTYPE html> \\
<html> \\
<head> \\
<meta charset = "UTF-8"> \\
<link rel=\"stylesheet\" type=\"text/css\" href=\"../REDTIME.css\"> \\
<link rel=\"shortcut icon\" href=\"../favicon.ico\"> \\
<title> $2 </title> \\
</head><body><div id=\"divback\"></div><div id=\"main\"><h3><a href=\"../index.html\"> &larr; Home </a></h3>\\
" ./$1/$1.html


sed -ie "\$a\\
</div></body></html>\\
" ./$1/$1.html

rm ./$1/$1.htmle
