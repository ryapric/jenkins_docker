#! /usr/bin/env sh
set -e

# Check for image name passed to script
if [ -z "$1" ]; then
    printf "You must provide the name of the image you built for this script, via 'sh docker_run.sh {jenkins_image_name}'\n"
    exit 1
fi

# Grab all the images you may need for jobs, including the Jenkins LTS image
printf "Pulling images listed in docker_run.sh ...\n"
docker image pull jenkins/jenkins:lts
docker image pull rocker/tidyverse:3.5.0

# Stop & remove container, if running
container_name="jenkins"
if [ "$(docker ps -a | grep $container_name)" ]; then
    docker container stop "$container_name" >/dev/null
    docker container rm "$container_name" >/dev/null
fi

# Run, mounting the host Docker socket, binary executable, and the Jenkins homedir
# Based on an old post answer from 2014, but still works as intended:
# https://forums.docker.com/t/using-docker-in-a-dockerized-jenkins-container/322
docker_sock="/var/run/docker.sock"
docker_bin="$(which docker)"

docker container run \
    -d \
    -p 8080:8080 \
    -p 50000:50000 \
    -v "$docker_sock":"$docker_sock" \
    -v "$docker_bin":"$docker_bin" \
    -v jenkins_home:/var/jenkins_home/ \
    -u root \
    --name "$container_name" \
    "$1" >/dev/null

printf "Started container with name: '$container_name'\n"
exit 0
