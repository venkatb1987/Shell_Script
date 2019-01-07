#!/bin/bash

#ask user input name and check whether it is file or dir

echo "Please type any name"
read file1
echo "Please wait we are processing your request to find whether is it file or directory"
file="$file1"

if [ -d $file ] ; then echo "its a directory $file"
	elif [ -f $file ] ; then echo "its a file $file"
	else echo "something else $file"
fi



