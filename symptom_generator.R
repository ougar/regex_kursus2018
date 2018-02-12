library(tidyverse)
ryg_symptomer <- c("ryg-smerte", "ryg-smerter", "ryg smerte", "ryg ømhed", "Ryg-ømhed", "Ryg-smerte")
symptomer <- c("Hoste", "smerter", "Smerter", "Ømhed i brystet", "træthed", "hovedpine", "ørepine", 
               "Nedsat hørelse", "hæs", "Røde øjne", "søvn problemer", "feber", "Koldsved", "kløe", 
               "mave-smerte", "fod-smerter")

c <- list()
for (i in 1:100) {
  r <- sample(4, 1)
  c[i] <- paste(sample(
    c(sample(ryg_symptomer, 1), sample(symptomer, r))
  ), collapse = ", ")
}

paste(c, collapse = "\n") %>% cat()
