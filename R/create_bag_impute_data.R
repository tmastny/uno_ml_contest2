

library(tidyverse)
library(magrittr)
library(recipes)
library(here)

source(here("R", "utilities.R"))

train <- read_csv(here("data", "train.csv"))
test <- read_csv(here("data", "test.csv"))

train %<>%
  unique_sessioner() %>%
  fix_customerid()

test %<>%
  unique_sessioner() %>%
  fix_customerid()

bag_impute_rec <- recipe(order ~ ., data = train) %>%
  step_modeimpute(status, availability) %>%
  step_bagimpute(all_predictors(), -status, -availability, -customerID) %>%
  prep(training = train)

train <- bake(bag_impute_rec, newdata = train)
test <- bake(bag_impute_rec, newdata = test)

write.csv(train, here("data", "bagim-train.csv"))
write.csv(test, here("data", "bagim-test.csv"))


