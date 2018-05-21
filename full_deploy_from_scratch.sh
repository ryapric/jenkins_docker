#!/usr/bin/env sh
set -e

# Clone repo & set workdir
printf "Grabbing needed data from repo...\n"
git clone https://github.com/ryapric/jenkins_docker.git && cd jenkins_docker

# Install Docker
if [ -z "$(which docker)" ]; then
    printf "Installing Docker...\n"
    curl -sSL https://get.docker.com | sh
fi

# Build image
printf "Building Jenkins image...\n"
docker build -t jenkins_docker .

# Run container
printf "Starting container...\n"
sh docker_run.sh jenkins_docker

printf "
All set! Paste the following Admin Password in the prompt in your browser,
at the Jenkins machines IP address, port 8080:
"

docker container exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

exit 0
