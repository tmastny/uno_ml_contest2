

library(caret)
library(tidyverse)
library(here)
library(leadr)

training <- as_tibble(read.csv(here("data", "nf-bagim-train.csv")))[, -1]
testing <- as_tibble(read.csv(here("data", "nf-bagim-test.csv")))[, -1]

index <- board() %>%
  filter(id == 4) %>%
  .$index %>%
  .[[1]]

control <- trainControl(method = 'cv', number = 5, 
                        savePredictions = 'final', index = index)
model <- train(
  order ~ .,
  data = training,
  method = 'gbm',
  trControl = control
)

board(model, dir = "nf-bagim")
source(here("R", "utilities.R"))
submit(model, testing)

 

