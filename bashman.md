The code that runs it all...

[BashManager](https://github.com/lingtalfi/bashmanager)


My googlefu was not not all that good at the time (2018?) and I didn't know to search for 'task runner'...  But alas, I found Bashmanager and I latched on.

# Directory Structure
* config.d/bankgo.txt - Where to store the runner script (BashMagager needed)
* task.d/ - Where to store the tasks to run (BashMagager needed)
* db/ - Where I store my database files (Mostly .tsv)
* db/backup - Backups of the database files
* process/ - where I store intermediate processing files

# The config file
The first three sections of the config.d/bankgo.txt looks like this:
```
02-g-start:
start=start

03-open:
start=start

05-l-start:
BankM=BankM
BankB=BankB
BankA=BankA
BankC=BankC
rept=rept
```
# A note about the config file
The config file is setup as the following:
* Tasks (Colon lines) are the tasks (programs) that each process CAN go through
* * Not all process' go through all tasks
* Processes.  There are currently 6 processes (start, rept and the 4 banks)
* * Processes will not do all tasks.  

Easy right?  Lest break it down.  BashManager opens the config file and starts reading.  
* The start process is the first process it finds so it is the first to go.  The start process is ran on the first two tasks and then we don't see it again.  it completes.  
* BankM is the next process.  Goody.  Lets run this process all the way through.  The first two tasks don't ask for it so they are not run.  But nearly all the rest of the tasks are.  So each task is ran that has BankM (all but one) in order.
* The next 3 banks are ran in order the same way
* Finally the rept process is process is ran at 05-l-start and then we don't see it until the very end where some final reporting is done.

Case in point.
* 02-g-start: is a global start.  It only needs to run once to do initial setup.  This is why the start process is the only one to go through it.  And since it is at the top, it runs first.
* 03-open: only needs to happen once (described in the next section) and has a different task.  So the start process gets it.  And it runs second.
* 05-l-start: initalizes variables for each of the banks to run smoothly.  So BankM will go first and then start running all tasks below that contain BankM.
