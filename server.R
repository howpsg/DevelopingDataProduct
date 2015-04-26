library(shiny)
library (stringr)
library (ggplot2)
library (forecast)

# set the working directory
setwd("C:/....")

# read/load the USD SGD exchange rate data. 
exchange <-  read.csv("USDSGD_STIIND.csv")
exchange$year <- str_sub(exchange$Date,1, 4)


# Server implementation
shinyServer(
  function(input, output) {
    
    # Generate a summary of the dataset
    output$summary <- renderPrint({
      summary(exchange)
    })
    
    # Generate a Time series plot
    output$tsPlot <- renderPlot({
      timeserias <- ts(exchange,start=c(2009), end =c(2012), frequency=365)
      plot (timeserias)
    })

    # Generate a Fitting Generalizaed Linear Models, 
    # where predictor is STI index and taraget outcome is USDSGD exchange rate.
    output$sumfit <- renderPrint({
      fit <- lm(exchange$USDSGD1~exchange$STI.ind)
      res <- residuals(fit)
      summary(fit)
    })    
    
    # Generate plot that shwo by each year 
    output$typePlot <- reactivePlot(function() {
      
      if (input$variable == "STIIND") {
      # show plot with y = STI Index
      
        type <- 
          ggplot (exchange, aes(x=USDSGD1, y = STI.ind,colour=year)) + geom_point (shape="$", size=3) + geom_smooth (method="lm")
      }
      else {
      
          type <- 
            ggplot (exchange, aes(x=STI.ind, y = USDSGD1,colour=year)) + geom_point (shape="$", size=3) + geom_smooth (method="lm")
      }
      
      print(type)
    })
       
    # Generate a plot to show the 4 years data
    output$type1Plot <- reactivePlot(function() {
      
      if (input$variable == "STIIND") {
        # show plot with y = STI Index
        
        type1 <- 
          ggplot (exchange, aes(x= USDSGD1, y = STI.ind)) + geom_point (shape="$", size=3) + geom_smooth (method="lm")
      }
      else {
        
        type1 <- 
          ggplot (exchange, aes(x= STI.ind, y = USDSGD1)) + geom_point (shape="$", size=3) + geom_smooth (method="lm")
      }
      
      print(type1)
    })
    

        
    
  }
)

