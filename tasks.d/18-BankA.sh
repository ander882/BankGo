#!/bin/bash


taskString="18 Bank Logout"

startTask "$taskString"


# Get into the address bar
xdotool key ctrl+l
sleep .25


# yeah.  We know the correct link to sign out!  
# sometimes banks hide them.  But look.  It is there.
xdotool type 'https://BankA.com/SignOut'
sleep .25
xdotool key Return
sleep 2


# again look for a string in the new web page to see when it loads.
# We can simply use the page title trick.  That would be easier...
checkstring="Logged Off"

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


# Go ahead and print what we see.  The calling script will save it.
# Do this just to have the paper trail and keep things uniform.
#echo "$scrape"
printf "$scrape"
#log "$scrape"


# Oops.  We didn't see it.
if [[ "$scrape" != *"$checkstring"* ]]; then
  log "Scrape not correct"
  stopProcess
  exit
fi


# now that we are done with this bank, go ahead and close the tab.
xdotool key ctrl+w
sleep .25

endTask "$taskString"
