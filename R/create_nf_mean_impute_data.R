

library(tidyverse)
library(magrittr)
library(recipes)
library(here)

source(here("R", "utilities.R"))

train <- read_csv(here("data", "train.csv"))
test <- read_csv(here("data", "test.csv"))

train %<>%
  unique_sessioner2() %>%
  fix_customerid()

test %<>%
  unique_sessioner2() %>%
  fix_customerid()

bag_impute_rec <- recipe(order ~ ., data = train) %>%
  step_num2factor(salutation) %>%
  step_modeimpute(status, availability, salutation) %>%
  step_meanimpute(all_predictors(), -status, -availability, -customerID, -salutation) %>%
  step_dummy(status, availability, salutation) %>%
  prep(training = train)

train <- bake(bag_impute_rec, newdata = train)
test <- bake(bag_impute_rec, newdata = test)

write.csv(train, here("data", "nf-meanim-train.csv"))
write.csv(test, here("data", "nf-meanim-test.csv"))


