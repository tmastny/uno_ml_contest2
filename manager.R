

submit <- function(model, data) {
  write_csv(data.frame(sessionID = 1:5111,
                       order = predict(model, newdata = data)),
            here("subs", paste0("sub_1")))
}
