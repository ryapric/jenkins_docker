#!/usr/bin/env sh
set -e

# Make sure user is is repo directory
if [ ! -f docker-run.sh ] || [ ! -f Dockerfile ]; then
    printf "Needed files not found; are you in project root?\n" >/dev/stderr
    exit 1
fi

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
sh docker-run.sh jenkins_docker

printf "
All set! Paste the following Admin Password in the prompt in your browser,
at the Jenkins machines IP address, port 8080 (it might take a minute to appear below):
"

docker container exec jenkins sh -c "
    while [ ! -f /var/jenkins_home/secrets/initialAdminPassword ]; do
        sleep 1
    done
    cat /var/jenkins_home/secrets/initialAdminPassword
"

exit 0
