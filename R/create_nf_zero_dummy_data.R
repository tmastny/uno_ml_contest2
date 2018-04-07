

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
  na_handler()

test %<>%
  unique_sessioner2() %>%
  fix_customerid() %>%
  na_handler()

dummy_rec <- recipe(order ~ ., data = train) %>%
  step_num2factor(salutation) %>%
  step_dummy(status, availability, salutation) %>% 
  prep(training = train)

train <- bake(dummy_rec, newdata = train)
test <- bake(dummy_rec, newdata = test)


write.csv(train, here("data", "nf-zero-d-train.csv"))
write.csv(test, here("data", "nf-zero-d-test.csv"))


