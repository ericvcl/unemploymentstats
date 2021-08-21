# applies applicable libraries
library("dplyr")
library("ggplot2")


pie_chart <- function(df) {
  # create state names column
  df$state <- state.name[match(df$Stabr, state.abb)]
  # convert values with "," into usable numbers
  df[, 7:88] <- lapply(df[, 7:88], function(df) {
    as.numeric(gsub(",", "", df))
  })
  # create table for chart
  sum_table <- df %>%
    select(c("state", starts_with("Unemployed"))) %>%
    group_by(state) %>%
    summarize_all(sum, na.rm = T) %>%
    filter(!state %in% NA) %>%
    select(c("state", "Unemployed_2019")) %>%
    arrange(Unemployed_2019) %>%
    top_n(-5, wt = Unemployed_2019)
  # create piechart
  piechart <- ggplot(sum_table, aes(
    x = "",
    y = Unemployed_2019,
    fill = state
  )) +
    geom_bar(width = 1, stat = "identity", color = "white") +
    coord_polar("y", start = 0) +
    geom_text(aes(label = Unemployed_2019),
      position = position_stack(vjust = 0.5),
      color = "white", size = 3
    ) +
    # changes the theme
    theme_void() +
    ggtitle("5 States with Lowest Number of Unenemployed Individuals (2019)") +
    scale_fill_discrete(name = "State")

  return(piechart)
}
