#!/bin/bash
#To print following ouytput
#0
#0 1
#0 1 2 


x=0

while [ $x -lt 10 ]
do
	y=0
	while [ $y -le $x ]
	do
		echo -e "$y \c"
		y=$(($y+1))
	done
	x=$(($x+1))
	echo -e "\n"
done
