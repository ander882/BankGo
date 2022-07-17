# Web scraping BASH style...
With the Puppeteer and python scripts to do the web scraping, all aspects of the web site was in one file.  
Here, we are going to use a single bash file to controle only ONE PAGE of the web site.  

luckily, each of the banks logically work the same.
* 10 open a new tab and get to the logon page and logon
* 12 wait for the home page.  Check it and get to the page with chash flow details
* 14 wait for the details (all transactions).  Get them.
* 16 one bank doesn't show the full transaction details.  But they allow 'view page source'.  Get it
* 18 logoff and close tab

## Here is the next part of the config file:
```
10-logon:
BankM=BankM
BankB=BankB
BankA=BankA
BankC=BankC

12-home:
BankM=BankM
BankB=BankB
BankA=BankA
BankC=BankC

14-detail:
BankM=BankM
BankB=BankB
BankA=BankA
BankC=BankC

16-source:
BankC=BankC

18-logoff:
BankM=BankM
BankB=BankB
BankA=BankA
BankC=BankC

19-pretext:
BankM=BankM
BankB=BankB
BankA=BankA
BankC=BankC
```

Each of the 4 banks will go through the 10-logon, 12-home, 14-detail, 18-logoff steps. 
With BankC going through an extra 16-source step.  Here is the meat of the 10-logon: script

```
source ${CONFIG[_HOME]}/tasks.d/10-${VALUE}.sh \
       > ${CONFIG[processDir]}/10-${VALUE}.out \
       2> ${CONFIG[processDir]}/10-${VALUE}.err
```

Source is going to call a new script.  And the script name will be 10-(BankA|BankB|BankC|BankM).sh.  
This is where the right hand side of 'BankA=BankA' comes in handy from the config file.  
This script is also in 12-home.sh and all the others.  Just change the 10 to the right value!  And walla!
scripts for each bank for each page.

# 10-(BankA|BankB|BankC|BankM).sh
Ok the meat!  Or just the start.  At this point, we have Chrome open and ready to go.  Lets start
throwing some keys...
Looking at the code we see:
* Check to make sure Chrome is open
* Throw the 'ctrl+t' keys to open a new tab
* we will be in the address bar.  throw the keys for the web page and press enter
* wait for the page to load
* luckly BankA leaves us in the username field.
* Type in the username and password
We are now logged on with about 64 lines of code!

# 12-(BankA|BankB|BankC|BankM).sh
Ok, we have logged on with the previous script.  We will soon be on the home screen.  This is an easier script:
* Make sure chrome is still the active window
* use 'ctrl+a' (select all) and 'ctrl+c' (copy) and xsel (get the clipboard into a var) and check for a specific string that will be on the screen to tell us that the page has been loaded.
* We found the scring?  great.  output it (so it will save to a file) and continue!

# 14-(BankA|BankB|BankC|BankM).sh
We can't click on a link.  But luckily links don't change.  So click on the link and copy the link int he address bar and use that link in this script!  Easy.
* 'ctrl+l" to get to the address bar
* type in the link that gets us to our account transactions page
* use the ctrl+a Ctrl+c trick again to wait for a specific text string showing that the pages is loaded.
* We found the scring?  great.  output it (so it will save to a file) and continue!

# 16-(BankA|BankB|BankC|BankM).sh
for that one bank....
* 'ctrl+u" to get the page source.
* use the ctrl+a Ctrl+c trick again to wait for a specific text string showing that the pages is loaded.
* We found the scring?  great.  output it (so it will save to a file) and continue!
* ctrl+w to close this new page

# 18-(BankA|BankB|BankC|BankM).sh
* 'ctrl+l" to get to the address bar
* type in the link that loggs us off
* use the ctrl+a Ctrl+c trick again to wait for a specific text string showing that the pages is loaded.
* We found the scring?  great.  output it (so it will save to a file) and continue!

And that is it!  We just scraped all of our banks!  WooHoo.  

# 19-(BankA|BankB|BankC|BankM).sh
This is actually a cheat script.  This should be a level 20 (processing) script, but I put it here to remove
about 95% of the fluff in the transaction web page (header/footer info) and just leave the transaction details only (uh, mostly).  And since 3 banks have transaction detail in 14-Bank(A|B|M).out and one has it in 16-BankC.out, we can also push those to a consistant 19-Bank(A|B|C|M).out.
These scripts are fun (grep | sed | cut | tr | tac ) scripts.  Check them out (then leave them).  

Whew!  This is what you came for!  Now we have web scraped data.  Hard to (human) read.  
Lets get to the 20 level of this program and start processing this stuff.


## notes to myself
Now that I have re-written the web scraping code (so I don't give out bank info), I have found that
I am doing the same (about 5) things over and over.  Time to get those things moved out into a library
and simply use those library blocks.  Cleaner and more importantly more consistent code.

