#!/bin/bash



#########################################
#
# Variables
#
# The name of the browser
#
# Standard Sleep time in seconds
#
#########################################

BROWSER_NAME="Chromium"

BROWSER_sleep=2
BROWSER_sleep_half=1
BROWSER_sleep_quarter=.5

BROWSER_wait_times=6



#########################################
# Return error codes
#########################################
# 1 - The browser is no longer active
# 2 - The page title is not expeceted
# 3 - Text on the page does not have desired text
# 4 - We are not in a textbox.  For inputing usernames, etc.
#########################################





#########################################
#
# Browser_check()
#
# checks to see if the active window has 
# the browsers name in it.
# 
#########################################

BROWSER_check () {
  BROWSER_winname=$(xdotool getwindowname $(xdotool getwindowfocus))
  if [[ "$BROWSER_winname" != *"$BROWSER_NAME"* ]]; then
    return 1  # bail
  fi
}




#########################################
#
# Broser_check_title()
#
# checks to see if the active window has 
# the browsers name in it.
# 
#########################################

BROWSER_check_title()
{
   i=0
   while [ $i -lt $BROWSER_wait_times ]
   do
     sleep $BROWSER_sleep_half
     BROWSER_check
     if [ 0 -ne $? ]; then return $?; fi


     #$BROWSER_winname is set in BROWSER_check
     #echo "loop check title"
     if [[ "$BROWSER_winname" == *"$1"* ]]; then
       sleep $BROWSER_sleep
       #echo "loop check title - yeah!"
       return 0
       # ok the title is here but the web 
       # page may not be fully loaded yet.
     fi

   i=$((i+1))
   done

   return 2

}



#########################################
#
# Broser_check_page()
#
# checks to see if the active window has 
# the browsers name in it.
# 
#########################################

BROWSER_check_page () {
   i=0
   while [ $i -lt $BROWSER_wait_times ]
   do
     #First check that the browser has focus.  If not bail!
     BROWSER_check
     if [ 0 -ne $? ]; then return $?; fi

     sleep $BROWSER_sleep
     xdotool key ctrl+a
     sleep $BROWSER_sleep_quarter
     xdotool key ctrl+c

     scrape=$(xsel)

     #echo "loop check page"
     if [[ "$scrape" == *"$1"* ]]; then
       sleep $BROWSER_sleep_half
       #echo "loop check page - yeah!"
       return 0
     fi

   i=$((i+1))
   done

   return 3

}




#########################################
#
# Broser_text_focus()
#
# checks to see if the active window has 
# the browsers name in it.
# 
#########################################

BROWSER_text_focus () {
   i=0
   while [ $i -lt $BROWSER_wait_times ]
   do
     #First check that the browser has focus.  If not bail!
     BROWSER_check
     if [ 0 -ne $? ]; then return $?; fi

     xdotool type "="
     sleep $BROWSER_sleep_quarter
     xdotool key ctrl+a
     sleep $BROWSER_sleep_quarter
     xdotool key ctrl+c

     scrape=$(xsel)
     #echo "======================="
     #echo "$(xsel)" >&1


     #echo "loop text focus"
     if [[ "$scrape" == "=" ]]; then
       sleep $BROWSER_sleep_quarter
       #echo "loop text focus - yeah!"
       return 0
     fi

   i=$((i+1))
   done

   return 4

}




#########################################
#
# Browser_typeup()
#
# type in a user, tab, password string with a return
#
# Argument $1 = Username
# Argument $2 = Password
# 
#########################################

BROWSER_typeup() 
{
  #First check that the browser has focus.  If not bail!
  BROWSER_check
  if [ 0 -ne $? ]; then return $?; fi

  xdotool type "$1"
  xdotool key Tab
  sleep $BROWSER_sleep_quarter
  xdotool type "$2"
  sleep $BROWSER_sleep_quarter
  xdotool key Return
  sleep $BROWSER_sleep
  }


  
#########################################
#
# Browser_typer()
#
# type in a string with a return
#
# Argument $1 = Web Page
# 
#########################################

BROWSER_typer() 
{
  #First check that the browser has focus.  If not bail!
  BROWSER_check
  if [ 0 -ne $? ]; then return $?; fi

  xdotool type "$1"
  sleep $BROWSER_sleep_quarter
  xdotool key Return
  sleep $BROWSER_sleep
  }


  
#########################################
#
# Browser_tab_getsource()
#
# gets the source of the web page
# Does open a new tab in Chrome
#
#########################################

# Now to go a different http address on this tab

BROWSER_tab_getsource () {
  #First check that the browser has focus.  If not bail!
  BROWSER_check
  if [ 0 -ne $? ]; then return $?; fi

  xdotool key ctrl+u
  sleep $BROWSER_sleep_quarter
  }




#########################################
#
# Browser_tab_close()
#
# Closes this tab.  Can close browser if only 1 tab
#
#########################################

# Now to go a different http address on this tab

BROWSER_tab_close () {
  #First check that the browser has focus.  If not bail!
  BROWSER_check
  if [ 0 -ne $? ]; then return $?; fi

  xdotool key ctrl+w
  sleep $BROWSER_sleep_quarter
  }




#########################################
#
# Browser_tab_go()
#
# Open a new page in this tab
#
# Argument $1 = Web Page
# 
#########################################

# Now to go a different http address on this tab

BROWSER_tab_go () {
  #First check that the browser has focus.  If not bail!
  BROWSER_check
  if [ 0 -ne $? ]; then return $?; fi

  xdotool key ctrl+l
  sleep $BROWSER_sleep_quarter

  BROWSER_typer "$1"
  }




#########################################
#
# Browser_tab_new()
#
# Open a new tab in the browser
# 
#########################################

# Load up our bank web page
# Note: It is good to find a logon ONLY page.  
# Don't go to the main page with all of the adds, flash, and extra stuff
# Things load faster and easier and hopefully the cursor is already
# in the user name field...

BROWSER_tab_new() 
{
   #First check that the browser has focus.  If not bail!
   BROWSER_check
   if [ 0 -ne $? ]; then return $?; fi
   local scrape="$BROWSER_winname"

   xdotool key ctrl+t
   sleep $BROWSER_sleep_half

   if [[ "$1" ]]; then
      BROWSER_typer "$1"
      BROWSER_page_wait "$scrape"
   fi
  }




#########################################
#
# Browser_page_wait ()
#
# wait for a new page to be loaded
# No bad return if it doesn't happen.
# 
# Argument $1 = Current page title
# 
#########################################

BROWSER_page_wait () 
{
   if [ $# -eq 0 ]  # if no args, just return
   then
      return 0
   fi

   # Once the address is given, it can take a 
   # hot minute to load a page.  Wait for 
   # the title to change
   i=0
   while [ $i -lt $BROWSER_wait_times ]
   do
       sleep $BROWSER_sleep_half
       BROWSER_check

       #echo "loop page_wait"
       if [[ "$1" != "$BROWSER_winname" ]]; then
          #echo "loop page_wait - Yeah!"
          return 0
       fi

   i=$((i+1))
   done

}




# Bash functions, unlike functions in most programming languages 
# do not allow you to return a value to the caller. When a bash 
# function ends its return value is its status: 
## zero for success, 
## non-zero for failure.

# Although bash has a return statement, the only thing you can 
# specify with it is the function's status, which is a numeric 
# value like the value specified in an exit statement. 
# The status value is stored in the $? variable. 
# If a function does not contain a return statement, 
# its status is set based on the status of the last statement 
# executed in the function. 
# To actually return arbitrary values to the caller you must use other mechanisms.

# Return is intended to be used only for signaling errors

