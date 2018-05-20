FROM jenkins/jenkins:lts

# To use Docker agent for jobs, need to install some things, so requires a custom image
USER root
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        sudo \
        libltdl-dev \
    && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
