#!/usr/bin/env python

# A script to take the 19 level output as a stream
# and transform it into a fully desired TSV as ouput.

import sys
from datetime import datetime


# use stdin if it's full                                                        
if not sys.stdin.isatty():
   input_stream = sys.stdin

# otherwise, read the given filename                                            
else:
   try:
      input_filename = sys.argv[-1]
   except IndexError:
      message = 'need filename as first argument if stdin is not full'
      raise IndexError(message)
   else:
      input_stream = open(input_filename, 'rU')


black = [ "0214", # Ralleys - also uses 5814
          "0248", # Ralleys - above
          "3486", # Osco - uses 5411
          #3XXX , # Airline, hotel, renta car
          "6016" #zelle, tires, walmart, other, ?
        ] # no need to use blacklist any more.  
          # Just ignore those that are not white.
          # Store numbers
          
          #
          # anything that DOES NOT start with [4-7] can be ignored
          # exception 8398 is for tithing.  But Those are done from the description
          #


white = [ "5542", # Gas / Fuel
          "5541", # Car X, Gas stations
          "7523", # Airport Parking
          "7538", # Oil Change
          "5533", # Auto Parts
          "4784", # Tollway
          "6012", # Car Other

          # This is in a not used range
          #"8398", # Tithing - Compassion International, K-Love

          "4812", # Bill - Hello Mobile
          "7299", # Bill - Hello Mobile
          "4814", # Bill - Other cell phone - Not used now

          "5812", # Resteraunt
          "5813", # Resteraunt
          "5814", # Resteraunt
          "5499", # Resteraunt

          "5200", # Home - Menards

          "5331", # Dollar - Five Below, Dollar Tree

          "5931", # Goodwill

          "5399", # Games - Entertainment
          "5945", # Games - Entertainment
          "4899", # Entertainment - VUDU
          "7999", # Entertainment - U paint, Zip City, Games to Die for
          "7832", # Entertainment - Movie theater

          "5310", # Clothing - Marshalls, Ross
          "5661", # Clothing - Foot Locker
          "5651", # Clothing - Marshals, Bulrington, Van Heusen

          "5441", # Candy
          "5300", # CostCo
          "5411", # Food - Krogers, Aldi, Meijer, Target, Walmart

          "5311", # Online - Ebay
          "5942", # Online - Mostly Amazon some Half Price Books
          "4816", # Online - Amazon

          "7841"  # Redbox
          ]

# Options
##
#     (Defaults to showing 
#       - ALL lines with 
#       - First MCC code from the white list
#       )
#
#  -0  Only those that have NO mcc codes
#  -1  Only those that have an MCC code (first from white list)
#  -a  ALL lines with ALL possible MCC codes
#  -f3  Add MCC codes into the 3rd spot
#  -m  Show multiple possible mcc codes 
#      (Defaults to first code from white list)
#  -M  Show only lines with more than one MCC code
#

r=[]
c=0
for line in input_stream:

    line = line[:-1] #Remove \n at the end

    codes = line.split()

    i = len(codes) -1

    # Work on getting only the possible MCC codes
    while i>=0:
        if len(codes[i]) != 4 or not codes[i].isdigit():
            codes.pop(i)
            # Now only len(4) numbers are here

        elif codes[i][0] in ["0", "1", "2", "8", "9"]:
            codes.pop(i)
            # Now only [3,4,5,6,7]XXX numbers are here

        # Now we have a possible mcc code.
        elif codes[i] not in white:
            #Pop off what is NOT in the white list
            #except if these parms are in play
            if "-a" not in sys.argv and "-m" not in sys.argv and "-M" not in sys.argv:
                codes.pop(i)
        i = i - 1


    # Paramiter stuff        
    if "-M" in sys.argv and len(codes) < 2:
        continue

    if "-1" in sys.argv and codes == []:
        continue 

    elif "-0" in sys.argv and codes != []:
        continue 


    # We have a set of codes (or []).  
    if "-f3" in sys.argv:
        ln = line.split("\t")
        if codes != []:
            ln[2] = "M" + " M".join(codes)
        print "\t".join(ln)
    else:
        if codes == []:
            print line + "\t" 
        else:
            print line + "\tM" + " M".join(codes) 

