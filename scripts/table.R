library("dplyr")

sum_table <- function(df) {

  # convert df values w/ "," to usable numbers
  df[, 7:88] <- lapply(df[, 7:88], function(df) {
    as.numeric(gsub(",", "", df))
  })

  # convert state abb to full name for table
  df$state <- state.name[match(df$Stabr, state.abb)]

  # Create table
  sum_table <- df %>%
    select(c("state", starts_with("Unemployment"))) %>%
    group_by(state) %>%
    summarize_all(mean, na.rm = T) %>%
    filter(!state %in% NA) %>%
    arrange(Unemployment_rate_2015) %>%
    select(c("state", 17:21))

  return(sum_table)
}
