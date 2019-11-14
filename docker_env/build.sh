#!/bin/bash
echo "user for Github account"
read -r user
echo "email for Github account"
read -r email
DOCKER_OPTS="--build-arg USER=${user} --build-arg EMAIL=${email}"
echo $DOCKER_OPTS
docker build $DOCKER_OPTS -t work_env .
