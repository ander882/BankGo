# Too long my butt!

But here it is.


## I use Bashmanager as a task runner.  
* Break everything into small parts.  Run them in a pipeline.
* In the ./config.d/bankgo.txt file you will see the entire program in all of it's little parts.


## I use a simple program numbering system
Each of the programs are numbered 00-99.  
* 0x are Initalization scripts.  Ran before the 1x scripts.
* 1x are the web scraping scripts
* 2x text processing scripts.  Uses 1x info.
* 3x database scripts.  Uses 2x info.
* 8x reports.
* 9x shutdown


## 1x programs are where it is at!
* These programs are the web scraping programs.  
* Each program takes care of one web page only!  
* * 10 logon
* * 12 bank home screen
* * 14 bank transaction detail
* * 16 Page source of 14.  One bank allows/uses it.  
* * 18 log off
* * all 1x scripts take a copy of the screen and outputs a 1x-Bank?.out file

### 10-scrape-lib.sh
the main library on how to see the web page.  Uses xdotool to throw keys into Chrome to get the following:
* Ctri-a to select all the page
* Ctrl-c to copy it all into clipboard
* Ctrl-v to coppy the clipboard to Chrome
* xsel to get the clipboard into a variable or save to file
* Ctrl-l to get into address bar
* a couple of other keys.
* This is how we control Chrome.  Throw keystrokes at it and read from the clipboard
* * Basic and works.

done.
