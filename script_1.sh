#!/bin/bash
#Script to display all the environment variables
# Decalre variable
#RESULT=export

a=10
b=20
c=50

#export>>Result.txt
#cat Result.txt
#echo $VAR1

RSLT=`expr $a + $b`
echo "$a+$b=" $RSLT
RSLT=`expr $b - $a`
echo "$b-$a=" $RSLT
RSLT=`expr $c / $a`
echo "$c/$a=" $RSLT

echo "Endof the script \n"

exit 0
