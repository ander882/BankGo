#!/bin/bash

taskString="12 bank: ${VALUE} Home Screen"

startTask "$taskString"


source ${CONFIG[_HOME]}/tasks.d/12-${VALUE}.sh \
         > ${CONFIG[processDir]}/12-${VALUE}.out \
        2> ${CONFIG[processDir]}/12-${VALUE}.err


endTask "$taskString"


# make some checks to see if we want to continue with this process

if [ -s "${CONFIG[processDir]}/12-${VALUE}.err" ]
then
	warning "There was an error in scraping ${VALUE}"
	stopProcess
fi
