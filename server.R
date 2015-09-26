# load libraries
library(shiny)
library(googleVis)
# calculation fuctions
BMI <- function(weight, height) round(weight / height^2, 2)
BFCh <- function(weight, height, sex, age) {
        if (sex == "Male") s <- 1
        else s <-0
        round(1.51 * (weight / height^2) - 0.70 * age - 3.6 * s + 1.4, 2)
        }
BFA <- function(weight, height, sex, age) {
        if (sex == "Male") s <- 1
        else s <-0
        round(1.2 * (weight / height^2) + 0.23 * age - 10.8 * s - 5.4, 2)
        }
# begin shiny server
shinyServer(function(input, output) {
        output$BMI <- renderPrint({BMI(input$weight, input$height)})
        output$BMIClass <- renderPrint({
                if (is.na(BMI(input$weight, input$height))) "NA"
                else if (BMI(input$weight, input$height) < 18.5) "underweight"
                else if (BMI(input$weight, input$height) < 25) "normal"
                else if (BMI(input$weight, input$height) < 30) "overweight"
                else "obese"
                        })
        output$BF <- renderPrint({
                if (is.na(input$age)) "NA"
                else if (input$age > 15) BFA(input$weight, input$height, input$sex, input$age)
                else BFCh(input$weight, input$height, input$sex, input$age)
                        } )
})