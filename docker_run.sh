#! /usr/bin/env sh
set -e

# Stop & remove container, if running
docker container stop jenkins && docker container rm jenkins

# Run, mounting a few volumes
# Note that the R library is version-specific
docker container run \
    -d \
    -p 8080:8080 \
    -p 50000:50000 \
    -v jenkins_home:/var/jenkins_home/ \
    --name jenkins \
    "$1"

exit 0
