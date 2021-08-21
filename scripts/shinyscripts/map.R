library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("shinymaterial")

# create map chart
create_map <- function(df, year_from, year_to) {

  # convert state abb to full name for table
  df$state <- state.name[match(df$Stabr, state.abb)]

  # manipulate data
  map_data <- df %>%
    select(c("state", starts_with(c("Unemployment")))) %>%
    group_by(state) %>%
    summarize_all(mean, na.rm = T) %>%
    filter(!state %in% NA) %>%
    group_by(state) %>%
    summarize_all(round, 1) %>%
    mutate(
      selection_range_avg = rowMeans(select(
        .,
        all_of(((year_from + 2) - 2000):
        ((year_to + 2) - 2000))
      )),
      code = state.abb[match(.$state, state.name)]
    ) %>%
    mutate(across(starts_with("selection"), round, 1))

  # specify map options
  g <- list(
    scope = "usa",
    projection = list(type = "albers usa"),
    showlakes = TRUE,
    lakecolor = toRGB("white")
  )

  # use plotly to create map plot
  p <- plot_geo(map_data, locationmode = "USA-states") %>%
    add_trace(
      z = map_data$selection_range_avg, text = ~state, locations = ~code,
      color = map_data$selection_range_avg, colors = "Purples"
    ) %>%
    colorbar(title = "Unemployment Rate") %>%
    layout(
      title = paste(
        "Average Unemployment Rate (%), Years",
        as.character(year_from),
        "-",
        as.character(year_to)
      ),
      geo = g
    )

  return(p)
}
