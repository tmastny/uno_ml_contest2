

library(caret)
library(tidyverse)
library(here)
library(leadr)

training <- as_tibble(read.csv(here("data", "bagim-train.csv")))
testing <- as_tibble(read.csv(here("data", "bagim-test.csv")))

index <- board() %>%
  filter(id == 4) %>%
  .$index %>%
  .[[1]]

control <- trainControl(method = 'cv', number = 5, 
                        savePredictions = 'final', index = index)
model <- train(
  order ~ .,
  data = training,
  method = 'gcvEarth',
  trControl = control
)

board(model, dir = "bagim")
source(here("R", "utilities.R"))
submit(model, testing)



