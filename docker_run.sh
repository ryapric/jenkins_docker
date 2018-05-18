#! /usr/bin/env sh
set -e

# Check for image name passed to script
if [ -z "$1" ]; then
    printf "You must provide the name of the image you built for this script, via 'sh docker_run.sh {jenkins_image_name}'\n"
    exit 1
fi

container_name="jenkins"

# Stop & remove container, if running
if [ "$(docker ps -a | grep $container_name)" ]; then
    docker container stop jenkins && docker container rm jenkins
fi

# Run, mounting a few volumes
docker container run \
    -d \
    -p 8080:8080 \
    -p 50000:50000 \
    -v jenkins_home:/var/jenkins_home/ \
    --name "$container_name" \
    "$1"

printf "Started container with name: '$container_name'\n"
exit 0
