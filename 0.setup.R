# Title: Survey Data Analysis

# Purpose : This project is based on data cleaning special survey data. 
#           The project will highlight everything you need in data wrangling


# Project number: #001

# Author: Mohamed Iabrahim


# Date script created:        2023-05-29  7:39:00pm 
# Date script last modified: Thu Dec 12 16:07:12 2019 ----

# create directory called 'data'
dir.create('root')
dir.create('R')
dir.create('Rmd')
dir.create('results')
dir.create('scripts')


# create subdirectory raw_data in the data directory
dir.create('data/raw')
dir.create('data/processed')
dir.create('data/clean')
dir.create('data/metadata') 


dir.create('results/html')
dir.create('results/figures')
dir.create('results/docs')

# list the files and directories
list.files(recursive = TRUE, include.dirs = TRUE)




# good practice to include session information

xfun::session_info()
