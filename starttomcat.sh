#!/bin/bash

#This is to start the tomcat server


function stop ()
{

cd /home/jenkins1/Softwares/Tomcat/bin;
./shutdown.sh >>~/start.log;
sleep 10;
echo "Tomcat is topped successfully"

}


function checkstatus ()
{

ps -ef|grep tomcat-juli.jar|grep -v grep >>~/start.log;
return $?;

}

function start ()
{

cd /home/jenkins1/Softwares/Tomcat/bin;
./startup.sh >>~/start.log;
sleep 10;
echo "Tomcat started successfully"

}

#ps -ef|grep tomcat|grep -v grep
checkstatus
if [ $? -eq 0 ]
then 
	echo "Tomcat is already running: To restart it press 1 : To exit press 2";
	read input;
	case $input in 
	1) 	stop
	   	start ;;
		
	2)	exit 0 ;;

	esac
else 
	start;
fi
exit 0

