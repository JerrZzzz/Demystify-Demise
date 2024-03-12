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
library(rstanarm)
library(modelsummary)
library(broom)
library(broom.mixed)
library(stringr)
library(gridExtra)

# Read csv to a dataset
model <- read.csv("/cloud/project/Output/Data/Parquet.csv")

# set seed for reproduction purpose
set.seed(64)

# building models for both poisson and negative binomial
cause_of_death_alberta_poisson <-
  stan_glm(
    total_deaths ~ cause,
    data = model,
    family = poisson(link = "log"),
  )

cause_of_death_alberta_neg_binomial <-
  stan_glm(
    total_deaths ~ cause,
    data = model,
    family = neg_binomial_2(link = "log"),
  )

# find our model for poisson and negative binomial
modelsummary(
  list(
    "Poisson" = cause_of_death_alberta_poisson,
    "Negative binomial" = cause_of_death_alberta_neg_binomial
  ))

# plot pp check to find which fit better poisson or negative binomial
p1 <- pp_check(cause_of_death_alberta_poisson) +
  theme(legend.position = "bottom")+
  coord_cartesian(xlim = c(1000, 2250))

p2 <- pp_check(cause_of_death_alberta_neg_binomial) +
  theme(legend.position = "bottom")+
  coord_cartesian(xlim = c(0, 5000))

# put graphs in an arranged big graph 
graph <- grid.arrange(p1, p2, ncol = 2, nrow = 1)

# save our big graph to folder plots 
ggsave("model.jpg", graph, device = "jpeg", path = "/cloud/project/Output/Plots", width = 8, height = 6, units = "in")

# use loo function to determine using number which one fit better. 
poisson <- loo(cause_of_death_alberta_poisson, cores = 2)
neg_binomial <- loo(cause_of_death_alberta_neg_binomial, cores = 2)

# show elpd_diff 
loo_compare(poisson, neg_binomial)

