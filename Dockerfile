FROM jenkins/jenkins:lts

# All this shit has to be as root
USER root
WORKDIR /root

# Add Debian's CRAN GPG key
RUN apt-get update && apt-get dist-upgrade -y \
    && apt-get install -y apt-transport-https lsb-release gnupg2 \
    && apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'

# Separate RUN command, so piping to tee works. I'm open to suggested changes
RUN echo "deb https://cran.rstudio.com/bin/linux/debian $(lsb_release -cs)-cran35/" | tee -a /etc/apt/sources.list

# Install all the Linux packages you may need, then dump the cache/install deps/etc.
RUN apt-get update \
    && apt-get install -y \
        sudo \
        ed \
        less \
        locales \
        wget \
        ca-certificates \
        littler \
        r-cran-littler \
        r-base \
        r-base-dev \
        r-recommended \
        libssl-dev \
        libxml2-dev \
        libcurl4-openssl-dev \
        libcairo2-dev \
        libsqlite-dev \
        libmariadbd-dev \
        libmariadb-client-lgpl-dev \
        libpq-dev \
        libssh2-1-dev \
        unixodbc-dev \
    && apt-get clean \
    && apt-get autoclean -y \
    && apt-get autoremove -y

# Switch back to Jenkins user
USER jenkins
WORKDIR /var/jenkins_home/
