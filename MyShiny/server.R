
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    cars$speedsp <- ifelse(cars$speed - 15 > 0, cars$speed - 15, 0)
    model1 <- lm(dist ~ speed, data = cars)
    model2 <- lm(dist ~ speedsp + speed, data = cars)
    
    model1pred <- reactive({
        speedInput <- input$sliderSpeed
        predict(model1, newdata = data.frame(speed = speedInput))
    })
    
    model2pred <- reactive({
        speedInput <- input$sliderSpeed
        predict(model2, newdata = 
                    data.frame(speed = speedInput,
                               speedsp = ifelse(speedInput - 15 > 0,
                                                speedInput - 15 , 0)))
    })
    
    output$plot1 <- renderPlot({
        speedInput <- input$sliderSpeed
        
        plot(cars$speed, cars$dist, xlab = "Car Speed",
             ylab = "Stop distance", bty = "n", pch = 16,
             xlim = c(4,40), ylim = c(2,150))
        if(input$showModel1){
            abline(model1, col = "red", lwd = 2)
        }
        if(input$showModel2){
            model2lines <- predict(model2, newdata = data.frame(
                speed = 4:40, speedsp = ifelse(4:40 - 15 > 0, 4:40 - 15, 0)
            ))
            lines(4:40, model2lines, col = "blue", lwd = 2)
        }
        legend(5,120, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
               col = c("red", "blue"), bty = "n", cex = 1.2)
        points(speedInput, model1pred(), col = "red", pch = 16, cex = 2)
        points(speedInput, model2pred(), cold = "blue", pch = 16, cex = 2)
    })
    
    output$pred1 <- renderText({
        model1pred()
    })
    output$pred2 <- renderText({
        model2pred()
    })
})

    