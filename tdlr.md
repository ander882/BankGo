# Too long my butt!

But here it is.

## I use Bashmanager as a task runner.  
Break everything into small parts.  In the ./config.d/bankgo.txt file you will see the entire program in all of it's little parts.

## I use a numbering system
Each of the programs are numbered 00-99.  0x files run before the 1x programs.  Followed by the 2x programs.  
Note that not all banks use all programs (one bank has an extra step)

## 1x programs are where it is at!
* These programs are the web scraping programs.  
* Each program takes care of one web page only!  
* Each step (10, 12, 14, 18) corresponds to the following pages (logon, home page, transaction details, log off).  

## everything else
Pages with numbers less than 1x are for initalization.  After that:
* 2x are for web page processing
* 3x database backup and import new info
* 8x reports
* 9X shutdown

## each program tries to use pipelines
except for 1x programs, All of the programs take in an input and output the result.  
As such, 
* web scraping just outputs .out files for the page it takes care of.
* 2x scripts will take previous files and output a 2x... file
* 3x uses 2x output files as input and outputs 3x files

done.
