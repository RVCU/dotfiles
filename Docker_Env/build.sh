#!/bin/bash
#USING CONFIGS UP A DIR
cp -f ../bashrc .bashrc
cp -rf ../templates .
cp -rfp ../vimrc.d/ .vimrc.d/ || :
cp -f ../vimrc .vimrc
cp -f ../tmux.conf .tmux.conf
cp -f ../coc-settings.json .
#SECRET STUFF I DON'T KEEP IN GIT
cp -r ~/bin .
cp -f ../git-identity bin/
cp ~/.bash_work_functions . || :
cp ~/.vim/vim_work_functions.vim . || :

echo "user for Github account"
read -r user
echo "email for Github account"
read -r email
echo "local user to source bin from"
read -r local_user
echo "user for oss work"
read -r oss_user
echo "email for oss work"
read -r oss_email
DOCKER_OPTS="--build-arg USER=${user} --build-arg LOCAL_USER=${local_user} --build-arg EMAIL=${email} --build-arg OSS_USER=${oss_user} --build-arg=OSS_EMAIL=${oss_email}"
docker build $DOCKER_OPTS -t work_env .
