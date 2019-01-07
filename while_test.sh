#!/bin/bash

#script to test the while loop

x=0

while [ $x -lt 10 ]
do
	echo $x
	x=`expr $x + 1`
done
