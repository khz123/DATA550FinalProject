# base image
FROM rocker/tidyverse:4.5.1 AS base

# create folder project
RUN mkdir /home/rstudio/project
WORKDIR /home/rstudio/project

# make sure packages install - missing library issue solution
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    cmake \
    libnode-dev \
    libv8-dev \
    libicu-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# add renv folder and related files
RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

# change default location of renv cache to project dir
RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE renv/.cache

# restore package library
RUN Rscript -e "renv::restore(prompt = FALSE)"

###### 
FROM rocker/tidyverse:4.5.1

RUN mkdir /home/rstudio/project

WORKDIR /home/rstudio/project
COPY --from=base /home/rstudio/project .

# Copy essential files
COPY Makefile ./

# Create directories
RUN mkdir ./code 
RUN mkdir ./data 
RUN mkdir ./output 
RUN mkdir ./report

# Copy raw data file
COPY data/synthetic_coffee_health_10000.csv data/

# Copy code directory contents
COPY code/ code/

# Set entrypoint to generate report
CMD ["make"]

