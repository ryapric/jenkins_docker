# /usr/bin/env sh
set -e

docker container exec jenkins \
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
