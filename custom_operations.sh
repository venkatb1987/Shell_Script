#!/bin/bash

#Custom arthimetic operations

#variable declaration

USAGE="`basename $0`: USage: Just run the script witout any options or arguments"
msg="Select any option from below list with the option number \n
1 - Addition \n
2 - Subtraction \n
3 - Multiplication \n
4 - Division \n
5 - Exit from this program \n"
rep=0

if [ $# -ne 0 ] ; then echo $USAGE exit 1 ; fi

while [ $rep -eq 0 ] 
do

echo -e "Please enter two numbers"
read a b
if [ -z "$a" -o -z "$b" ] ; 
then 
echo -e "Please enter two numbers seperating by space" 
continue; fi
 
echo -e $msg
read opt
if [ -z "$opt" ] ;
then echo -e "Please enter single option from the above list"
read opt ; 
fi

	case $opt in 
		1) res=$(($a+$b))
		   echo -e "The addition: $a+$b = $res \n" ;;
		2) res=$(($a-$b))
		   echo -e "The subtraction: $a-$b = $res \n" ;;
		3) res=$(($a*$b))
		   echo -e "The multiplication: $a*$b = $res" ;;
		4) res=$(($a/$b))
		   echo -e "The division: $a/$b = $res" ;;
		5) echo "Are you sure, want to ext from this - type y or n"
			read ec
			if [ "$ec" = y ] ; then exit 0; 
			elif [ "$ec" = n ]; then continue; fi ;;
	esac
x=0
while [ $x -ne 1 ]
do
echo -e "If you want to repeat type y to stop type n"
read res
case $res in 
	y) x=1
		break ;;
	n) exit 0 ;;
	*) echo -e "Please enter y or n " ;;
esac
done
done

