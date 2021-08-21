library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("shinymaterial")

# create scatterplot for page 2
create_scatter_plot1 <- function(df1, df2, year) {
  year <<- year
  # manipulate data in frame 1
  # convert state abb to full name for table
  df1$state <- state.name[match(df1$Stabr, state.abb)]

  # manipulate data in frame 1
  ue_data <- df1 %>%
    select(c("state", starts_with(c("Unemployment")))) %>%
    group_by(state) %>%
    summarize_all(mean, na.rm = T) %>%
    filter(!state %in% NA) %>%
    group_by(state) %>%
    summarize_all(round, 1) %>%
    select(c("state", ends_with(as.character(year))))

  # manipulate data in frame 2
  pop_data <- df2 %>%
    select(c("States", starts_with(c("year")))) %>%
    filter(!States %in% c(
      "District of Columbia",
      "Puerto Rico",
      "United States"
    )) %>%
    rename(
      state = "States"
    ) %>%
    select(c("state", ends_with(as.character(year))))

  # combine dataframes
  joined_data <- left_join(ue_data, pop_data, by = "state")

  # convert values with "," to usable values
  joined_data[, 2:3] <- lapply(joined_data[, 2:3], function(df) {
    as.numeric(gsub(",", "", df))
  })

  # modify col names for chart
  scatter_data <- joined_data %>%
    rename(
      State = "state",
      "Unemployment_Rate" = 2,
      "Population" = 3
    )

  # create scatter plot
  p <- ggplot(data = scatter_data, aes_string(
    x = "Population",
    y = "Unemployment_Rate"
  )) +
    geom_point(mapping = aes_string(color = "State")) +
    labs(x = "Populuation", y = "Unemployment Rate (%)") +
    ggtitle(paste("Year:", as.character(year))) +
    theme(plot.title = element_text(hjust = 0.5)) +
    geom_smooth(method = "lm", se = F)
  p <- ggplotly(p)
  return(p)
}
