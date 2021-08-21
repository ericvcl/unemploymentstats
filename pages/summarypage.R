library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("shinymaterial")

# Summary Page
summarypage <- material_side_nav_tab_content(
  side_nav_tab_id = "summarypage",
  h4("Summary", align = "center"),
  material_row(
    material_card(
      h5("Summary Table", align = "left"),
      tableOutput("table"),
      tags$br(),
      h5("Takeaways"),
      tags$body(
        p("The summary table provides insight on the average ",
          strong("unemployment rates, median household income, and population"),
          "of all states in the last decade. This table along with the three
          charts provided are the basis of the following takeaways.",
          align = "left"
        ),
        h6("Takeaway 1:"),
        p("The difference between the two states with the highest and lowest
          unemployment rates in the last 10 years is massive. ",
          strong("Alaska"), "had an average unemployment rate of ",
          strong("9.66,"), " almost 3 times that of ", strong("Nebraska"), "
          which had an average unemployment rate of ", strong("3.35."),
          "This shows that certain states may need much higher levels of
          intervention in order to improve their unemployment levels.",
          align = "left"
        ),
        h6("Takeaway 2:"),
        p("During the past 10 years, there has been a slight correlation
          between states with", strong("higher median household incomes"),
          "having", strong("lower levels of unemployment."),
          "This is difficult to see from the summary table due to the
          correlation being small. The", strong("third chart"), "provided
          better visualizes this connection. This correlation suggests that
          intervention aimed at improving unemployment rates nationwide should
          put a slightly larger focus on states with low median household
          incomes.",
          align = "left"
        ),
        h6("Takeaway 3:"),
        p("In the last decade, states on the west coast have had significantly
          higher levels of unemployment than those on the east coast. For
          example, ", strong("California and Washington"), "had average
          unemployment levels of ", strong("8.94 and 7.74,"), "respectively.
          Whereas ", strong("New York and Virginia "), "had rates of",
          strong("6.3 and 5.66."),
          "This indicates that different approaches might need to be taken in
          order to improve unemploment rates on the coasts.",
          align = "left"
        ),
        tags$br(),
        depth = 2,
      )
    )
  ),
)
