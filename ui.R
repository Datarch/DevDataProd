# load shiny package
library(shiny)
# begin shiny UI
shinyUI(navbarPage("Shiny Project",
                   # create first tab for documentation
                   tabPanel("Documentation",
                            # load MathJax library so LaTeX can be used for math equations
                            withMathJax(), h3("Body mass index as a measure of body fatness"), 
                            # paragraph and bold text
                            p(strong("Simulation Experiment"), "using age- and sex-specific prediction formulas*"),
                            p("The ", strong("Body mass index"), "(BMI) can be calculated using this formula:",
                              "$$BMI = \\frac{weihght(kg)}{height^2(m^2)}$$"),
                            p("The ", strong("Body fat percentage "),"(BF) can be predicted by the formula based on ",
                              "the age (children aged 15 years and younger), the sex (males =1, females = 0) and BMI:",
                                "$$BF \\mbox{(child)} = 1.51 * BMI - 0.70 * age - 3.6 * sex + 1.4$$"),
                            p("$$BF \\mbox{(adult)} = 1.20 * BMI - 0.23 * age - 10.8 * sex - 5.4$$",
                              "For children aged 15 years and younger, the relationship differed from that in adults,",
                              " due to the height-related increase in BMI in children"),
                            # break used to space sections
                            br(), p("For this experiment, the following simulation can be used in the ",
                                    strong("Simulation Experiment"), " tab: "), br(),
                            # ordered list
                            tags$ol(
                                    tags$li("Enter the weight in kilogram"),
                                    tags$li("Enter the height in meter"),
                                    tags$li("Enter the age in years"),
                                    tags$li("Select the sex variable, then push the 'Submit' Button"),
                                    tags$li("Calculate and show the BMI index with classification: underweight ",
                                            "(below 18.5); normal (18.5-24.9); overweight (25.0-29.9); obese ",
                                            "(30.0 and above))"),
                                    tags$li("Calculate and show the Body fat percentage")
                            ),
                            br(), p(strong("*Source Article:"), br(), "This simulation experiment is using the model ",
                                    "created and publicated by:", br(), "Paul Deurenberg, Jan A. Weststrate and Jaap ",
                                    "C. Seidell (1991). Body mass index as a measure of body fatness: age- and sex-specific",
                                    " prediction formulas. British Journal of Nutrition, 65, pp 105-114. doi:10.1079/BJN19910073.",
                                    "Link to the abstract: http://dx.doi.org/10.1079/BJN19910073")
                            ),
                   # create second tab for the simulation
                   tabPanel("Simulation Experiment",
                            # input part of the Panel
                                numericInput('weight', 'Weight (kg)', value = NA, min = 10, max = 200, step = 1),
                                numericInput('height', 'height (m)', value = NA, min = 0.5, max = 2.5, step = 0.01),
                                numericInput('age', 'age (years between 7 and 100)', value = NA, min = 7, max = 100, step = 1),
                                radioButtons("sex", "Sex", c("Male" = "Male", "Female" = "Female"), selected = FALSE),
                                submitButton('Submit'),                                                                            
                            # Output part of the Panel,
                                h3('Results of calculation'),
                                h5('The body mass index (BMI):'),
                                verbatimTextOutput("BMI"),
                                h5('The BMI classification (Only relevant for adults):'),                  
                                verbatimTextOutput("BMIClass"),                  
                                h5('The predicted body fat percentage is:'),                  
                                verbatimTextOutput("BF")
                   )
))
