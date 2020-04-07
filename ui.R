#MII Inventory Control Part
#Created By Fuadwi
#UI

library(shiny)
library(shinydashboard)
library(ggplot2)
library(forecast)
library(shinyjs)
shinyUI(dashboardPage( title = "MII Inventory Control",skin = "green",

   dashboardHeader(title = "MII Inventory Control",dropdownMenuOutput("msgOutput"),
                # dropdownMenu(type = "message",
                #              messageItem(from = "Tooling Part Is Run out", message ="Your Smart Companion" , icon = icon("infinity"), time =("today") )
                #              
                #              ) 
                dropdownMenu(type = "notifications",
                             notificationItem(
                                 text = "tooling item 732973Z is about to empty",
                                 icon = icon("warning"),
                                 status = "warning"
                             ),
                             notificationItem(
                                 text = "Machine SD1Y is running Effectively at Past 2 weeks",
                                 icon = icon("dashboard"),
                                 status = "success"
                             )
                             ),
                dropdownMenu(type = "task",
                             taskItem(
                                 value = 90,
                                 color = "aqua",
                                 "Tooling Item #1"
                             ),
                             taskItem(
                                 value = 80,
                                 color = "green",
                                 "Tooling Item #2"
                             ),
                             taskItem(
                                 value = 20,
                                 color = "red",
                                 "Tooling Item #3"
                             )
                             )
                ),
   dashboardSidebar(
       sidebarSearchForm("searchText","buttonSearch","Search"),
     
       sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon=icon("dashboard")),
            menuSubItem("Data Maintenance",tabName = "maintenance", icon=icon("wrench")),
            menuSubItem("Data Tooling", tabName = "tooling", icon = icon("coffee")),
        menuItem("Detailed Analysis", tabName = "detail",badgeLabel = "new",badgeColor = "green", icon = icon("glasses")),
        menuItem("Raw Data", tabName = "rawData", icon = icon("list"))
      
        
   )),
   dashboardBody(
       tabItems(
           tabItem(tabName = "dashboard",
                  #untuk info box
                    fluidRow(
                        column(width = 10,
                       infoBox("Tooling",1000,icon = icon("thumbs-up"),color = "green"),
                       infoBox("Conversion %", paste0('20%'),icon = icon("warning"),color = "green"),
                       infoBoxOutput("approvedMgr")
                        )
                   ),
                   # untuk value box
                    fluidRow(
                        valueBox(2801,"Tooling 817ZGJ remaining Qty", icon = icon("hourglass-3"),color = "red"),
                        valueBoxOutput("partRequested")
                    ),
                   fluidRow(
                       box(title = "Data", status = "primary", solidHeader = T, plotOutput("histogram")),
                       box(title = "Control", status = "warning", solidHeader = T,
                           "wawawawawawaaw",br(),"dsdjsdhsjd",
                           sliderInput("bins", "Number of Break",1,100,50),
                           textInput("text_input","Search Opportunities", value = "127817"))
                       )),
           
           tabItem(tabName = "maintenance",
                   h1("Maintenance Dashboard")),
           tabItem(tabName = "tooling",
                   h2("Tooling Dashboard")),
           tabItem(tabName = "rawData",
                  # h1("Data"),
                   fluidRow(
                      box(title = "Upload the Data", status = "primary", solidHeader = T, width = 4, height = NULL,
                          fileInput("inputData", "Upload Your Data", buttonLabel = " Browse File ",accept = c(
                             "text/csv","text/comma-separated-values","text/plain",".csv",
                             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet","application/vnd.ms-excel"),
                             width = "500px"),
                          dateInput("inputDate","Input Date", format = "yyyy-mm-dd", language = "en" ),
                          textInput("txtInput", "Remark", value = "", placeholder = "masukkan keterangan jika dibutuhkan"),
                          actionButton("btnUpload", "Save", icon = icon("save"), width = '120px')
                          
                         
                          ),
                      box(title = "View Data", status = "success", solidHeader = T, width = 5, collapsible = T,
                          tableOutput("viewData")),
                      box(title = "Uploaded File", status = "primary", solidHeader = T, width = 3, collapsible = T,
                          tableOutput("tablerecordedData"))
                      )
           
           ))
       )
   
))
