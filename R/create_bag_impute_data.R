

library(tidyverse)
library(magrittr)
library(recipes)
library(here)

source(here("R", "cleaners.R"))

train <- read_csv(here("data", "train.csv"))
test <- read_csv(here("data", "test.csv"))

train %<>%
  unique_sessioner()

test %<>%
  unique_sessioner()

bag_impute_rec <- recipe(order ~ ., data = train) %>%
  step_bagimpute(all_predictors()) %>%
  prep(training = train)

train <- bake(bag_impute_rec, newdata = train)
test <- bake(bag_impute_rec, newdata = test)

write_csv(train, here("data", "bagim-train.csv"))
write_csv(train, here("data", "bagim-test.csv"))


