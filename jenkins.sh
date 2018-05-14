#! /usr/bin/env sh
set -e

# Stop & remove container, if running
docker container stop jenkins && docker container rm jenkins

# Run, mounting a few volumes
docker container run \
    -d \
    -p 8080:8080 \
    -p 50000:50000 \
    -v jenkins_home:/var/jenkins_home/ \
    -v R_lib_jenkins:/usr/local/lib/R/site-library/ \
    --name jenkins \
    jenkins_plus

exit 0
