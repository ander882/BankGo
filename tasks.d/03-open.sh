#!/bin/bash


taskString="03 Opening Browser"

startTask "$taskString"


masterpid=$(xdotool getwindowfocus)
#echo $masterpid

xdotool key ctrl+alt+t

sleep 2

chropid=$(xdotool getwindowfocus)
#echo $chropid

if [ $masterpid == $chropid ]; then
  exit
fi

xdotool type 'chromium-browser'
#xdotool type 'vlc'
xdotool key Return


for i in {1..6}
do
  sleep 2
  winname=$(xdotool getwindowname $(xdotool getwindowfocus))
  #echo $winname

  if [[ "$winname" == *"Chromium"* ]]; then
    #echo "yeah"
    break
  fi

done

###########################################

if [[ "$winname" == *"Chromium"* ]]; then
  log "Web browser opened"
else
  log "No web browser opened"
  stopProcess
  exit
fi

endTask "$taskString"
