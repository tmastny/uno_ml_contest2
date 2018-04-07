

library(caret)
library(tidyverse)
library(here)
library(leadr)

training <- as_tibble(read.csv(here("data", "nf-zero-d-train.csv")))
testing <- as_tibble(read.csv(here("data", "nf-zero-d-test.csv")))

index <- board() %>%
  filter(id == 4) %>%
  .$index %>%
  .[[1]]

control <- trainControl(method = 'cv', number = 5, 
                        savePredictions = 'final', index = index)
model <- train(
  order ~ .,
  data = training,
  method = 'rpart',
  trControl = control
)

board(model, dir = "nf-zero-d")
source(here("R", "utilities.R"))
submit(model, testing)

 

