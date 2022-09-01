# Just a little awk program to sort out all of the gas purchases in
# the database files.  Run
# awk -f gas.awk [Bank1].tsv [bank2].tsv [bank3].tsv |sort
# for the full list.


BEGIN {
   FS="\t"

}

$2 ~ /FUEL| GAS| 5542 | KROGER F| GET GO|MARATHON|SHELL/ {

         print $0
}
