library(shiny)

ui <- fluidPage(
  "A global variable(seed):",
  textOutput("total", inline = TRUE),
  actionButton("add1", "Add 1"),
  actionButton("add5", "Add 5"),
  numericInput("ni", "seed: ",value = 0)
  ,plotOutput('plot1')
)

server <- function(input, output, session) {
  values <- reactiveValues(total = 0)
  
  observeEvent(input$add1, {
    
    values$total <- values$total + 1
    updateNumericInput(session,
                       inputId = "ni",
                       value = as.numeric(values$total))
    
  })
  observeEvent(input$add5, {
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
 
  output$plot1<-renderPlot(
    {
      set.seed(values$total)
      hist(rnorm(100),main=paste('seed= ',values$total))
    }
  )
  
}

shinyApp(ui = ui, server = server)
