#!/bin/bash


taskString="10 Bank Login"

startTask "$taskString"


masterpid=$(xdotool getwindowfocus)


winname=$(xdotool getwindowname $(xdotool getwindowfocus))
if [[ "$winname" != *"Chromium"* ]]; then
  log "No web browser opened"
  stopProcess
  exit
fi

#New Window and get login page

xdotool key ctrl+t
sleep 2


xdotool type 'https://BankA.org/'
#xdotool type 'https://BankA.org/idp/484D637/signin'
#xdotool type 'vlc'
xdotool key Return
sleep 2


for i in {1..6}
do
  sleep 2
  winname=$(xdotool getwindowname $(xdotool getwindowfocus))
  #echo $winname

  if [[ "$winname" == *"BankA Credit"* ]]; then
    sleep 2
    #echo "yeah"
    break
  fi

done


winname=$(xdotool getwindowname $(xdotool getwindowfocus))
if [[ "$winname" != *"BankA Credit"* ]]; then
  log "Web page not opened"
  stopProcess
  exit
fi


xdotool type 'BankA_UserName'
xdotool key Tab
xdotool type 'BankA_Password'
sleep .25
xdotool key Return


endTask "$taskString"
