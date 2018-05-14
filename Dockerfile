FROM jenkins/jenkins:lts

USER root
WORKDIR /root

RUN apt-get update && apt-get dist-upgrade -y \
    && apt-get install -y apt-transport-https lsb-release gnupg2 \
    && apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'

RUN echo "deb https://cran.rstudio.com/bin/linux/debian $(lsb_release -cs)-cran35/" | tee -a /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y \
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
    && Rscript -e " \
        install.packages(c( \
            'tidyverse', \
            'data.table', \
            'devtools', \
            'formatR', \
            'remotes', \
            'selectr', \
            'caTools', \
            'odbc', \
            'RSQLite', \
            'RMySQL', \
            'RMariaDB', \
            'RPostgreSQL'), \
            dependencies = TRUE, repos = 'https://cran.rstudio.com')" \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
    && rm -rf /var/lib/apt/lists/*

USER jenkins
WORKDIR /var/jenkins_home/
