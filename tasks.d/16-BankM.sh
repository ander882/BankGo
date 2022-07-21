#!/bin/bash

taskString="16 Bank Source"

startTask "$taskString"


xdotool key ctrl+u
sleep 2


checkstring="</script>"

for i in {1..6}
do
  sleep 1
  xdotool key ctrl+a
  sleep .25
  xdotool key ctrl+c
  scrape=$(xsel)

  if [[ "$scrape" == *"$checkstring"* ]]; then
    break
  fi

done

echo "$scrape"
#printf "$scrape"
#xsel 
#log "$scrape"

if [[ "$scrape" != *"$checkstring"* ]]; then
  log "Scrape not correct"
  stopProcess
  exit
fi


xdotool key ctrl+w
sleep 2


endTask "$taskString"
