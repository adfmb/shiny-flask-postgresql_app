library(shiny)

# Define UI for random distribution application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Shiny + Flask + Postgresql"),
  
  mainPanel(tableOutput("tbl_completa"),
              tableOutput("renglon_i"))
   )
)
