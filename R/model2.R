

library(caret)
library(tidyverse)
library(here)

training <- as_tibble(read.csv(here("data", "bagim-train.csv")))
testing <- as_tibble(read.csv(here("data", "bagim-test.csv")))

index <- board() %>%
  filter(id == 1) %>%
  .$index

control <- trainControl(method = 'cv', number = 5, index = index[[1]], 
                        savePredictions = 'final')
model <- train(
  order ~ .,
  data = training,
  method = 'xgbTree',
  trControl = control
)

leadr::board(model, dir = "bagim")
source(here("R", "utilities.R"))
submit(model, testing)