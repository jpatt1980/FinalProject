# start from the rstudio/plumber image
FROM rocker/r-ver:4.4.1

# install the linux libraries needed for plumber
RUN apt-get update -qq && apt-get install -y  libssl-dev  libcurl4-gnutls-dev  libpng-dev

# install plumber, tidyverse, dplyr, caret, arm
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('plumber')"
RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('caret')"
RUN R -e "install.packages('arm')"

# copy everything from the current directory into the container
COPY diabetes_binary_health_indicators_BRFSS2015.csv diabetes_binary_health_indicators_BRFSS2015.csv
COPY FinalProjectAPI.R FinalProjectAPI.R

# open port to traffic
EXPOSE 8000

# when the container starts, start the FinalProjectAPI.R script
ENTRYPOINT ["R", "-e", \
    "pr <- plumber::plumb('FinalProjectAPI.R'); pr$run(host='0.0.0.0', port=8000)"]