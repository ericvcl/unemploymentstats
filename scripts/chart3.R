# Load necessary packages
library("dplyr")
library("leaflet")
library("ggplot2")
library("maps")

# This function will return a choropleth map that compares the number of
# individuals unemployed in 2000.
map <- function(df) {

  # Make the state name from abbreviate to full name.
  df <- df %>% mutate(state = state.name[match(Stabr, state.abb)])

  # Convert "," in the data frame to usable numbers so that later when creating
  # the chart, it would be easier to use.
  df[, 7:88] <- lapply(df[, 7:88], function(df) {
    as.numeric(gsub(",", "", df))
  })

  # Create another dataframe that filter to only the relevant information
  # that could be used lately for the chart.
  # In this case the new dataframe would only include "unemployment" relevant
  # information over the years.
  table_info <- df %>%
    select(c("state", starts_with("Unemployment"))) %>%
    group_by(state) %>%
    summarize_all(mean, na.rm = T) %>%
    filter(!state %in% NA)

  # Get the state data frame.
  states_info <- map_data("state")

  # Add a column that tells the name of the state
  table_info <- table_info %>%
    mutate(region = tolower(state)) %>%
    select(-state)

  # Combine the filtered data frame with the states name and their longitude
  # and latitude
  combined_info <- inner_join(states_info, table_info, by = "region")

  # Create the choropleth map that would include the information about the
  # number of individuals of unemployment in each state in 2000.
  choropleth_map_info <- ggplot() +
    geom_polygon(data = combined_info, aes(
      x = long, y = lat,
      fill = Unemployment_rate_2000,
      text = paste(
        "State: ", region, "<br>",
        "Unemployment Rate: ",
        Unemployment_rate_2000
      )
    )) +
    scale_fill_continuous(
      low = "yellow", high = "red",
      name = "Unemployment Rate 2000",
      limits = c(0, 7)
    ) +
    theme(
      rect = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.title.y = element_blank(),
      axis.title.x = element_blank()
    )

  # Update the map and make it interactive
  choropleth_map_info <- ggplotly(choropleth_map_info, tooltip = "text")

  # Return the map.
  return(choropleth_map_info)
}
