

library(caret)
library(tidyverse)
library(here)
library(leadr)

training <- as_tibble(read.csv(here("data", "raw-zero-train.csv")))
testing <- as_tibble(read.csv(here("data", "raw-zero-test.csv")))

control <- trainControl(method = 'cv', number = 5, 
                        savePredictions = 'final')
model <- train(
  order ~ .,
  data = training,
  method = 'rf',
  trControl = control
)

board(model, dir = "raw-zero")
source(here("R", "utilities.R"))
submit(model, testing, filtered = TRUE)
 

