#! /usr/bin/env sh
set -e

docker pull jenkins/jenkins:lts

docker run \
    -d \
    -p 8080:8080 \
    -p 50000:50000 \
    -v jenkins-home:/var/jenkins_home \
    --name=jenkins \
    jenkins/jenkins:lts

exit 0
