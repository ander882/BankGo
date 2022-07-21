#!/bin/bash

taskString="16 bank: ${VALUE} Detail Source"

startTask "$taskString"


source ${CONFIG[_HOME]}/tasks.d/16-${VALUE}.sh \
         > ${CONFIG[processDir]}/16-${VALUE}.out \
        2> ${CONFIG[processDir]}/16-${VALUE}.err


endTask "$taskString"


# make some checks to see if we want to continue with this process

if [ -s "${CONFIG[processDir]}/16-${VALUE}.err" ]
then
	warning "There was an error in scraping ${VALUE}"
	stopProcess
fi
