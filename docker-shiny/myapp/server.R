
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(jsonlite)
library(httr)

flask_port<-function(){
  
  #"http://127.0.0.1:5000/"
  # "http://172.19.0.3/16/"
  # "http://172.19.0.2/16/"
  # "http://172.19.0.2/16:5000"
  # "http://172.19.0.2:5000/"
  # "http://172.19.0.2/16:8080/"
  "tcp://34.208.60.59:8080/"
  
}



# Define server logic for random distribution application
shinyServer(function(input, output) {

  tbl_completa00<-reactive({
    
    path<-paste("todo/api/v1.0/tasks",sep="")
    x<-GET(flask_port(),path=path)
    
    fromJSON(x$url)
    
  })
  
  output$tbl_completa<-renderTable({tbl_completa00()})

  renglon_i00<-reactive({
    
    i<-1
    path<-paste("todo/api/v1.0/tasks/",i,sep="")
    x<-GET(flask_port(),path=path)
    fromJSON(x$url)
    
  })
  
  output$renglon_i<-renderTable({renglon_i00()})
  
})