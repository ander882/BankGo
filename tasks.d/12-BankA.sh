#!/bin/bash

taskString="12 Bank Home"
startTask "$taskString"


# We are already being directed here!  
# No need to go anywhere.  Just wait for it to load


#Check again that Chrome is the active window
winname=$(xdotool getwindowname $(xdotool getwindowfocus))
if [[ "$winname" != *"Chromium"* ]]; then
  log "No web browser opened"
  stopProcess
  exit
fi


# Use the 'select all' and 'copy' technique to see
# when the page has loaded enough.  Some elements are 'active'
# so they load after the page has loaded.  
# Here is the string that we are going to be looking for.
checkstring="Checking (Checking)"

for i in {1..6}
do
  sleep 1
  xdotool key ctrl+a
  sleep .25
  xdotool key ctrl+c
  #echo $winname
  scrape=$(xsel)

  if [[ "$scrape" == *"$checkstring"* ]]; then
    #echo "yeah"
    break
  fi

done

# echo will sometime throw an error.  Why?  inproperlly formatted html?
# printf works well with this bank.  So use it.
# printing the scraped web page will save to a file from the script that called this.
#echo "$scrape"
printf "$scrape"
#log "$scrape"


# Stop this bank process if we didn't find what we wanted.
if [[ "$scrape" != *"$checkstring"* ]]; then
  log "Scrape not correct"
  stopProcess
  exit
fi


endTask "$taskString"
