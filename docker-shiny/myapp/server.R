
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(jsonlite)
library(httr)


# Define server logic for random distribution application
shinyServer(function(input, output) {

  tbl_completa00<-reactive({
    
    # path<-"http://backend:8080/todo/api/v1.0/tasks"
    path<-"http://backend:8080/"
    # x<-GET(flask_port(),path=path)
    x<-GET(path)
    fromJSON(x$url)
    
  })
  
  output$tbl_completa<-renderTable({tbl_completa00()})

  renglon_i00<-reactive({
    
    i<-1

    #path<-paste("http://backend:8080/todo/api/v1.0/tasks/",i,sep="")
    path<-paste("http://backend:8080/todo/api/v1.0/tasks/",i,sep="")
    # x<-GET(flask_port(),path=path)
    x<-GET(path)
    fromJSON(x$url)
    
  })
  
  output$renglon_i<-renderTable({renglon_i00()})
  
})
