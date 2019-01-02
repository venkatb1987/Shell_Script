#!/bin/bash

#sample script for if statement

A=10
B=10

if [ `$A > $B` ];
then echo "$A is greater than $B"
elif [ `$A==$B` ] ;
then echo "$A is equal to $B"
else
echo "$B is greater than $A"
fi

exit 0
