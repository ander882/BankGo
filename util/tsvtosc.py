#!/usr/bin/python
#https://www.linuxjournal.com/article/10699

import sys
import string

if len(sys.argv) < 2:
    print "Usage: %s infile [delimiter_char]" % sys.argv[0]
    sys.exit(1)

filename_in = sys.argv[1]

delimiter = '\t'
if len(sys.argv) == 3:
    delimiter = sys.argv[2][0]
    print 'using delimiter %c' % delimiter

infile = open(filename_in, 'r')

letters = string.ascii_uppercase
print ("# Produced by convert_csv_to_sc.py" )
row=0
for line in infile.readlines():
    allp = line.rstrip().split(delimiter)
    if len(allp) > 25:
        print "i'm too simple to handle more than 26 many columns"
        sys.exit(2)
    column = 0
    for p in allp:
        col = letters[column]
        if len(p) == 0:
                continue

        try:
            n = float(p)
            print('let %c%d = %s' % (col, row, p))
        except:
            if p[0] == '"':
                print('label %c%d = %s' % (col, row, p))
            else:
                print('label %c%d = "%s"' % (col, row, p))
        column += 1
    row += 1

infile.close()

