library("dplyr")

# returns summary info for Unemployment.csv data in form of a list
info_summary <- function(df) {

  ### Average Unemployment rate 2000 - 2019

  ue_rate_row_sums <- df %>%
    select(starts_with("Unemployment_rate_")) %>%
    rowSums()

  avg_ue_rate <- (ue_rate_row_sums[1] / 20)

  ### Average Civilian Labor Force 2000 - 2019

  clf_data <- df %>%
    select(starts_with("Civilian_labor_force_")) %>%
    slice(1)

  # Convert chr to numeric
  clf_data <- as.numeric(gsub(",", "", clf_data))

  avg_clf <- mean(clf_data)

  ### Average number of employed 2000 - 2019

  employed_data <- df %>%
    select(starts_with("Employed")) %>%
    slice(1)

  # Convert chr to numeric
  employed_data <- as.numeric(gsub(",", "", employed_data))

  avg_employed <- mean(employed_data)

  ### Average number of unemployed 2000 - 2019

  unemployed_data <- df %>%
    select(starts_with("Unemployed")) %>%
    slice(1)

  # Convert chr to numeric
  unemployed_data <- as.numeric(gsub(",", "", unemployed_data))

  avg_unemployed <- mean(unemployed_data)

  ### State with highest average unemployment in the last year (2019)

  # convert state abb to full name
  df$state <- state.name[match(df$Stabr, state.abb)]

  highest_avg_ue_2019 <- df %>%
    select(c("state", starts_with("Unemployment_rate_"))) %>%
    group_by(state) %>%
    summarize(
      ue_rate = mean(Unemployment_rate_2019, na.rm = T)
    ) %>%
    filter(!state %in% NA) %>%
    filter(ue_rate == max(ue_rate, na.rm = T)) %>%
    pull(state)

  ### State with lowest average unemployment in the last year (2019)

  lowest_avg_ue_2019 <- df %>%
    select(c("state", starts_with("Unemployment_rate_"))) %>%
    group_by(state) %>%
    summarize(
      ue_rate = mean(Unemployment_rate_2019, na.rm = T)
    ) %>%
    filter(!state %in% NA) %>%
    filter(ue_rate == min(ue_rate, na.rm = T)) %>%
    pull(state)


  # Put values into list
  df_summary <- list()
  df_summary$avg_ue_rate <- avg_ue_rate
  df_summary$avg_clf <- format(avg_clf, scientific = F)
  df_summary$avg_employed <- format(avg_employed, scientific = F)
  df_summary$avg_unemployed <- format(avg_unemployed, scientific = F)
  df_summary$highest_avg_ue_2019 <- highest_avg_ue_2019
  df_summary$lowest_avg_ue_2019 <- lowest_avg_ue_2019

  return(df_summary)
}
