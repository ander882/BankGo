
sed -e '0,/Amount 	Balance/d' \
     -e '/Next 50 Trans/Q' \
     -e '/Footer Image/Q' \
     -e 's/[$,]//g' \
| tr -s ' ' \
| tac
