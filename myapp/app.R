rm(list=ls())

library(ggplot2)
library(shiny)
library(rstudioapi)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

trade = read.csv("./trade.csv")

# Define UI ----
ui <- fluidPage(
  titlePanel("China Tilt Data Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("country", "Country", choices = unique(trade$ISO)),
      selectInput("variable", "Variable", 
                  choices = c("Exports to China", "Imports from China", "Exports to USA", "Imports from USA"))
    ),
    
    mainPanel(
      plotOutput("plot", click = "plot_click")
    )
))

# Define server logic ----
server <- function(input, output) {
  output$plot = renderPlot({
    
    if (input$variable=="Exports to China") {
      ggplot(trade[which(trade$ISO==input$country),]) + 
        geom_line(aes(x=Year, y=exports_chn_prop, color=ISO)) + 
        ylab(input$variable) + 
        theme_minimal()
    } else if (input$variable=="Imports from China") {
      ggplot(trade[which(trade$ISO==input$country),]) + 
        geom_line(aes(x=Year, y=imports_chn_prop, color=ISO)) + 
        ylab(input$variable) + 
        theme_minimal()
    } else if (input$variable=="Exports to USA") {
      ggplot(trade[which(trade$ISO==input$country),]) + 
        geom_line(aes(x=Year, y=exports_usa_prop, color=ISO)) + 
        ylab(input$variable) + 
        theme_minimal()
    } else if (input$variable=="Imports from USA") {
      ggplot(trade[which(trade$ISO==input$country),]) + 
        geom_line(aes(x=Year, y=imports_usa_prop, color=ISO)) + 
        ylab(input$variable) + 
        theme_minimal()
    }
    

  })
}

# Run the app ----
shinyApp(ui = ui, server = server)
