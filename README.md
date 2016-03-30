# README

This template describes how you can write your studies paper completely in Markdown. No Latex, no Microsoft Word, just Markdown with some CSS and HTML mixed in.

#### Motivation

I wanted to see if it is possible to write a bachelor thesis in Markdown. I also considered the existing approaches via Latex too cumbersome.

#### Disclaimer

This is pretty much a Mac-only workflow since MacDown is only available for Mac. 

#### Features

- Your complete paper is inside one Markdown-document.
- Citations (markdown links) are automatically coallated at the end of the document
- Three types of annotations for code (`<h7>`), images (`<h8>`), and tables (`<h9>`) which are also coallated at the end of the document (of course you can use it for other types of content as well)
- With the javascript code in **paper.md** you can control what gets enumarated and how.
- Live preview inside MacDown
- Because this is Markdown you can use git or subversion for version control
- IEEE citation style

#### Prerequisites

- [wkhtmltopdf](http://wkhtmltopdf.org) needs to be installed. I used version **wkhtmltopdf 0.12.3 (with patched qt)**.
- Ruby needs to be installed with the Nokogiri-Gem (`sudo gem install nokogiri`)
- Six local files: 
  - paper.md (with specific Javascript at the end)
  - header.html
  - footer.html
  - fix-toc.rb
  - bash.sh
  - printSource.js
- [MacDown](http://macdown.uranusjr.com) for Markdown editing (it might also work with Mou but I haven't tested it.)
- PhantonJS as a command line utility, when using the *automated* workflow (`npm install phantom phantomjs -g`)
- A special CSS-File ('Studies Paper (based on Github2).css') with the necessary formatting which must be put in the following folder: /Users/your-account/Library/Application Support/MacDown/Styles

#### Citation guidelines

- Normal Markdown links are turned into IEEE citations:
  ```[Google](http://www.google.com "This is the description of the citation")```
  is turned into: ```Google [1]``` within the text.
  And at the end gets referenced like this: ```[1] This is the description of the citation```
  
  
#### Custom Tags

- Tags ```<h7>, <h8>, <h9>``` are used for three different types of code, image or table annotations, which are automatically numbered and added at the end of the paper
- A page-break can be forced like this: ```<page-break/>```


#### How to create your paper from Markdown (automated)

- Clone this repository to your computer
- Open your **.md-file** in MacDown
- Export this file to HTML (.html) including styles and syntax highlighting
- run `./bash.sh yourInput.html yourOutput.pdf` from the command line
- A new PDF is created with the file-name **yourOutput.pdf**
- DONE

#### How to create your paper from Markdown (manually)

- Open **paper.md** in MacDown
- Export HTML to **paper.html** including styles and syntax highlighting
- From the command line, run the following command:
   
   ```wkhtmltopdf --dump-outline toc.xml --header-html header.html --footer-html footer.html paper.html paper.pdf```
   
   This will generate two files: **toc.xml** (which contains the table of contents of all the H1, H2, H3,... elements) and **paper.pdf** .

- Open the newly created **paper.html** in your favourite browser (e.g. Safari) and copy the rendered HTML output. This is importent! You don't just want the source code but rather the ***rendered HTML source code*** and save it as **browser-output.html** in the same directory.  
**Don't forget to also copy the <!DOCTYPE html>!**

- Run the ruby script **fix-toc.rb**, which takes the **toc.xml** and **browser-output.html** and fixes the page numbers in the table of content and saves it as a new file named **browser-output-fixed-toc.html**.

- From the command line, run the following command:

   ```wkhtmltopdf --header-html header.html --footer-html footer.html browser-output-fixed-toc.html paper.pdf```