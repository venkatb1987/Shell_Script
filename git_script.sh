#!/bin/bash

#Script to create local repository and then add remote repository

REPO_PATH=/home/ec2-user/GIT/

cd $REPO_PATH
mkdir new_local_repo
cd new_local_repo

git init >>git_init.log
echo "My first test file">>test_file.java
git add * >>$REPO_PATH/git_log.log
git commit -m "first commit" >>$REPO_PATH/git_log.log
echo "Successfully created loal repository under $REPO_PATH with name new_local_repo"

exit 0

