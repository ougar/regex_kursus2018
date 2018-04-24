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

correct_tekst <- "The price of beef rose from $1,000 to $1,100 overnight, while grain fell $10 from $54.8, which caused a 10% loss of market cap of $1,000,000"

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
  df <- data_frame(id = 1:100, patient_id = id,
             symptomer = make_symptomer(100, FALSE),
             har_feber = NA, har_smerte = NA, har_rygsmerte = NA
             ) %>% 
        rowwise() %>%  mutate(patient_id = paste(c(sample(LETTERS, 2), '-', sample(0:9, 5)), collapse = ''))
  
  df_target <- df %>% 
    mutate(har_feber = stri_detect(tolower(symptomer), regex = 'feber'),
           har_smerte = stri_detect(tolower(symptomer), regex = 'smerte'),
           har_rygsmerte = stri_detect(tolower(symptomer), regex = 'ryg[- ]smerte')
          )
  
  assign("patient_target", 
         df_target,
         envir = .GlobalEnv
        )
  df
}


assert_symptoms <- function(row, df){
  row_name <- as.character(rlang::enexpr(row))
  target = get("patient_target", envir = .GlobalEnv)
  
  if (isTRUE(all.equal(df[[row_name]], target[[row_name]]))) {
    paste("Tillykke! Du har identificeret alle", row_name, "korrekt!")
  } else {
    stop("Der er en fejl i opgaven. Prøv igen.")    
  }  
  
}


get_noisy_firma <- function(kr = FALSE) {
  padded_digit <-function(max, w = 2){
    stri_pad(str = sample(max, 1), width = w, pad = '0')
  }

  cpr <- function(){
    paste0(padded_digit(31),padded_digit(12), padded_digit(99), sample(c('', ' ', '-'), 1), padded_digit(9999, 4))
  }
  cvr <- function(){padded_digit(99999999, 8)}
  
  make_id <- function(cpr, cvr){ 
    templates <- c('CPR%1$s CVR%2$s', 'CVR%2$s/CPR%1$s', '%2$s/%1$s', 'CPR%1$s CVR%2$s', 
                   '%1$s/%2$s', '%2$s %1$s', '%1$s/%2$s', 'CPR %1$s', 'CVR:%2$s', '%2$s', '%1$s')  
    sprintf(sample(templates, 1), cpr, cvr)
  }
  
# "[indtægter]([udgifter])/[årstal] | [skat]/[moms]/[fradrag]"
  
  df <- data_frame(ID = 1:1000) %>%
    rowwise() %>%  
    mutate(cvr = cvr(),
           cpr = cpr(),
           kunde_id = make_id(cpr, cvr),
           indtaegt = (sample(9000000, 1)+sample(100, 1)/100),
           udgift = indtaegt / sample(5,1),
           aar = (2018 - sample(100, 1)) %>% as.integer(),
           skat = indtaegt * 0.25,
           moms = udgift * 0.25,
           fradrag = mean(c(moms, skat))
          ) %>% 
    mutate_at(vars(indtaegt, udgift, skat, moms, fradrag),
              . %>% formatC(big.mark = '.', decimal.mark = ',', format = 'f', digits=2)
             ) %>% 
    mutate_at(vars(cvr, cpr), . %>% gsub(pattern = "[^0-9]", replacement = ''))

  # apply dropout
  for (i in 4:10) {
    df[i][sample(1000, 10),] <- ''
  }
  
  df <- df %>% 
    mutate(key_number = sprintf("%1$s(%2$s)/%3$s | %4$s/%5$s/%6$s",
                                indtaegt, udgift, aar, skat, moms, fradrag)
    ) %>% 
    mutate_at(vars(indtaegt, udgift, skat, moms, fradrag, aar),
              . %>% gsub(pattern = '\\.', replacement =  '') %>% 
                gsub(pattern = ',', replacement = '.') %>% as.numeric()
    )

  
  assign("firma_target", df %>% select(-ID, -kunde_id, -key_number), envir = .GlobalEnv)
   
  df %>% select(kunde_id, key_number)
    
}

assert_firma <- function(df){
  target = get("firma_target", envir = .GlobalEnv)
  
  if (isTRUE(all.equal(df, target))) {
    paste("Tillykke! Du har identificeret rettet al data korrekt!")
  } else {
    stop("Der er en fejl i opgaven. Prøv igen.")    
  }  
}