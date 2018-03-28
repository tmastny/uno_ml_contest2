

library(caret)
library(tidyverse)
library(here)

training <- as_tibble(read.csv(here("data", "bagim-dcs-train.csv")))
testing <- as_tibble(read.csv(here("data", "bagim-dcs-test.csv")))

control <- trainControl(method = 'cv', number = 5, 
                        savePredictions = 'final')
model <- train(
  order ~ .,
  data = training,
  method = 'rf',
  trControl = control
)

leadr::board(model, dir = "bagim-dcs")
source(here("R", "utilities.R"))
submit(model, testing)