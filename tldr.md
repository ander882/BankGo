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
* * 18 log off
* * all 1x scripts take a copy of the screen and outputs a 1x-Bank?.out file

done.
