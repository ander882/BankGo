#!/bin/bash


taskString="14 Bank Details"

startTask "$taskString"

xdotool key ctrl+l
sleep .25

xdotool type 'https://BankA.com/web/Accounts/Details/PbAq_Lodmx5v3rVkAZ-VQaB37RuZ1AtMb4'
sleep .25
xdotool key Return
sleep 2


checkstring="Date 	Description"

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
