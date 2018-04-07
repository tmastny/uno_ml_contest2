

library(tidyverse)
library(magrittr)
library(recipes)
library(missForest)
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

matrix_rec <- recipe(order ~ ., data = train) %>%
  prep(training = train)

train <- bake(matrix_rec, newdata = train)
test <- bake(matrix_rec, newdata = test)

train_im <- missForest(as.data.frame(train))
test_im <- missForest(as.data.frame(test))

# write.csv(train, here("data", "nf-meanim-train.csv"))
# write.csv(test, here("data", "nf-meanim-test.csv"))


