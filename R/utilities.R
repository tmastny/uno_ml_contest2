

unique_sessioner <- function(data) {
  data %>%
    group_by(sessionID) %>%
    mutate(row_id = row_number()) %>%
    mutate(session_nums = max(row_id)) %>%
    mutate_if(
      ~any(is.na(.)), 
      ~ifelse(all(is.na(.)), NA, max(., na.rm = TRUE))) %>%
    filter(row_id == max(row_id)) %>%
    ungroup() %>%
    select(-row_id)
}

dater <- function(data) {
  dater_ <- function(new_hours, new_day) {
    fake_date <- ymd("1999/1/1")
    hour(fake_date) <- new_hours
    day(fake_date) <- new_day
    as.POSIXct(fake_date)
  }
  data %>%
    mutate(time = dater_(hour, weekday))
}

# submit <- function(model, data) {
#   write_csv(data.frame(sessionID = 1:5111,
#                        order = predict(model, newdata = data)),
#             here("subs", paste0("sub_1")))
# }


