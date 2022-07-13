library(shiny)
library(dplyr)
options(shiny.trace = FALSE)
options(shiny.error = browser)
ui <- fluidPage(textOutput('sum1'),
                textOutput('sum2'))
server <- function(input, output, session) {
  data1 <- reactivePoll(1000, session,
                        function()
                       file.mtime("data.csv")
                       #file.size("data.csv"))
                       ,
                        function()
                          read.csv("data.csv"))
  
  data2 <- reactiveFileReader(1000, session, "data.csv", read.csv)
  output$sum1 <- renderText({
    #message("the data readed")
    #sum(data1())
    cat("the data has been readed by sum1 ID")
    sum(data1())
    
  })
  output$sum2 <- renderText({
    #message("the data readed")
    #sum(data2())
  })
}
shinyApp(ui, server)
