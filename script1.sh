#!/bin/bash


echo "enter the directory name"
read file1

if [ -d $file1  ];
then echo "$file1 is a directry";
echo "do you want to see the contents of directory type yes or no"
read response
	if [ $response = yes  ];
	then ls ./$file1 ;
	fi
else echo "$file1 is a file"
fi
exit 0

