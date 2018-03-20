library(tidyverse)
library(stringi)

assert <- function(x, y) {
  en_x <- rlang::enexpr(x)
  if (isTRUE(all.equal(x,y))) {
    paste("Tillykke! >>", en_x, "<< er", y, "!")
  } else {
    stop("Der er en fejl i opgaven. Prøv igen")
  }
}

get_nummerplader <- function(antal = 2000) {
  source("nummerplade_generator.R")
  nummerplader <- lav_nummerplader(print = FALSE)
  df <- rbind(data_frame(nummerplade = nummerplader$danske, land = 'DK'),
              data_frame(nummerplade = nummerplader$tyske, land = 'DE')
              )
  df <- sample_n(df, nrow(df), replace = FALSE)
  saveRDS(file = "data/nummerplader.RDS", object = df)
  return(df %>% mutate(land = NA))
}

assert_nummerplader <- function(df) {
  target <- readRDS(file = "data/nummerplader.RDS")
  
  if (isTRUE(all.equal(df$land, target$land))) {
    paste("Tillykke! Du har identificeret alle nummerplader korrekt!")
  } else {
    stop("Der er en fejl i opgaven. Prøv igen")    
  }
}

get_journal <- function(){
  source("symptom_generator.R")
  data_frame(id = 1:100, patient_id = id,
             symptomer = make_symptomer(100, FALSE),
             har_feber = NA, har_smerte = NA, har_rygsmerte = NA
             ) %>% 
    rowwise() %>%  mutate(patient_id = paste(c(sample(LETTERS, 2), '-', sample(0:9, 5)), collapse = ''))
    
}

assert_patient(row, )
