theme_cm <- function(){
  theme_minimal() +
  theme(strip.background = element_rect(colour = "transparent", fill = "transparent"),
        axis.text = element_text(color = "black", size = 10),
        strip.text.y = element_text(angle = 0, size = 10)) +
  scale_fill_brewer(name = "Timepoint", palette="Dark2")
}
