Docker Image Builder & Run Utilities for Jenkins
================================================
Ryan Price, <ryapric@gmail.com>

This repository serves as a set of tools to deploy a [Jenkins
CI](https://jenkins.io/) instance with just a few short commands. The Jenkins
master is deployed as a [Docker](https://www.docker.com/) container, and is
designed to run its jobs using Docker, as well! This works by [binding the
host's Docker socket and binary path, to the Jenkins
container](https://forums.docker.com/t/using-docker-in-a-dockerized-jenkins-container/322),
which makes the host installation of Docker available to Jenkins without a
redundant second installation.

All of the work done to configure Jenkins jobs, users, credentials, etc. are all
stored persistently, even if the container is stopped, via mounting a Docker
volume named "jenkins_home". So, just because your container goes down, doesn't
mean you ever have to re-do the initial set-up described in this `README`.

Prerequisites
-------------

1. A browser to access to the host machine's IP address (if local, then
`localhost`; if deploying to the cloud, then use your best judgement on how to
proceed)

1. Docker

1. A machine with a supported (x86-64) OS installed:
    - Debian
    - Ubuntu
    - Fedora
    - CentOS
    - Raspbian (though you'll need to know the right Docker images to use for
    ARM architectures; not supported in this repo's default config)

1. 20 extra minutes for a one-time manual set-up of Jenkins administrative tools
(users, plugins, etc).

How To Deploy
-------------

_**!!! Reminder to always review every bit of code that you get from the internet !!!**_

Actual deployment of the Jenkins container is very easy, even if Docker isn't
yet installed. The full step-by-step instructions, from "I have nothing" to
running the Jenkins container, are as follows:

1. Clone this repo, and `cd` inside:
    - `git clone https://github.com/ryapric/jenkins_docker.git && cd jenkins_docker`

1. Install Docker. Recent means of Docker installation is quite easy, via their
official install script, which can be run via:
    - `curl -sSL https://get.docker.com | sh`

1. Build a modified Jenkins image using the included `Dockerfile`. This is
unfortunately necessary because to use Docker build agents, inside of Docker, at
least one other `deb` package needs to be installed (`libltdl-dev`). You can
build an image via (feel free to change the image name):
    - `docker build -t jenkins_docker .`

1. Run `docker_run.sh`, with the name of the new Jenkins image as the sole
argument. This script starts an instance of the Jenkins image you just built,
mounts the `jenkins_home` Docker volume, binds ports `8080` and `50000`, and
gives the container access to the host Docker socket. The container is deployed
with the friendly name "jenkins", which is printed to `stdout` as a reminder
once the script completes successfully. If you re-run this script for any reason
after the initial run, it will automatically shut down any running containers
with the name "jenkins".
    - `sh docker_run.sh jenkins_docker`

1. Browse to `<machine-ip-address>:8080`, and paste the password that is output
from the following command. This allows you to perform the initial configuration
for the Jenkins master (you only need to do this & the next step once, as all
configs are stored in the Docker volume)
    - `docker container exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`

1. Follow the prompts to continue configuring Jenkins. They should be: install
plugins, add an Admin user, and then "Start Using Jenkins". Once you're set up,
you can install additional plugins (again, all persistent) via "Configure
Jenkins --> Manage Plugins".

_**That's it!**_ Five commands and some UI prompts, and you're all set to start
configuring your builds & jobs!

If you want to make some `docker_run` changes, just save them and re-run the
script. As stated above, it should handle the container restart for you pretty
elegantly.

If you have read & understood the above steps, and are comfortable with them,
you can also just use the one-step deployment script in this repo,
`full_deploy_from_scratch.sh`. It is important to understand all of the above,
however, since restarting the container, rebuilding the image, etc. as needed
have their own scripts.

Other Things You Can Do!
-----------------------

Feel free, of course, to fork this repository at any time, and use it as
boilerplate to VC your own desired Jenkins configurations. Some ideas:

- Modify the `Dockerfile` to build a Jenkins image that has more programs
pre-installed when the container runs (good if you don't want Docker to be the
build agent inside the Jenkins container)

- Modify the `docker_run` script to mount more volumes, change port bindings,
edit other runtime configs, etc.

- Etc.

License
-------

GPL-3
