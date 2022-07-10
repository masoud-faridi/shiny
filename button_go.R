library(shiny)

ui <- fluidPage(
  numericInput(
    "x",
    "x",
    value = 50,
    min = 0,
    max = 100
  ),
  actionButton("capture", "capture"),
  textOutput("out"),
  actionButton("capture2", "capture2"),
  textOutput("out2")
  
)

server <- function(input, output, session) {
  text_out2 <- reactiveValues(x = isolate(input$x))
  text_out <- eventReactive(input$capture, {
    input$x
  })
  observeEvent(input$capture2, {
    text_out2$x <- input$x
  })
  output$out <- renderText({
    text_out()
  })
  output$out2 <- renderText({
    text_out2$x
  })
}

shinyApp(ui, server)