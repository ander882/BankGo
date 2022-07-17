#!/bin/bash

taskString="10 bank: ${VALUE} login"


startTask "$taskString"


source ${CONFIG[_HOME]}/tasks.d/10-${VALUE}.sh \
         > ${CONFIG[processDir]}/10-${VALUE}.out \
        2> ${CONFIG[processDir]}/10-${VALUE}.err


endTask "$taskString"


# make some checks to see if we want to continue with this process

if [ -s "${CONFIG[processDir]}/10-${VALUE}.err" ]
then
	warning "There was an error in scraping ${VALUE}"
	stopProcess
fi
