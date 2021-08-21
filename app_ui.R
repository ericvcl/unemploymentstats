library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("shinymaterial")

# source page files from "pages" dir
file.sources <- list.files("./pages",
  pattern = "*.R$", full.names = TRUE,
  ignore.case = TRUE
)
sapply(file.sources, source, .GlobalEnv)

# Create ui
ui <- material_page(
  title = "US Unemployment Statistics",
  nav_bar_color = "indigo",
  # Place side-nav in the beginning of the UI
  material_side_nav(
    fixed = T,
    image_source = "img/nav.jpg",
    # Place side-nav tabs within side-nav
    material_side_nav_tabs(
      # name side nav pages
      side_nav_tabs = c(
        "Overview" = "overviewpage",
        "State Unemployment Stats" = "chartpage1",
        "Unemployment v.s. Pop." = "chartpage2",
        "Unemployment v.s. Inc." = "chartpage3",
        "Summary" = "summarypage"
      ),
      # select icons for tabs
      icons = c(
        "explore",
        "insert_chart",
        "insert_chart",
        "insert_chart",
        "assignment"
      )
    )
  ),
  # Define side-nav tab content
  overviewpage,
  chartpage1,
  chartpage2,
  chartpage3,
  summarypage
)
