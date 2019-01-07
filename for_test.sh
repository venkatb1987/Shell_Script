#!/bin/bash
#practice for loop

for FILE in ./*
do
	if [ -d $FILE ]; then break; fi
	cp $FILE ./new_dir
done
