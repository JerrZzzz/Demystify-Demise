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
library(ggplot2)

# Input dataset 
cleandata <- read.csv("/cloud/project/Output/Data/deathoforganicdementia.csv")

# filter the cause we want 
cleandata <- cleandata %>%
  filter(cause_grouped %in% c("neoplasms", "Organic dementia", "Acute myocardial infarction", "COVID-19, virus identified") |
           str_detect(cause_grouped, "^Stroke") |
           str_detect(cause_grouped, "^Atherosclerotic cardiovascu"))

# Plot data using ggplot with calendar as independent variable and total death as dependent variable for 6 different causes with 6 colors.
p1 <- ggplot(cleandata, aes(x = calendar_year, y = total_death, color = cause_grouped)) +
  geom_line() + 
  theme_minimal() +
  labs(
    title = "Total Deaths by Cause Over Years",
    x = "Calendar Year",
    y = "Total Deaths",
    color = "Cause"
  ) +
  scale_x_continuous(breaks = round(seq(min(cleandata$calendar_year), max(cleandata$calendar_year), by = 1),1))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# save data to file plots 

ggsave("causeofdeath.jpg", p1, device = "jpeg", path = "/cloud/project/Output/Plots", width = 8, height = 6, units = "in")

