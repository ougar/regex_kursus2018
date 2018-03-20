library(tidyverse)

make_symptomer <- function(antal = 100, print = TRUE) {
  
  ryg_symptomer <- c("ryg-smerte", "ryg-smerter", "ryg smerte", "ryg ømhed", "Ryg-ømhed", "Ryg-smerte")
  symptomer <- c("Hoste", "smerter", "Smerter", "Ømhed i brystet", "træthed", "hovedpine", "ørepine", 
                 "Nedsat hørelse", "hæs", "Røde øjne", "søvn problemer", "feber", "Koldsved", "kløe", 
                 "mave-smerte", "fod-smerter")
  
  l <- c()
  for (i in 1:antal) {
    r <- sample(4, 1)
    l[i] <- paste(sample(
      c(sample(ryg_symptomer, 1), sample(symptomer, r))
    ), collapse = ", ")
  }
  if (print){
    paste(l, collapse = "\n") %>% cat()
    return()
  } else {
    return(l)
  }
}