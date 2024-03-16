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

# Input data 

c1 <- read_csv("/cloud/project/Model/Model_Parquet.csv")
c2 <- read_csv("/cloud/project/Data/Analysis_Data/deathoforganicdementia.csv") 
raw <- read_csv("/cloud/project/Data/Raw_Data/rawdata.csv")
simulate <- read_csv("/cloud/project/Data/Analysis_Data/simulationdata.csv")

# test for clean 1 data 

## test 1 all calendar_year is 2020

all(c1$calendar_year == 2020)

## Test 2 all cause is different 

!any(duplicated(c1$cause))

## Test 3 all total death is numeric 

is.numeric(c1$total_deaths)

# test for clean 2 data 

## all calendar_year are from 2000 to 2024 

all(c2$calendar_year >= 2000 & c2$calendar_year <= 2024)

## all caused_grouped are string 

is.character(c2$cause_grouped)

## all ranking are 1 to 100 

all(c2$ranking >= 1 & c2$ranking <= 100)

# test for raw data 

## all calendar_year are from 2000 to 2024 

all(raw$calendar_year >= 2000 & raw$calendar_year <= 2024, na.rm = TRUE)

## all ranking are 1 to 100 

all(raw$ranking >= 1 & raw$ranking <= 100, na.rm = TRUE)

# test for simulation 

## all caused_grouped are string 

is.character(simulate$cause)

## all calendar_year are from 2000 to 2024 

all(simulate$year >= 2000 & simulate$year <= 2024)

