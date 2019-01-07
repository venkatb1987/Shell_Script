#!/bin/bash
#


x=0
while [ $x -lt 10 ]
do
	y=$x
	while [ $y -ge 0 ]
	do
		echo -e "$y \c" 
		y=`expr $y - 1`
	done
	echo -e "\n"
	x=`expr $x + 1`
done 
