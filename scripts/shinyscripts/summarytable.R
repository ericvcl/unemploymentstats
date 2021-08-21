library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("shinymaterial")

# create table for summary page
create_table <- function(df1, df2, df3) {
  # manipulate data in frame 1
  # convert state abb to full name for table
  df1$state <- state.name[match(df1$Stabr, state.abb)]

  # manipulate data in frame 1
  ue_dataframe <- df1 %>%
    select(c("state", starts_with(c("Unemployment")))) %>%
    group_by(state) %>%
    summarize_all(mean, na.rm = T) %>%
    filter(!state %in% NA) %>%
    group_by(state) %>%
    summarize_all(round, 1) %>%
    mutate("UnemploymentRate" = rowMeans(select(., all_of(12:21)))) %>%
    select(c("state", ends_with("Rate")))

  # manipulate data in fram 2
  median_income_dataframe <- df2 %>%
    select(c("State", starts_with(c("Median.income")))) %>%
    # filter out the row with state of "United States"
    filter(!State %in% c("United States", "District of Columbia")) %>%
    rename(
      state = "State"
    ) %>%
    select(c("state", starts_with("Median.income"))) %>%
    select(c("state", !ends_with(".")))

  # convert values with "," to usable values
  median_income_dataframe[, 2:20] <- lapply(
    median_income_dataframe[, 2:20],
    function(df) {
      as.numeric(gsub(",", "", df))
    }
  )

  median_income_dataframe <- median_income_dataframe %>%
    mutate("Median Income" = rowMeans(select(., all_of(2:11)))) %>%
    select(c("state", ends_with("Income")))

  # manipulate data in frame 3
  pop_dataframe <- df3 %>%
    select(c("States", starts_with("year")))

  # convert values with "," to usable values
  pop_dataframe[, 2:11] <- lapply(pop_dataframe[, 2:11], function(df) {
    as.numeric(gsub(",", "", df))
  })

  pop_dataframe <- pop_dataframe %>%
    filter(!States %in% c(
      "District of Columbia",
      "Puerto Rico",
      "United States"
    )) %>%
    rename(
      state = "States"
    ) %>%
    mutate("Population" = rowMeans(select(., all_of(2:11)))) %>%
    select(c("state", ends_with("Population")))

  # combine datafraes into final table

  summary_table <- left_join(ue_dataframe,
    median_income_dataframe,
    by = "state"
  ) %>%
    left_join(pop_dataframe, by = "state") %>%
    arrange(-UnemploymentRate) %>%
    rename(
      "State" = 1,
      "Unemployment Rate" = 2,
      "Median Income (USD)" = 3
    )

  return(summary_table)
}
