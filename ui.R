library(shiny)

# Analysis of exchange rates: USD - SGD 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Is STI index influences the exchange rates for USD - SGD?"),
  
  # Sidebar with controls to input the type of plot
  sidebarPanel(
    selectInput("variable", "Choose the plot to explore the exchange rate of USD and SGD:",
                list("y=STI Index, x=USD-SGD" = "STIIND", 
                     "y=USD-SGD, x=STI Index" = "USDSGD" )),
    
    submitButton("Go!"),
    
    hr(),
    helpText("Note: This is not a real exchange rate dataset.")
    
    
  ),
  
  # Show the caption and plot of the requested year
  mainPanel(
    
    plotOutput("typePlot"),
    
    plotOutput("type1Plot"),

    plotOutput("tsPlot"),
    
    h4("Summary"),
    verbatimTextOutput("summary"),
    
    h4("Fitting Generalizaed Linear Models"),
    verbatimTextOutput("sumfit")
    
  )
))
