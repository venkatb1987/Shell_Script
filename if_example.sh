#!/bin/bash

#Check the freatest number

read a b
echo "a=$a"
echo "b=$b"

if [ $a -eq $b ]
then  echo "a is equal to b"
elif [ $a -gt $b ]
then  echo "a is greater than b"
else echo "a is less than b"
fi
echo success
exit 0
