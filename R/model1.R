

library(caret)
library(tidyverse)
library(here)

training <- as_tibble(read.csv(here("data", "bagim-train.csv")))
testing <- as_tibble(read.csv(here("data", "bagim-test.csv")))

control <- trainControl(method = 'cv', number = 5)
model <- train(
  order ~ .,
  data = training,
  method = 'rf',
  trControl = control
)

source(here("R", "utilities.R"))
submit(model, testing)