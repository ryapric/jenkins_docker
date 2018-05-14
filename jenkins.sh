#! /usr/bin/env sh
set -e

# Pull latest LTS image
docker pull jenkins/jenkins:lts

# Stop & remove container, if running
docker container stop jenkins && docker container rm jenkins

# Run, mounting a few volumes
docker container run \
    -d \
    -p 8080:8080 \
    -p 50000:50000 \
    -v jenkins_home:/var/jenkins_home \
    -v jenkins_apt_vol:/usr/bin/ \
    -v R_lib_jenkins:/usr/local/lib/R/site-library/ \
    --name jenkins \
    jenkins/jenkins:lts

# Notes
printf "
================================================================================

This run script has mounted several appropriate volumes for persistent storage,
including the image's deb-package directory (/usr/bin/), as well as any volumes
needed for persistent use of any expected additional software.
You may wish to also setup this Jenkins container with the following tools,
via the following setup commands once inside the container
(via 'docker exec -u root -ti jenkins bash'):

    [R]
    $ git clone https://www.github.com/ryapric/install_R.git /var/jenkins_home/install_R
    $ bash /var/jenkins_home/install_R/install_R.bash
    $ # Then follow the prompts for desired functionality
    
    (fighting with all this in a Dockerfile sucks ass, so)

================================================================================
"

exit 0
