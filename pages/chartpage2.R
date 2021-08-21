library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("shinymaterial")

# Chart Page 2:
# Scatterplot 1
chartpage2 <- material_side_nav_tab_content(
  side_nav_tab_id = "chartpage2",
  h4("Unemployment vs. State Population", align = "center"),
  material_row(
    material_column(
      width = 2,
      material_card(
        title = "",
        depth = 2,
        tags$p("Select the Year You Wish to Examine"),
        material_dropdown(
          input_id = "year",
          label = "Year:",
          choices = c(
            "2010" = "2010",
            "2011" = "2011",
            "2012" = "2012",
            "2013" = "2013",
            "2014" = "2014",
            "2015" = "2015",
            "2016" = "2016",
            "2017" = "2017",
            "2018" = "2018",
            "2019" = "2019"
          ),
          selected = "2019",
          color = "#3f51b5"
        ),
      )
    ),
    material_column(
      width = 8,
      material_card(
        title = "Unemployment Rate vs. Population",
        depth = 2,
        plotlyOutput("scatterplot1")
      ),
      material_card(
        title = "Info",
        depth = 2,
        tags$body(
          p("This chart provides insight on if", strong("state population and
          state unemployment are correlated."), "The dropdown menu allow users
          to explore and compare different years.",
            align = "left"
          ),
        )
      )
    )
  ),
)
