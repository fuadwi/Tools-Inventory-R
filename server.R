#MII Inventory Control Part
#Created By Fuadwi
#Server

library(shiny)
library(shinydashboard)
library(dplyr)
library(lubridate)
library(purrr)
library(tseries)
library(tidyr)
library(MLmetrics)
library(ggplot2)
library(hrbrthemes)
library(forecast)
shinyServer(function(input, output) {

  output$histogram <- renderPlot({
      hist(faithful$eruptions,breaks = input$bins)
  })
  output$msgOutput <- renderMenu({
      msgs <- apply(read.csv("message.csv"),1,function(row){
    messageItem(from = row[["from"]], message = row[["message"]], time = row[["time"]] )  
      })
      dropdownMenu(type = "messages", .list = msgs)
  })
  output$approvedMgr <- renderInfoBox({
      infoBox("Approval Manager", "3231", icon = icon("bar-chart-o"),color = "green")
  })
  output$partRequested <- renderValueBox({
      valueBox(289,"Tooling 8271 Requested", icon = icon("fire"), color = "yellow")
  })
  #upload file
  output$contents <- renderTable({
    inFile <- input$inputData
    if (is.null(inFile))
      return(NULL)
    read.csv(inFile$datapath)
    
  })
  #view data
  output$viewData <- renderTable({
    inFile <- input$inputData
    if (is.null(inFile))
      return(NULL)
    read.csv(inFile$datapath)
})
  
output$tablerecordedData <- renderTable({

  read.csv("recordedData.csv")
  })

  observeEvent(input$btnUpload,{
    inFile <- input$inputData
    if (is.null(inFile))
      return(NULL)
    inDate <- input$inputDate
    txtInput <- input$txtInput
    x <- data.frame(inFile$name,inDate,txtInput)
    write.table(x, file = "recordedData.csv",sep = ",", append = T, quote = F, col.names = F, row.names = F) 

})
})