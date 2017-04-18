
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

# Define UI for random distribution application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Aproximaciones de integrales"),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the
  # br() element to introduce extra vertical spacing
  sidebarLayout(
    sidebarPanel(
#      radioButtons("dist", "Distribution type:",
 #                  c("Normal" = "norm",
  #                   "Log-normal" = "lnorm",
   #                  "Uniform" = "unif",
    #                 "Exponential" = "exp")),
     # br(),
      
      sliderInput("n", 
                  "numero de elementos en la muestra:", 
                  value = 500,
                  min = 1, 
                  max = 10000000)
    ),
    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Integral 1", plotOutput("plot1")),
                  tabPanel("Integral 2", plotOutput("plot2")),
                  tabPanel("Integral 3", plotOutput("plot3"))
      )
    )
  )
))