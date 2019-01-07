if(!requireNamespace("showtext", quietly = TRUE)){
  install.packages('showtext', dependencies = TRUE)
}
library(showtext)
font_add_google("Roboto", "Roboto")
font_add_google("Montserrat", "Montserrat")

theme_cm <- function(){
  theme_minimal() +
  theme(text = element_text(family = "Montserrat", size = 10, colour = "black"),
        axis.text = element_text(family = "Montserrat", size = 10, colour = "black"),
        strip.background = element_rect(colour = "transparent", fill = "transparent"),
        strip.text = element_text(angle = -1, family = "Montserrat", size = 10, colour = "black"))
}
