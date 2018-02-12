library(tidyverse)

two_letters <- function() {
  sample(c(letters, LETTERS), 2, replace = TRUE)
}

seperator <- function(){
  sep <- c(" ", "-",":", " ")
  sample(sep, 1)
}

numbers <- function(n = 1) {
  nmb <- as.character(0:9)
  sample(nmb, n, replace = TRUE)
}

danske <- list(1000)
for (i in 1:1000){
  danske[i] <- paste0(c(two_letters(), seperator(), numbers(2), numbers(3)), collapse = '')
}
tyske <- list(1000)
for (i in 1:1000){
  tyske[i] <-paste0(c(two_letters(), seperator(), two_letters(), seperator(), numbers(2)), collapse = '')
}

paste(sample(c(danske, tyske), 500), collapse = "\n") %>% cat()
