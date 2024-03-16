#### Preamble ####
# Purpose: A Comprehensive Analysis of Top 6 Causes of Death in 2020
# Author: Zhijun Zhong & Xincheng Zhang
# Date: 10 March 2024
# Contact: Jerryzz.zhong@mail.utoronto.ca / xinchenggg.zhang@mail.utoronto.ca

## Data resource

### Service Alberta. 2023. “Leading Causes of Death.” Government of Alberta;https://open.alberta.ca/opendata/leading-causes-of-death; Service Alberta.

### Data can be accessed by the above link and press the download bottom or
### using this link: https://open.alberta.ca/dataset/03339dc5-fb51-4552-97c7-853688fc428d/resource/3e241965-fee3-400e-9652-07cfbf0c0bda/download/deaths-leading-causes.csv


### Workspace setup ###

library(readr)
library(dplyr)
library(tidyverse)

rawdata <- read_csv("/cloud/project/Data/Raw_Data/rawdata.csv")

rawdata <- rawdata %>%
  select(calendar_year, cause, total_deaths, ranking)

## drop na values
rawdata <- rawdata[!is.na(rawdata$calendar_year), ] 

# clean the origial dataset "(blank)" value with previous year same rank
rawdata_updated <- rawdata

for(i in 1:nrow(rawdata)) {
  if(rawdata$cause[i] == "( Blank )") {
    target_year <- rawdata$calendar_year[i] + 1
    target_ranking <- rawdata$ranking[i]
    matching_cause <- rawdata %>%
      filter(calendar_year == target_year, ranking == target_ranking) %>%
      pull(cause)
    if(length(matching_cause) > 0) {
      rawdata_updated$cause[i] <- matching_cause[1]
    }
  }
}

## test if there is any changes made
changes <- which(rawdata_updated$cause != rawdata_updated$cause)
if(length(changes) > 0) {
  message("Changes were made at rows: ", paste(changes, collapse = ", "))
} else {
  message("No changes were made. Please verify criteria and data integrity.")
}

# clean 1: clean data for ploting data 
## filter wanted causes
clean1 <- rawdata_updated %>%
  filter(cause %in% c("Organic dementia", "All other forms of chronic ...", 
                              "Malignant neoplasms of trac...", "Other ill-defined and unkno...", 
                              "Other chronic obstructive p...", "COVID-19, virus identified"))
## filter wanted year
clean1 <- clean1 %>%
  filter(calendar_year == 2020)

# clean 2, prepare for modeling
## count the total death because of neoplasms for each year 
rawdata_updated <- rawdata_updated %>%
  mutate(cause_grouped = if_else(str_detect(cause, "neoplasms"), "neoplasms", cause))

### create new dataset based on this
grouped_data <- rawdata_updated %>%
  group_by(calendar_year, cause_grouped) %>%
  summarise(total_death = sum(total_deaths), .groups = 'drop')

grouped_data <- grouped_data %>%
  group_by(calendar_year, cause_grouped) %>%
  summarise(total_death = sum(total_death), .groups = 'drop')

## create rank column to rank the death total for each year
grouped_data <- grouped_data %>%
  group_by(calendar_year) %>%
  mutate(ranking = rank(-total_death))

## drop make ranking and calendar_year number type
grouped_data$calendar_year <- as.numeric(grouped_data$calendar_year)

grouped_data$ranking <- as.integer(grouped_data$ranking)

# Write out our cleaned data
write_csv(x = clean1, 
          "/cloud/project/Model/Model_Parquet.csv")

write_csv(x = grouped_data, 
          "/cloud/project/Data/Analysis_Data/deathoforganicdementia.csv")

