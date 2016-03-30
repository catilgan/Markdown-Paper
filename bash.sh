#!/bin/bash
cd "$(dirname "$0")"

# The generation of paper.html could also be automated with the following line
# but produces different output than the MacDown Editor 
# pandoc -f markdown_github -s paper.md -c "Studies Paper (based on Github2).css" -o paper.html

if [ -z "$1" ]; then
	echo "input-file (.html) can't be empty!"
	exit
fi
if [ -z "$2" ]; then
	echo "iutput-file (.pdf) can't be empty!"
	exit
fi
if [ ! -f $1 ]; then
    echo "Input HTML-File '$1' not found!"
	exit
fi
if [ ! -f footer.html ]; then
    echo "footer.html not found!"
	exit
fi
if [ ! -f header.html ]; then
    echo "header.html not found!"
	exit
fi

wkhtmltopdf --dump-outline .toc.xml --header-html header.html --footer-html footer.html $1 .tmp.pdf

phantomjs printSource.js $1 > .browser-output.html

ruby fix-toc.rb

wkhtmltopdf --header-html header.html --footer-html footer.html .browser-output-fixed-toc.html $2

echo "----------------------"
echo "Removing Temp files..."

rm .browser-output-fixed-toc.html
rm .browser-output.html
rm .toc.xml
rm .tmp.pdf

echo "----------------"
echo "We are finished!"

open $2