library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("shinymaterial")

# source files
source("app_ui.R")
source("app_server.R")

# create shinyApp
shinyApp(ui = ui, server = server)
