#!/bin/bash
#Test script to try case statement

echo "enter fruit name"
read FRUIT

echo "you are running `basename $0`"

case $FRUIT in
	Orange)
	echo "entered fruit name is $FRUIT";;
	Apple)
	echo "entered fruit name is $FRUIT";;
	*)
	echo "entered other than Apple and Orange : $FRUIT"
esac
exit 0


