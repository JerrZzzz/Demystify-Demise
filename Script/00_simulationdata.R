#### Preamble ####
# Purpose: A Comprehensive Analysis of Top 6 Causes of Death in 2020
# Author: Zhijun Zhong & Xincheng Zhang
# Date: 10 March 2024
# Contact: Jerryzz.zhong@mail.utoronto.ca / xinchenggg.zhang@mail.utoronto.ca

## Data resource

### Service Alberta. 2023. “Leading Causes of Death.” Government of Alberta;https://open.alberta.ca/opendata/leading-causes-of-death; Service Alberta.

### Data can be accessed by the above link and press the download bottom or
### using this link: https://open.alberta.ca/dataset/03339dc5-fb51-4552-97c7-853688fc428d/resource/3e241965-fee3-400e-9652-07cfbf0c0bda/download/deaths-leading-causes.csv

### workplace setup ###
library(opendatatoronto)
library(dplyr)
library(readr)
library(janitor)
library(stringr)
library(tibble)

# set seed for reproduction purpose
set.seed(11964)

# Simulate data using rnbinom function to simulate death 
alberta_death_simulation <-
  tibble(
    cause = rep(x = c("Heart", "Stroke", "Covid", "Atherosclerotic", "Neoplasm", "Organic dementia"), times = 10),
    year = rep(x = 2009:2020, times = 10, length.out=30),
    deaths = rnbinom(n = 30, size = 20, prob = 0.1)
  )

# write it out as a csv file under location output -> data. 
write_csv(x = alberta_death_simulation, "/cloud/project/Output/Data/simulationdata.csv")

