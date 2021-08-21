library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("shinymaterial")

# Create a scatter plot that will tell whether there's a correlation between
# unemployment and the median household income for each state.
#
# Call a function that will have a parameter of two dataframes and the input
# of year
create_scatter_plot <- function(df1, df2, year) {
  year_2 <<- year
  # change from abbreviated state name to full name
  df1$state <- state.name[match(df1$Stabr, state.abb)]

  # manipulate df1: get the states and their average unemployment rate
  unemployment_info <- df1 %>%
    select(c("state", starts_with(c("Unemployment")))) %>%
    group_by(state) %>%
    summarize_all(mean, na.rm = T) %>%
    filter(!state %in% NA) %>%
    group_by(state) %>%
    summarize_all(round, 1) %>%
    select(c("state", ends_with(as.character(year_2))))

  # manipulate df2
  median_income_info <- df2 %>%
    select(c("State", starts_with(c("Median.income")))) %>%
    # filter out the row with state of "United States" and DC
    filter(!State %in% c("United States", "District of Columbia")) %>%
    rename(
      state = "State"
    ) %>%
    select(c("state", ends_with(as.character(year_2))))

  # combine these two dataframe (left join)
  combined_info <- left_join(unemployment_info, median_income_info,
    by = "state"
  )


  # modify col names for chart
  scatter_info <- combined_info %>% # keep in mind if error
    rename(
      State = "state",
      "Unemployment_Rate" = 2,
      "Median_Household_Income" = 3
    )

  # convert values with "," to usable values
  scatter_info[, 2:3] <- lapply(scatter_info[, 2:3], function(df) {
    as.numeric(gsub(",", "", df))
  })

  # create scatter plot
  p <- ggplot(data = scatter_info, aes_string(
    x = "Median_Household_Income",
    y = "Unemployment_Rate"
  )) +
    geom_point(mapping = aes_string(color = "State")) +
    labs(x = "Median Income (in USD)", y = "Unemployment Rate (%)") +
    ggtitle(paste("Year:", as.character(year_2))) +
    theme(plot.title = element_text(hjust = 0.5)) +
    geom_smooth(method = "lm", se = F)
  p <- ggplotly(p)
  return(p)
}
