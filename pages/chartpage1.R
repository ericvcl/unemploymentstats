library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("shinymaterial")

# Chart Page 1:
# Map
chartpage1 <- material_side_nav_tab_content(
  side_nav_tab_id = "chartpage1",
  h4("State Unemployment Statistics", align = "center"),
  material_row(
    material_column(
      width = 10,
      offset = 1,
      material_row(
        material_column(
          width = 6,
          material_slider(
            input_id = "from_year",
            label = "From Year",
            min_value = 2010,
            max_value = 2019,
            initial_value = 2010,
            color = "#3f51b5"
          )
        ),
        material_column(
          width = 6,
          material_slider(
            input_id = "to_year",
            label = "Through Year",
            min_value = 2010,
            max_value = 2019,
            initial_value = 2019,
            color = "#3f51b5"
          )
        )
      ),
      material_row(
        material_column(
          width = 12,
          material_card(
            title = "United States",
            plotlyOutput("map"),
            depth = 2,
          )
        )
      ),
      material_row(
        material_column(
          width = 12,
          material_card(
            title = "Info",
            depth = 2,
            tags$body(
              p("This chart provides insight on how unemployment has
                affected the United States from a",
                strong("geographical perspective"),
                "in the last decade.", "The sliders allow users to view
                different year ranges and compare their average rates of
                unemployment.",
                align = "left"
              ),
            )
          )
        )
      ),
    )
  )
)
