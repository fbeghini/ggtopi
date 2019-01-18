# if(!requireNamespace("showtext", quietly = TRUE)){
#   install.packages('showtext', dependencies = TRUE)
#   install.packages("extrafont")
# }
# library(showtext)
# font_add_google("Roboto", "Roboto")
# font_add_google("Montserrat", "Montserrat")

theme_cm <- function(){
  theme_minimal() +
  theme(text = element_text(family = "sans-serif", size = 10, colour = "black"),
        axis.text = element_text(family = "sans-serif", size = 10, colour = "black"),
        strip.background = element_rect(colour = "transparent", fill = "transparent"),
        strip.text = element_text(family = "sans-serif", size = 12, colour = "black"))
}

cm_palette <- c('#e41a1c','#377eb8','#4daf4a','#984ea3','#FF8F33','#FFE133','#6D3100')
