

library(caret)
library(tidyverse)
library(here)
library(leadr)

training <- as_tibble(read.csv(here("data", "nf-meanim-train.csv")))
testing <- as_tibble(read.csv(here("data", "nf-meanim-test.csv")))

index <- board() %>%
  filter(id == 4) %>%
  .$index %>%
  .[[1]]

control <- trainControl(method = 'cv', number = 5, 
                        savePredictions = 'final', index = index)
model <- train(
  order ~ .,
  data = training,
  method = 'rf',
  trControl = control
)

board(model, dir = "nf-meanim")
source(here("R", "utilities.R"))
submit(model, testing)

 

