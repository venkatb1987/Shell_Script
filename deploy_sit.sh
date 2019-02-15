#!/bin/bash

# This is to deploy the project in SIT environment.

function checkstatus ()
{

ssh sit1@172.17.0.2 ps -ef|grep tomcat-juli.jar|grep -v grep ;
return $?;

}

function deploy ()
{

ssh sit1@172.17.0.2 rm /hosting/myapp/sit/tools/Tomcat/webapps/*.war
scp $1/target/*.war sit1@172.17.0.2:/hosting/myapp/sit/tools/Tomcat/webapps
echo `pwd`
}

function stop ()
{

ssh sit1@172.17.0.2 /hosting/myapp/sit/tools/Tomcat/bin/shutdown.sh;
sleep 5;
echo "Tomcat is topped successfully"

}

function start ()
{

ssh sit1@172.17.0.2 /hosting/myapp/sit/tools/Tomcat/bin/startup.sh;
sleep 5;
echo "Tomcat started successfully"

}

ws=$1;
checkstatus
if [ $? -ne 0 ]
then 
	deploy $ws;
	start;
else
	stop;
	deploy $ws;
	start;
fi
exit 0;
