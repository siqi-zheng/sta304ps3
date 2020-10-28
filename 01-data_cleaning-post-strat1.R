#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander and Sam Caetano [CHANGE THIS TO YOUR NAME!!!!]
# Data: 22 October 2020
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data.
setwd("C:\Users\timot\Desktop\STA304A1\PS3")
census_raw_data <- read_csv("usa_00003.csv.gz")


# Add the labels
census_raw_data <- labelled::to_factor(census_raw_data)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
reduced_data <- 
  census_raw_data %>% 
  select(SEX, 
         AGE, 
         RACE,
         HHINCOME)
         #stateicp,
         
         #hispan,
         #marst, 
         #bpl,
         #citizen,
         #educd,
         #labforce,
         #labforce)
         

#### What's next? ####

## Here I am only splitting cells by age, but you 
## can use other variables to split by changing
## count(age) to count(age, sex, ....)

reduced_data <- 
  reduced_data %>%
  count(age) %>%
  group_by(age) 

reduced_data <- 
  reduced_data %>% 
  filter(age != "less than 1 year old") %>%
  filter(age != "90 (90+ in 1980 and 1990)")

reduced_data$age <- as.integer(reduced_data$age)

# Saving the census data as a csv file in my
# working directory
write_csv(reduced_data, "outputs/census_data.csv")



         