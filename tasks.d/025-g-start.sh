#!/bin/bash

#####
# 
# This does some global startup work
#
# Only call this once for all process!
#
#####

taskString="025 global start"

startTask "$taskString"



#####
# Startup stuff.
# This will be ran every time the whole process' are started
#####

# Go ahead and remove all files in the HOME/process directory.
# Lets start fresh

rm -rf ${CONFIG[_HOME]}/process/*



endTask "$taskScring"

