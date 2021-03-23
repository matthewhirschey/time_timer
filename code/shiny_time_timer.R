library(shiny)
library(tidyverse)
library(glue)
library(shinyjs)

# Define UI
ui <-  navbarPage(title = "Reprex", 
                  ## RHYME TIME -----
                  tabPanel("Time",
                           useShinyjs(),
                           sidebarLayout(
                             sidebarPanel( 
                               sliderInput("time",
                                           "Seconds",
                                           min = 3,
                                           max = 10,
                                           value = 5
                               ),
                               actionButton(inputId = "go",
                                            label = "Go"), 
                             ),
                             mainPanel(
                               HTML("<center>"),
                               shinyjs::hidden(htmlOutput("simple_timer")),
                               HTML("</center>")
                               
                             )
                           )
                  )
)

# Define server logic
server <- function(input, output, session) {
  #a container to store my time var
  rv <- reactiveValues(
    time = 0
  )
  
  #the event that is triggered by input$go getting clicked
  observeEvent(input$go, {
    rv$time <- input$time #this should update rv$time after go is clicked
    shinyjs::show("simple_timer") #this is the clever package with simple show/hide funs
  })
  
  #the reactive text that generates my HTML
  output$simple_timer <- renderText({
    input$go # make code dependent on the button
    # add `?timestamp=<timestamp>`to the src URL to convince the browser to reload the pic
    glue::glue('<img src ="https://github.com/matthewhirschey/time_timer/raw/main/data/{rv$time}_sec.gif?timestamp={Sys.time()}", 
            align = "center", 
            height="50%", 
            width="50%">')
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
