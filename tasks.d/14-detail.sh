#!/bin/bash

taskString="14 bank: ${VALUE} Detail Screen"


startTask "$taskString"


source ${CONFIG[_HOME]}/tasks.d/14-${VALUE}.sh \
         > ${CONFIG[processDir]}/14-${VALUE}.out \
        2> ${CONFIG[processDir]}/14-${VALUE}.err


endTask "$taskString"



# make some checks to see if we want to continue with this process

if [ -s "${CONFIG[processDir]}/14-${VALUE}.err" ]
then
	warning "There was an error in scraping ${VALUE}"
	stopProcess
fi
