#!/bin/bash


taskString="12 Bank Home"

startTask "$taskString"

# We are already being directed here!  
# No need to go anywhere.  Just wait for it to load

masterpid=$(xdotool getwindowfocus)


winname=$(xdotool getwindowname $(xdotool getwindowfocus))
if [[ "$winname" != *"Chromium"* ]]; then
  log "No web browser opened"
  stopProcess
  exit
fi

#New Window and get login page

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

#echo "$scrape"
printf "$scrape"
#log "$scrape"

if [[ "$scrape" != *"$checkstring"* ]]; then
  log "Scrape not correct"
  stopProcess
  exit
fi


endTask "$taskString"
