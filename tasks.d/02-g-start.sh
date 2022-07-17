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


#####
# Instalation Stuff.  code that should only work once
# and not be destructive
#####

#Make these two directories if needed.  
#this should only happen THE VERY FIRST TIME this script is ran
# -p option is non desctructive.  Stuff in the db will not be destroyed.
mkdir -p ${CONFIG[_HOME]}/process
mkdir -p ${CONFIG[_HOME]}/db/backup


#####
# Startup stuff.
# This will be ran every time the whole process' are started
#####

# Go ahead and remove all files in the HOME/process directory.
# Lets start fresh

rm -rf ${CONFIG[_HOME]}/process/*


endTask "$taskScring"
