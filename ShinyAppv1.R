library(shiny)

x = 2

# Define UI for application that draws a histogram
ui <- fluidPage(
  
 
  
  sidebarLayout(
    sidebarPanel(
      
    titlePanel("Statistics"),
    
    h1("Home Team"),
    
    p("Halftime goals: "),
    p("Shots: "), 
    p("Shots on target: "),
    p("Fouls: "),
    p("Corners: "),
    p("Yellow: "),
    p("Reds: "),
    
    h2("Away Team"),
    
    p("Halftime goals: "),
    p("Shots: "), 
    p("Shots on target: "),
    p("Fouls: "),
    p("Corners: "),
    p("Yellow Cards: "),
    p("Red Cards: "),
    
),
mainPanel(
  titlePanel("Who do you think would win this soccer game?"),
  
  actionButton("homeAction", label = "Home"),
  hr(),

  actionButton("awayAction", label = "Away"),
  hr(),

  actionButton("drawAction", label = "Draw"),
  hr(),

  h1(textOutput("ChoiceButton")),
  h1(textOutput("ModelChoice"))
  
)
)
)


server <- function(input, output) {

  observeEvent(input$homeAction,
               {
                 output$ChoiceButton <- renderText({
                   print("You chose the home team to win")
                 })
                 output$ModelChoice <- renderText({
                   print("Our model chose: ")
                 })
               }
  )
               
  observeEvent(input$awayAction,
               {
                 output$ChoiceButton <- renderText({
                   print("You chose the away team to win")
                 })
                 output$ModelChoice <- renderText({
                   print("Our model chose: ")
                 })
               }
  )
  
  observeEvent(input$drawAction,
               {
                 output$ChoiceButton <- renderText({
                   print("You chose the teams to draw")
                 })
                 output$ModelChoice <- renderText({
                   print("Our model chose: ")
                 })
               }
  )
  
}
  

# Run the application 
shinyApp(ui = ui, server = server)
