

library(tidyverse)
library(magrittr)
library(recipes)
library(here)

source(here("R", "utilities.R"))

train <- read_csv(here("data", "train.csv"))
test <- read_csv(here("data", "test.csv"))

train %<>%
  fix_customerid() %>%
  na_handler()

test %<>%
  fix_customerid() %>%
  na_handler()

write.csv(train, here("data", "raw-zero-train.csv"))
write.csv(test, here("data", "raw-zero-test.csv"))


