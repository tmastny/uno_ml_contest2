

library(caret)
library(tidyverse)
library(here)
library(leadr)

models <- board() %>%
  filter(group == 3) %>%
  to_list()

predictions <- oof_grab(models)

index <- board() %>%
  filter(id == 15) %>%
  .$index %>%
  .[[1]]

control <- trainControl(method = 'cv', number = 5, 
                        savePredictions = 'final', index = index)
model <- train(
  order ~ .,
  data = predictions,
  method = 'xgbTree',
  trControl = control
)

board(model, dir = "ensembles")
source(here("R", "utilities.R"))


# need to simplify this process

test_bagim_dcs <- as_tibble(read.csv(here("data", "bagim-dcs-test.csv")))
test_bagim <- as_tibble(read.csv(here("data", "bagim-test.csv")))
test_dfs <- list(bagim = test_bagim, `bagim-dcs` = test_bagim_dcs)

testing <- list()
test_types <- board() %>% filter(group == 3) %>% .$dir

for (i in 1:length(models)) {
  testing[[i]] <- test_dfs[[test_types[i]]]
}

test_predictions <- purrr::map2(models, testing, ~predict(.x, newdata = .y))

names(test_predictions) <- names(predictions)[1:length(models)]
test_predictions <- as_tibble(test_predictions)


submit(model, test_predictions)



