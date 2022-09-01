#!/bin/bash

taskString="Check for (un)unique lines in database: ${VALUE} "

startTask "$taskString"

# check to see if there are any unique lines.  If there are, then
# there is probably a problem.  That is why this out put goes into an
# error file.  

# TODO - Do we want to remove the Balance column first?  
# But there is the problem where a transaction line gets inserted 2
# days after which messes with the balance line.



sort ${CONFIG[dbDir]}/${VALUE}.tsv \
        | uniq -cd \
        1> ${CONFIG[processDir]}/uniq-${VALUE}.err



endTask "$taskString"



# make some checks to see if we want to continue with this process

if [ -s "${CONFIG[processDir]}/uniq-${VALUE}.err" ]
then
	warning "There is a possible error in database ${VALUE}"
fi
