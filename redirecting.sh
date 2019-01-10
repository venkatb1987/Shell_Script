#!/bin/bash

#Testing outputredirecting and input redirecting

#output on console

echo -e "This is one of the way to output on to console";

printf "This ia another \n to print the message on screen \v \t hello \n";

#redirecting the output to file

echo "This will be sent to a file">out_test.txt;

#input redirection

echo "";
cat < out_test.txt;
ps -ef|awk '$1 =="ec2-user" {print$0}'>proc.txt;

echo "Process list";
cat < proc.txt|more; 

exit 0
