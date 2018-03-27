

d <- readr::read_csv("train.csv")

library(tidyverse)


d %>%
  group_by(sessionID) %>%
  mutate(row_id = row_number()) %>%
  filter(row_id == max(row_id)) %>%
  ungroup() %>%
  select(-row_id)
