library("plotly")
library("dplyr")


chart_1 <- function(df) {

  # Created states column

  df$state <- state.name[match(df$Stabr, state.abb)]

  # Created data frame for my plot

  table_info <- df %>%
    select(c("state", starts_with("Unemployment"))) %>%
    group_by(state) %>%
    summarize_all(mean, na.rm = T) %>%
    filter(!state %in% NA)

  # Created bar graph

  chart_1 <- plot_ly(
    table_info,
    x = ~Unemployment_rate_2019,
    y = ~state,
    type = "bar",
    orientation = "h",
    color = ~state,
    height = 800
  ) %>%
    layout(
      title = "Unemployment Rate by State in 2019",
      xaxis = list(title = "Unemployment Rate (%) in 2019", ticksuffix = "%"),
      yaxis = list(title = "States in U.S.")
    )
  return(chart_1)
}
