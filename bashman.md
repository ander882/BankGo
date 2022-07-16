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
config.d/bankgo.txt looks like this:
'''
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
'''
