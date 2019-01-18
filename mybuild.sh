#!/bin/bash

#Automation to build and deploy my project.
#source coed from github and tomcat is in same server

GIT_HOME=$HOME/Maven
BUILD_HOME=$HOME/Maven/gamutkart2
DEPLOY_HOME=$HOME/Softwares/tomcat/webapps

URL=https://github.com/nageshvkn/gamutkart2.git
LOG_FILE=Build_`date +%m_%d_%Y`.log;

if [ $# -ne 0 ]; then echo "Please execute the program without any argumnets and options"; exit 1; fi;

errormsg() {

echo -e "Project $1 failed, exiting the build process: please check the log and try again\n";
echo -e "Sending email with error log...........";
echo -e "The $1 is failed, please cehck the attached log and take action "|mail -s "Deployment Failed" -r "vrbonam9@gmail.com" -a $GIT_HOME/log/$LOG_FILE vrbonam9@gmail.com; 
exit 1;

}

#Checking for directory existence

if [ -d $GIT_HOME ]; then
	cd $GIT_HOME;
else 
	echo -e "-------Git home directory is not there: Exiting from build process-----------\n";
	exit 1;
fi

#Cloning project from github

echo -e "Cloning the project from GIT HUB.... please wait....\n";
if [ -d $BUILD_HOME ];
then
	echo -e "Removing the existing project \n";
	 rm -rf gamutkart2 ;
git clone $URL > $GIT_HOME/log/$LOG_FILE 2>&1 ;
fi

if [ $? -eq 0 ]; 
then echo -e "Project clone is successfull...\n";
else 
errormsg clone;
fi

#Starting project build

cd $BUILD_HOME;

echo -e "Buildng the project...... please wait....\n";
mvn install >> $GIT_HOME/log/$LOG_FILE 2>&1 ;

if [ $? -eq 0 ];
then echo -e "Project build is successfull.......\n";
else
errormsg build;
fi

echo -e "Deploying the project in tomcat... please wait....\n";

#Removing existing project from tomcat
if [ -f $DEPLOY_HOME/gamukart.war ]; then
	rm -v $DEPLOY_HOME/gamutkart.war >> $GIT_HOME/log/$LOG_FILE 2>&1 ; fi;
if [ -d $DEPLOY_HOME/gamutkart ]; then
	rm -rvf $DEPLOY_HOME/gamutkart >> $GIT_HOME/log/$LOG_FILE 2>&1 ; fi;

#tmcat shutdown
cd ~/Softwares/tomcat/bin;
./shutdown.sh >> $GIT_HOME/log/$LOG_FILE 2>&1 ;

#deploying project
cd $BUILD_HOME;
cp -v ./target/gamutkart.war $DEPLOY_HOME >> $GIT_HOME/log/$LOG_FILE 2>&1 ;
if [ $? -eq 0 ];
then echo -e "Deployment successfull.....\n ";
else
errormsg Deployment;
fi

#Starting tomcat
cd ~/Softwares/tomcat/bin
./startup.sh >> $GIT_HOME/log/$LOG_FILE 2>&1 ;

if [ $? -eq 0 ]; 
then echo -e "Tomcat started successfull.. try to access from browser.....\n";
else
errormsg tomcat;
fi
exit 0;
