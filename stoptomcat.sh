#!/bin/bash

#This is to stop the tomcat server


function stop ()
{

cd /home/jenkins1/Softwares/Tomcat/bin;
./shutdown.sh >>~/stop.log;
sleep 10;
echo "Tomcat is stopped successfully"

}


function checkstatus ()
{

ps -ef|grep tomcat-juli.jar|grep -v grep >>~/stop.log;
return $?;

}

checkstatus
if [ $? -ne 0 ]
then 
	echo "Tomcat is already stopped:";
  	exit 0;	
else 
	stop;
fi
exit 0

