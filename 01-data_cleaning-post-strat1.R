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
census_raw_data <- read_csv("usa_00003.csv.gz")


# Add the labels
census_raw_data <- labelled::to_factor(census_raw_data)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
cleaned_data <- 
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
         
cleaned_data <- 
  cleaned_data %>% 
  filter(HHINCOME!=9999999) %>%
  filter(age>=18) %>%
  mutate(race_ethnicity=factor(case_when(
    RACE==1 ~ 1,
    RACE==2 ~ 2,
    RACE==3 ~ 3,
    RACE==4|RACE==5|RACE==6 ~ 4,
    TRUE ~ 5)),
    sex=factor(SEX),
    age=as.integer(AGE),
    household_income=ifelse(
      HHINCOME>=63179,
      "above_median",
      "below_median"
    )
  ) %>%
  select(age, sex, race_ethnicity, household_income)
#### What's next? ####

cleaned_data <- 
  cleaned_data %>%
  filter(age>=18) %>%
  group_by(age,sex,race_ethnicity, household_income) %>%
  summarize(n=n())

## Here I am only splitting cells by age, but you 
## can use other variables to split by changing
## count(age) to count(age, sex, ....)
# Saving the census data as a csv file in my
# working directory
write_csv(cleaned_data, "census_data.csv")



         