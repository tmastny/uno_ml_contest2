

unique_sessioner <- function(data) {
  data %>%
    group_by(sessionID) %>%
    mutate(row_id = row_number()) %>%
    mutate(session_nums = max(row_id)) %>%
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






