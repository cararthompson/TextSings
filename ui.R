
library(shiny)
library(shinythemes)


shinyUI(fluidPage(
    
    theme = shinytheme("yeti"),

    titlePanel("Don't just write words. Write music."),

    fluidRow(
        
        column(h3("First, some writing advice from Gary Provost"),
               img(src='provost.jpg', align = "centre", style="width: 80%, height = auto"),
               width = 4,
               h3("Find out more"),
               p(tags$ul(
                   tags$li("The highlight colours are from", tags$a(href = "https://personal.sron.nl/~pault/#sec:qualitative",
                                                                    "Paul Tol's Light palette."), 
                           "Follow the link to read more about colour palettes optimized for accessible dataviz."),
                   tags$li("If you found this app useful, please share it with others!"),
                   tags$li("Here's where to ", tags$a(href = "https://github.com/cararthompson/TextSings/", "view the code behind the app"), 
                           "and", tags$a(href = "https://github.com/cararthompson/TextSings/issues", "file bug reports and feature requests.")),
                   tags$li("Any other queries, just ", tags$a(href = "https://twitter.com/cararthompson", "get in touch!"))))),
        
        column(h3("Your text"),
               h3(" "),
               textAreaInput(
                             inputId = "text",
                             label = "Please type or copy your text into this box. Any subsequent edits you make will be 
                             reflected in the output.",
                             value = "",
                             width = "100%",
                             height = '500px',
                             cols = NULL,
                             rows = NULL,
                             placeholder = NULL,
                             resize = "vertical"
                         ),
                     width = 3
        ),
        column(width = 1),

        column(
            h3("Does the writing sing?"),
            h3(" "),
            
                htmlOutput("singText"),
            width = 3
            
        )
    )
))
