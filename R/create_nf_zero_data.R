

library(tidyverse)
library(magrittr)
library(recipes)
library(here)

source(here("R", "utilities.R"))

train <- read_csv(here("data", "train.csv"))
test <- read_csv(here("data", "test.csv"))

train %<>%
  unique_sessioner2() %>%
  fix_customerid() %>%
  mutate_if(
    ~any(is.na(.)), 
    ~ifelse(is.na(.), 0, .))

test %<>%
  unique_sessioner2() %>%
  fix_customerid() %>%
  mutate_if(
    ~any(is.na(.)), 
    ~ifelse(is.na(.), 0, .))

write.csv(train, here("data", "nf-zero-train.csv"))
write.csv(test, here("data", "nf-zero-test.csv"))


