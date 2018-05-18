# /usr/bin/env sh
set -e

# Check for container name passed to script
if [ -z "$1" ]; then
    printf "You must provide the name of the running Jenkins container, via 'sh add_R_pkgs.sh {jenkins_container_name}'\n"
    exit 1
fi

docker container exec "$1" \
    Rscript -e " \
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
            dependencies = TRUE, \
            repos = 'https://cran.rstudio.com')"
