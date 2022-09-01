#!/bin/bash

#####
# 
# This does some global startup work
#
# Only call this once for all process!
#
#####

taskString="02 global start"

startTask "$taskString"



# Include a library
# todo - should make an 'include' directory for these?
source ${CONFIG[_HOME]}/tasks.d/10-scrape-lib.sh
source ${CONFIG[_HOME]}/tasks.d/env/banks.env



#####
# Instalation Stuff.  code that should only work once
# and not be destructive
#####

#Make these two directories if needed.  
#this should only happen THE VERY FIRST TIME this script is ran
# -p option is non desctructive.  Stuff in the db will not be destroyed.
mkdir -p ${CONFIG[_HOME]}/process
mkdir -p ${CONFIG[_HOME]}/db/backup



endTask "$taskScring"

