#!/bin/bash


taskString="10 Bank Login"

startTask "$taskString"


# Chrome should now be open
# Check to make sure
winname=$(xdotool getwindowname $(xdotool getwindowfocus))
if [[ "$winname" != *"Chromium"* ]]; then
  log "No web browser opened"
  stopProcess
  exit
fi

#New Window and get login page

# Open a new tab
xdotool key ctrl+t
sleep 2


# Load up our bank web page
# Note: It is good to find a logon ONLY page.  
# Don't go to the main page with all of the adds, flash, and extra stuff
# Things load faster and easier.
xdotool type 'https://BankA.org/'
#xdotool type 'https://BankA.org/idp/484D637/signin'
#xdotool type 'vlc'
xdotool key Return
sleep 2

# Check for the title of the web page to load.
# This is a good indication that the full page has loaded.  (?)
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


# Just check again.
winname=$(xdotool getwindowname $(xdotool getwindowfocus))
if [[ "$winname" != *"BankA Credit"* ]]; then
  log "Web page not opened"
  stopProcess
  exit
fi


# Type in the user name and password
xdotool type 'BankA_UserName'
xdotool key Tab
xdotool type 'BankA_Password'
sleep .25
xdotool key Return


endTask "$taskString"
