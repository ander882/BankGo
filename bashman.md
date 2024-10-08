The code that runs it all...

[BashManager](https://github.com/lingtalfi/bashmanager)


My googlefu was not not all that good at the time (2018?) and I didn't know to search for 'task runner'...  
But alas, I found Bashmanager and I latched on.
I'd also like to know if I can have one config file call another config file.  Not really needed as you can see how I seperate things out here.

# Directory Structure
* bashman - Holds the actual bashmanager code
* config.d/bankgo.txt - Where to store the runner script (BashMagager needed)
* task.d/ - Where to store the tasks to run (BashMagager needed)
* * 3 tasks are shown below (02-g-start.sh, 03-open.sh, and 05-l-start.sh)
* db/ - Where I store my database files (Mostly .tsv)
* db/backup - Backups of the database files
* process/ - where I store intermediate processing files

# The config file
The first three sections of the config.d/bankgo.txt looks like this:
```
# Non Descructive init
02-g-start:
start=start

# Descructive init
025-g-start:
start=start

# Open the web browser
03-open:
start=start

# Bank Specific init
05-l-start:
BankM=BankM
BankB=BankB
BankA=BankA
BankC=BankC
rept=rept

...
```
# How to read the config file
The config file is setup as the following:
* Tasks (Colon lines) are the tasks (programs) that each process CAN go through
* * Not all process' go through all tasks
* Processes.  There are currently 7 processes (start, rept, the 4 banks, and end)
* * Processes will not do all tasks.  

Easy right?  Lest break it down.  BashManager opens the config file and starts reading.  
* The start process is the first process it finds so it is the first to go.  The start process is ran on the first two tasks and then we don't see it again.  it completes.  Just 2 bits of initalization and it is done.
* BankM is the next process.  Goody a bank.  Lets run this process all the way through.  The first two tasks don't ask for it so they are not run.  But nearly all the rest of the tasks are.  So each each task (program) is ran that has BankM in order.  A couple at the end don't ask for banks (later).
* The next 3 banks are ran in order the same way.  One by one.
* Finally the rept process is ran at 05-l-start (local init start) and then we don't see it again until the very end where some final reporting is done.
* Read this a second time to understand it better.

Again from a different perspective.
* 02-g-start: is a global start.  It only needs to run once to do initial setup.  This is why the start process is the only one to go through it.  And since it is at the top, it runs first.
* 03-open: only needs to happen once (described in the next section) and has a different task.  So the start process gets it.  And it runs second.
* 05-l-start: initalizes variables for each of the banks to run smoothly.  So BankM will go first and then start running all tasks below that contain BankM.

# About the process line
BankA=BankA
* The left hand side is the process name.  Easy
* The right hand side is for any other paramiters that this process at this task may need.  I didn't need any extra paramiters at any time.  So I just suplied the name of the process (bank).  It does comes in handy later.

Here is the meat of the 20-to-tsv.sh script
```
python3 ${CONFIG[_HOME]}/tasks.d/20-${VALUE}.py \
	 < ${CONFIG[processDir]}/19-${VALUE}.out \
	 > ${CONFIG[processDir]}/20-${VALUE}.tsv
```
So the script just runs 4 different python script depending on the bank being ran.  It uses ${VALUE} which is BankA in this case.  
AND the value is also used to put the output and error stuff into files with the bank name in it!  Neat.

# To run
To run this thing, I get into the root directory and type './go' which executes the following bash script
```
#!/bin/bash

bashman -h . -v
```
Which means, the home directory is here and run this in verbose.


# A little about naming schemes
* tasks that start with a single digit (02, 03, 05) are initalization programs
* Teens (10-19) are for web scraping
* Twenties (20-29) are for processing
* Thirties are for database updates
* etc etc.  But the numbers get bigger as the program progresses.
* If there were a 99 process, it would be the final end all.
