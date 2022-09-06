#!/bin/bash

taskString="10 bank: ${VALUE} login"

startTask "$taskString"



# Open a new tab - will be closed after log out.
varname="${VALUE}_site"
BROWSER_tab_new ${!varname}
if [[ 0 -ne $? ]]; then
  warning "Web page not opened"
  stopProcess
  exit
fi



# Check for the title of the web page to load.
varname="${VALUE}_title"
BROWSER_check_title ${!varname}
if [[ 0 -ne $? ]]; then
  log "Web page not opened."
  stopProcess
  exit
fi



echo "$BROWSER_winname" > ${CONFIG[processDir]}/10-${VALUE}.out



if [ ${VALUE} == "hunt" ]
then
   xdotool key Tab
   sleep .25
   xdotool key Tab
   sleep .5
fi



# Make sure the focus is on the textbox
BROWSER_text_focus
if [[ 0 -ne $? ]]; then
  log "No text box focus"
  stopProcess
  exit
fi



# Type in the name and pass
varname="${VALUE}_user"
varnam2="${VALUE}_pass"
BROWSER_typeup ${!varname} ${!varnam2}
if [[ 0 -ne $? ]]; then
  warning "Browser lost focus"
  stopProcess
  exit
fi



endTask "$taskString"



# make some checks to see if we want to continue with this process

if [ -s "${CONFIG[processDir]}/10-${VALUE}.err" ]
then
	warning "There was an error in scraping ${VALUE}"
	stopProcess
fi
