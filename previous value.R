library(shiny)
reactiveConsole(enabled = TRUE)
r <- reactiveValues(count = 0,pr_vlue=NULL, x = 1)
class(r)

observeEvent(r$x, { 
  r$count <- r$count + 1 
  r$pr_vlue[r$count]<-r$x
}) 
r$x<-2
r$count
r$pr_vlue
r$x<-5
r$count
r$pr_vlue
r$x<-r$pr_vlue[r$count-1]








r <- reactiveValues(count = 0, x = 1)
class(r)
#> [1] "rv_flush_on_write" "reactivevalues"
observe({
  r$x
  r$count <- isolate(r$count) + 1
})

r$x <- 1
r$x <- 2
r$count
#> [1] 2

r$x <- 3
r$count
#> [1] 3


