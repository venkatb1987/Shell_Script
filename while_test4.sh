#!/bin/bash

RESPONSE=""

while [ -z $RESPONSE ]
do
	echo -e "Please enter the valid diretory name \c"
	read RESPONSE
	if [ ! -d $RESPONSE ] ; then 
	echo -e "This is not directory \c"
	RESPONSE=""
	fi
done
