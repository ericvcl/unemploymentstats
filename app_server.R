library("dplyr")
library("ggplot2")
library("plotly")
library("shinymaterial")
library("shiny")

# source all script files from shinyscripts dir
file.sources <- list.files("./scripts/shinyscripts",
  pattern = "*.R$", full.names = TRUE,
  ignore.case = TRUE
)
sapply(file.sources, source, .GlobalEnv)

# load data to use in plot functions
unemployment_df <- read.csv("./data/Unemployment.csv", stringsAsFactors = FALSE)
median_income_df <- read.csv("./data/cleaned median income.csv",
  stringsAsFactors = FALSE
)
us_population_df <- read.csv("./data/uspopulation.csv",
  stringsAsFactors = FALSE
)

# server functions
server <- function(input, output) {
  # output map plot
  output$map <- renderPlotly({
    return(create_map(unemployment_df, input$from_year, input$to_year))
  })
  # output scatter plot for chart page 2
  output$scatterplot1 <- renderPlotly({
    return(create_scatter_plot1(unemployment_df, us_population_df, input$year))
  })
  # output scatter plot for chart page 3
  output$scatterplot2 <- renderPlotly({
    return(create_scatter_plot(
      unemployment_df, median_income_df,
      input$year_2
    ))
  })
  # output summary table
  output$table <- renderTable({
    return(create_table(unemployment_df, median_income_df, us_population_df))
  })
}
