

submit <- function(model) {
  test <- read_csv(here("test.csv"))
  write_csv(data.frame(sessionID = 1:5111,
                       order = predict(model, test)),
            here("subs", paste0("sub_1")))
}
