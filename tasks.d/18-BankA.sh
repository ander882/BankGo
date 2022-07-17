#!/bin/bash


taskString="18 Bank Logout"

startTask "$taskString"


xdotool key ctrl+l
sleep .25

xdotool type 'https://BankA.com/SignOut'
sleep .25
xdotool key Return
sleep 2


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

#echo "$scrape"
printf "$scrape"
#log "$scrape"

if [[ "$scrape" != *"$checkstring"* ]]; then
  log "Scrape not correct"
  stopProcess
  exit
fi

xdotool key ctrl+w
sleep .25

endTask "$taskString"
