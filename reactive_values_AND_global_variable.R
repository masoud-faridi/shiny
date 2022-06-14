library(shiny)
global_var2 <<- 0
global_var2_plus = function(r){
  global_var2 <<- global_var2+r
}
ui <- fluidPage(
  "A global variable(seed):",
  textOutput("total", inline = TRUE),
  "global_var2=",
  textOutput("total2", inline = TRUE),
  actionButton("add1", "Add 1"),
  actionButton("add5", "Add 5"),
  numericInput("ni", "seed: ",value = 0,min=0)
  
  ,plotOutput('plot1')
)

server <- function(input, output, session) {
  
  values <- reactiveValues(total = 0)
  
  observe({
    makeReactiveBinding("global_var2")
  })
  
  observeEvent(input$add1, {
    global_var2_plus(1)
    values$total <- values$total + 1
    updateNumericInput(session,
                       inputId = "ni",
                       value = as.numeric(values$total))
    
  })
  observeEvent(input$add5, {
    global_var2_plus(5)
    values$total <- values$total + 5
    updateNumericInput(session,
                       inputId = "ni",
                       value = as.numeric(values$total))
  })
  observeEvent(input$ni, {
    values$total <- input$ni
  })
  output$total <- renderText({
    values$total
  })
  output$total2 <- renderText({
    global_var2
  })
  
  output$plot1<-renderPlot(
    {
      set.seed(values$total)
      hist(rnorm(100),main=paste('seed= ',values$total),xlab=paste("global_var2=",global_var2))
    }
  )
  
}

shinyApp(ui = ui, server = server)