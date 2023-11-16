library(shiny)
library(vip)

random_number <- sample(1:380, 1, replace = T)
random_game <- soccer[random_number,]

oob_predictions <- data.frame(soccer_forest %>% 
                                extract_fit_engine() %>% 
                                pluck("predictions"))

model_prediction <- oob_predictions[random_number, ]

importance_plot <- soccer_forest %>% 
  vip(geom = "point", num_features = 15) +
  labs(title = "Variable Importance in the Forest")


# Define UI for application that draws a histogram
ui <- fluidPage(

  sidebarLayout(
    sidebarPanel(

    titlePanel("Statistics"),

    h1("Home Team"),
    
    #p("Halftime goals: ", textOutput("HomeHalfGoals")),

    p("Halftime goals: ", random_game$half_home_goals),
    p("Shots: ", random_game$home_shots),
    p("Shots on target: ", random_game$home_shots_on_target),
    p("Fouls: ", random_game$home_fouls),
    p("Corners: ", random_game$home_corners),
    p("Yellow Cards: ", random_game$home_yellows),
    p("Red Cards: ", random_game$home_reds),

    h2("Away Team"),

    p("Halftime goals: ", random_game$half_away_goals),
    p("Shots: ", random_game$away_shots),
    p("Shots on target: ", random_game$away_shots_on_target),
    p("Fouls: ", random_game$away_fouls),
    p("Corners: ", random_game$away_corners),
    p("Yellow Cards: ", random_game$away_yellows),
    p("Red Cards: ", random_game$away_reds),
    
),
mainPanel(
  plotOutput("plot"),
  
  titlePanel("Who do you think won this soccer game?"),

  actionButton("homeAction", label = "Home team"),
  hr(),

  actionButton("awayAction", label = "Away team"),
  hr(),

  actionButton("drawAction", label = "It was a draw"),
  hr(),

  h1(textOutput("ChoiceButton")),
  h1(textOutput("ActualResult1")),
  h1(textOutput("ActualResult2")),
  h1(textOutput("ModelResult1")),
  h1(textOutput("ModelResult2"))

)
)
)


server <- function(input, output) {
  
  output$plot <- renderPlot({
    importance_plot
  })
  
  observeEvent(input$homeAction,
               {
                 output$ChoiceButton <- renderText({
                   "You chose the home team to win"
                 })
                 output$ActualResult1 <- renderText({
                   print("The actual result was: ")
                 })
                 output$ActualResult2 <- renderPrint({
                   as.character(random_game$full_result_1)
                 })
                 output$ModelResult1 <- renderText({
                   print("The model predicted: ")
                 })
                 output$ModelResult2 <- renderPrint({
                   as.character(model_prediction)
                 })
               }
  )

  observeEvent(input$awayAction,
               {
                 output$ChoiceButton <- renderText({
                   print("You chose the away team to win")
                 })
                 output$ActualResult1 <- renderText({
                   print("The actual result was: ")
                 })
                 output$ActualResult2 <- renderPrint({
                   as.character(random_game$full_result_1)
                 })
                 output$ModelResult1 <- renderText({
                   print("The model predicted: ")
                 })
                 output$ModelResult2 <- renderPrint({
                   as.character(model_prediction)
                 })
               }
  )

  observeEvent(input$drawAction,
               {
                 output$ChoiceButton <- renderText({
                   print("You chose the teams to draw")
                 })
                 output$ActualResult1 <- renderText({
                   print("The actual result was: ")
                 })
                 output$ActualResult2 <- renderPrint({
                   as.character(random_game$full_result_1)
                 })
                 output$ModelResult1 <- renderText({
                   print("The model predicted: ")
                 })
                 output$ModelResult2 <- renderPrint({
                   as.character(model_prediction)
                 })
               }
  )
  
  
}


# Run the application
shinyApp(ui = ui, server = server)
