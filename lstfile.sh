#!/bin/bash

#List the files in current directoru

select FILE in ./* Exit
do

	case $FILE in 
		Exit) break ;;
	esac
	
	echo -e "$FILE \t"
done
#echo "Please enter the file number to view the file"
#read num

