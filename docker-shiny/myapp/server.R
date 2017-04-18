
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

# Define server logic for random distribution application
shinyServer(function(input, output) {

  output$plot1 <- renderPlot({
    

    f1<-function(n){
      x<- runif(n,0,2)
      q<-2*sqrt(4-x^2)
      thetaF<-mean(q)
      thetaF
    }
    
    
    n <- input$n
    
    qf<-function(x=seq(-2,2,.005)){
      
      sqrt(4-x^2)
      
    }
    qf_neg<-function(x=seq(-2,2,.005)){
      
      -1*sqrt(4-x^2)
      
    }
    cord.x <- c(0,seq(0,2,0.01),2) 
    cord.y <- c(0,qf(seq(0,2,0.01)),0) 
    curve(qf,ylab="f(x)=(1/2)*sqrt(4-x^2)",xlim=c(-4,4),ylim=c(-3,3),main='Aproximando el Area sombreada:
Integral 1')
    curve(qf_neg,add=TRUE)
    polygon(cord.x,cord.y,col='skyblue')
    legend(2.2,2.8,paste("Aprox. del area: ", round(f1(n),5)),xjust=.5,fill="skyblue")
    
    
    #dist <- input$dist
   
    
    #hist(data(), 
     #    main=paste('r', dist, '(', n, ')', sep=''))
  })
  
  output$plot2 <- renderPlot({
    

    f2<-function(n){
      x<- runif(n,0,1)
      q<-4/(1+x^2)
      thetaF<-mean(q)
      thetaF
    }
    
    
    #Para dibujar la curva de la funcin 1 que queremos graficar
    n <- input$n
    
    #Para grfica 2
    hf<-function(x=seq(-5,5,.005)){
      
      4/(1+x^2)
      
    }
    
    cord.x <- c(0,seq(0,1,0.01),1) 
    cord.y <- c(0,hf(seq(0,1,0.01)),0) 
    curve(hf,ylab="f(x)=4/(1+x^2)",xlim=c(-2,3),ylim=c(0,5),main='Aproximando el Area sombreada:
Integral 2')
    #curve(qf_neg,add=TRUE)
    polygon(cord.x,cord.y,col='green4')
    legend(2,4,paste("Aprox. del area: ", round(f2(n),5)),xjust=.5,fill="green4")
    
  })
  
  output$plot3 <- renderPlot({
    
    #introducimos la funcin con la que aproximamos el rea y depende de la "n" (tamao de muestra)
    f3<-function(n){
      x<- runif(n,0,1)
      q<-(6/sqrt(4-x^2))
      thetaF<-mean(q)
      thetaF
    }
    
    
    #Para dibujar la curva de la funcin 1 que queremos graficar
    n <- input$n
    
    #Para grfica 2
    #Para grfica 3
    gf<-function(x=seq(-1.999999,1.999999,.005)){
      
      (6/sqrt(4-x^2))
      
    }
    
    cord.x <- c(-0,seq(0,1,0.01),1) 
    cord.y <- c(0,gf(seq(0,1,0.01)),0)
    curve(gf,ylab="f(x)=6/sqrt(4-x^2)",xlim=c(-2.04,1.95),ylim=c(0,30),main='Aproximando el Area sombreada:
Integral 3')
    #curve(qf_neg,add=TRUE)
    polygon(cord.x,cord.y,col="purple")
    legend(1,25,paste("Aprox. del area: ", round(f3(n),5)),xjust=.5,fill="purple")
    
  })
  
})