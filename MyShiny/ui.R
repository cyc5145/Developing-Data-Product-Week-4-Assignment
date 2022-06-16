#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(fluidPage(

    # Application title
    titlePanel("Predict Stopping Distances from Car Speed"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderSpeed", "What is the speed of the car (mph)?", 4, 40, value = 10),
            checkboxInput("showModel1", "Show/Hide Model1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model2", value = TRUE)
        ),
        mainPanel(
            plotOutput("plot1"),
            h3("Predict Stopping Distance from Model 1:"),
            textOutput("pred1"),
            h3("Predict Stopping Distance from Model 2:"),
            textOutput("pred2")
        )
    )
))

