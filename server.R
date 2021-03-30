#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
# #
# 
demo_text <- "This sentence has five words. Here are five more words. Five-word sentences are fine. But several together become monotonous. Listen to what is happening. The writing is getting boring. The sound of it drones. It's like a stuck record. The ear demands some variety.

    Now listen. I vary the sentence length, and I create music. Music. The writing sings. It has a pleasant rhythm, a lilt, a harmony. I use short sentences. And I use sentences of medium length. And sometimes when I am certain the reader is rested, I will engage him with a sentence of considerable length, a sentence that burns with energy, and builts with all the impetus of a crescendo, the roll of the drums, the crash of the cymbals --- sounds that say listen to this, it is important.

    So write with a combination of short, medium, and long sentences. Create a sound that pleases the reader's ear. Don't just write words. Write music.

    - Gary Provost"

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
        