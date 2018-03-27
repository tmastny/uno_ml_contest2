

library(caret)
library(tidyverse)
library(here)

source(here("R/cleaners.R"))
source(here("R/manager.R"))

train <- read_csv(here("train.csv"))
train <- train %>%
  unique_sessioner() %>%
  dater() %>%
  na.omit()

control <- trainControl(method = 'cv', number = 5)
model <- train(
  order ~ .,
  data = train,
  method = 'rf',
  trControl = control
)

# doesn't work, missing a bunch of NAs so can't submit
test <- read_csv(here("test.csv"))
test <- test %>%
  unique_sessioner() %>%
  dater() %>%
  na.omit()

submit(model, test)


