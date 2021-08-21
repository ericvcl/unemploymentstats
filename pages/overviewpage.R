library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("shinymaterial")
library("lintr")

overviewpage <- material_side_nav_tab_content(
  side_nav_tab_id = "overviewpage",
  h4("Overview", align = "center"),
  # tags$br(),
  material_row(
    material_card(
      h5("Our Process", align = "left"),
      tags$body(
        p("The unemployment rates of the United States have a direct impact on
          our lives as students and as future participants in the American
          Economy. Given the opportunity to use data to answer critical
          questions, our team set out to answer the follow questions:
           "),
        align = "left", br()
      ),
      p(
        strong("1."),
        "How has unemployment has affected the United States from a
        geographical perspective in the last decade?", br(),
        strong("2."),
        "Is there a correlation between unemployment in states and their
        population?", br(),
        strong("3."),
        "Is there a correlation between unemployment in states and their
        median household income?"
      ),
      h5("The Data", align = "left"),
      tags$a(
        href = "https://www.census.gov/data/tables/time-series/
        demo/income-poverty/historical-income-households.html",
        "Median Household Income by State"
      ),
      tags$br(),
      tags$a(
        href = "https://www.census.gov/data/tables/time-series/demo
        /popest/2010s-state-total.html",
        "US State Population Totals 2010 - 2019"
      ),
      tags$br(),
      tags$a(
        href = "https://www.ers.usda.gov/webdocs/DataFiles/48747/
        Unemployment.csv?v=4199.9",
        "US Unemployment Rates 2000 - 2019"
      ),
      tags$br(), tags$br(),
      p("Our team collected data from the United States Census Bureau and
      Department of Agriculture's economic reserch services. We chose this
        data due to the United States government being a reliable source."),
      h5("Visualizations", align = "left"),
      p("For this project, our team designed 3 interactive charts to help
        answer our data-driven questions. These include a map for answering the
        geographical question and two scatterplots for the questions regarding
         population and median income."),
      tags$br(),
      img(src = "./img/unemployment.png", ),
      tags$br(),
      depth = 2,
    )
  )
)
