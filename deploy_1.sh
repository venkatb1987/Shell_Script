#!/bin/bash

#Automation to build and deploy my project.
#source coed from github and tomcat is in same server

#GIT_HOME=$HOME/Maven
BUILD_HOME=/home/ec2-user/build/projects;
DEPLOY_HOME=$HOME/Softwares/tomcat/webapps;
LOG_PATH=/home/ec2-user/build/logs;
LOG_FOLDER=`date +%Y-%m-%d_%T`;
LOG_FILE=Build_`date +%m_%d_%Y`.log;

USAGE="`basename $0` : Please run the script with one argument which will be the correct project name :";

if [ $# -eq 0 -o $# -gt 1 ];
then
        echo -e $USAGE;
        exit 1;
fi
PName=$1;
URL=https://github.com/venkatb1987/"$PName".git;
echo -e $URL;
errormsg() {

echo -e "Project $1 failed, exiting the build process: please check the log and try again\n";
echo -e "Sending email with error log...........";
echo -e "The $1 is failed, please cehck the attached log and take action "|mail -s "Deployment Failed" -r "vrbonam9@gmail.com" -a $LOG_PATH/$LOG_FOLDER/$LOG_FILE vrbonam9@gmail.com; 
exit 1;

}

#Checking for directory existence

if [ -d $BUILD_HOME ]; then
	cd $BUILD_HOME;
else 
	echo -e "-------Build home directory is not there: Exiting from build process-----------\n"|tee -a $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1;
	exit 1;
fi

mkdir $LOG_PATH/$LOG_FOLDER;
#Cloning project from github

echo -e "Cloning the project from GIT HUB.... please wait....\n"|tee -a $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1;
if [ -d $BUILD_HOME/$PName ];
then
	echo -e "Removing the existing project \n"|tee -a $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1;
	 rm -rf "$PName" ;
fi
git clone $URL > $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1 ;

if [ $? -eq 0 ]; 
then echo -e "Project clone is successfull...\n"|tee -a $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1;
else 
errormsg clone;
fi

#Starting project build

cd $BUILD_HOME/$PName;

echo -e "Buildng the project...... please wait....\n"|tee -a $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1;
mvn install >> $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1 ;

if [ $? -eq 0 ];
then echo -e "Project build is successfull.......\n"|tee -a $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1;
else
errormsg build;
fi

DEPLOY_FILE=`find $BUILD_HOME/$PName/target/ -name *.war|awk -F / '{print $NF}'`;
DD=`find $BUILD_HOME/$PName/target/ -name *.war|awk -F / '{print $NF}'|cut -d. -f 1`;
echo -e "Deploying the project in tomcat... please wait....\n"|tee -a $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1;
echo -e "$DEPLOY_FILE  , $DD";
#if [ $? -eq 0 ] ; then exit 1;fi
#Removing existing project from tomcat
if [ -f $DEPLOY_HOME/$DEPLOY_FILE ]; then
	rm -v $DEPLOY_HOME/$DEPLOY_FILE >> $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1 ; fi;
if [ -d $DEPLOY_HOME/$DD ]; then
	rm -rvf $DEPLOY_HOME/$DD >> $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1 ; fi;

#tmcat shutdown
cd ~/Softwares/tomcat/bin;
./shutdown.sh >> $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1 ;

#deploying project
cd $BUILD_HOME;
cp -v $BUILD_HOME/$PName/target/$DEPLOY_FILE $DEPLOY_HOME >> $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1 ;
if [ $? -eq 0 ];
then echo -e "Deployment successfull.....\n "|tee -a $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1;
else
errormsg Deployment;
fi

#Starting tomcat
cd ~/Softwares/tomcat/bin
./startup.sh >> $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1 ;

if [ $? -eq 0 ]; 
then echo -e "Tomcat started successfull.. try to access from browser.....\n"|tee -a $LOG_PATH/$LOG_FOLDER/$LOG_FILE 2>&1;
else
errormsg tomcat;
fi
exit 0;
