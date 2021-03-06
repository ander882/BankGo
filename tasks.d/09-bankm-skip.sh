#!/bin/bash

taskString="09 skip: ${VALUE}"

startTask "$taskString"


# Get the version number wil will use
oldnum=`cut -f1 ${CONFIG[dbDir]}/bankm-skip.txt`  

#put the new version number in the file
newnum=`expr $oldnum + 1`
printf "%04d" $newnum > ${CONFIG[dbDir]}/bankm-skip.txt

# (( newnum % 3 )) will give:
# 0 = false
# 1 = true
# 2 = true

if (( newnum % 3 )); then
	log "skipping ${VALUE} this time"
	stopProcess
fi


endTask "$taskString"
