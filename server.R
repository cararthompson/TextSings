
library(shiny)
library(tidyverse)

# Paul Toy's light palette
palette <- c('#EEDD88', # 1-2
             '#FFAABB', # 3-4
             '#EE8866', # 5-6
             '#44BB99', # 7-12
             '#99DDFF', # 13+
             '#77AADD', # Extras
             '#BBCC33', 
             '#AAAA00', 
             '#DDDDDD')

sentence.lengths <- function(x){
    textdf <- corpus::text_split(x, filter = corpus::text_filter(sent_crlf = TRUE)) %>%
        mutate(text = stringr::str_squish(as.character(text)),
               n_words = stringi::stri_count_words(as.character(text)),
               text = case_when(n_words == 0 ~ "<br><br>",
                                TRUE ~ text),
               highlight = case_when(n_words %in% c(1:2) ~ palette[1],
                                  n_words %in% c(3:4) ~ palette[2],
                                  n_words %in% c(5:6) ~ palette[3],
                                  n_words %in% c(7:12) ~ palette[4],
                                  n_words > 12 ~ palette[5],
                                  TRUE ~ "#FFFFFF"),
               out_sentence = paste0("<span style=\"background-color: ", highlight, "\">", text, "</span>"))
    return(textdf)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$singText <- renderUI({
        
        textOut <- sentence.lengths(x = input$text)

        HTML(paste("<strong>", textOut$out_sentence), "</strong>")
    })
    
})
        