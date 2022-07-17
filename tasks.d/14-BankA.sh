#!/bin/bash


taskString="14 Bank Details"
startTask "$taskString"

# We can't click on a link.  fine.  We already know the full link address!
# Get to the address bar
xdotool key ctrl+l
sleep .25
# Hmm wait a bit to get here.  One bank needs more time sometimes.  
# Maybe we need to do a select all/copy trick to make sure we are in the address bar?


# We already know the page we want to see.  So put it in like we clicked on the link.
xdotool type 'https://BankA.com/web/Accounts/Details/PbAq_Lodmx5v3rVkAZ-VQaB37RuZ1AtMb4'
sleep .25
xdotool key Return
sleep 2


# select all/copy trick to wait until this string is seen.  Then we know it is all loaded nice and neat.
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


# Print the web page.  The calling script will save it to a file.
#echo "$scrape"
printf "$scrape"
#log "$scrape"


#  oops.  We didn't see the string.  
if [[ "$scrape" != *"$checkstring"* ]]; then
  log "Scrape not correct"
  stopProcess
  exit
fi


endTask "$taskString"
