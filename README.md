# UniExamNotes
Revision notes from uni finals

Basically just an HTML template, and notes are within their own markdown files within a folder of the same name. 

e.g for Advanced Data Structures & Algorithms (ADSA): `ADSA/ADSA.md`

## Makefile
Run the makefile with `make` to recompile the site. 

This just calls `makePage.sh` for each of the folders.


## makePage.sh  
This just calls [Gruber's](https://daringfireball.net/projects/markdown/) markdown script (included) on each Markdown input, converting it into an HTML document with the same name and in the same location.  

Each file then has `makeHTML.sh` called on it. 



## makeHTML.sh

Pretty simple script, takes the input HTML file, uses `sed` to append a head (pretty horrible, should just use `cat`). 
This head points to the CSS `REDTIME.css`. There's also an alternative `BLUTIME.css` that can be subbed in.

## CSS
The HTML is pretty bare bones. All styling happens in the CSS.

The only interesting CSS part is     

```CSS
background-blend-mode: hard-light;
```

Played around with a bunch of different (blend-modes)[https://developer.mozilla.org/en-US/docs/Web/CSS/background-blend-mode] but is generally an easy way to get good-contrast or interesting effects on pictures. 






