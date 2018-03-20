library(stringi)
library(tidyverse)
source("R_opgaver_datagen.R")


#**************************#
#### Stringi funktioner ####
#**************************#

# `stringi` er en meget kraftig pakke til at søge i, og manipulere tekst strenge i
# R. Vi vil kun kigge på stringi's regex search & replace funktioner.
#
# Alle funktioner i stringi er navngivet efter et sindrigt system, som umiddelbart kan
# se meget forvirrende ud:
#
# `stri_extract_all_regex`
#
# `stri_[operation]_[scope]_[engine]`
#
#
# * Operation: vil du søge, vil du replace, vil du tælle, vil du splitte. Operationen er "det du gør"
#              Eksempler: stri_detect_*, stri_count_*
# * Scope:     Også kaldet mode. Vil du kigge efter det første, sidste eller alle tilfælde, hvor dit regex mønster matcher?
#              Der er en række funktioner hvor det ikke vil give mening at bruge et scope, som foreksempel `str_count`
# * Engine:    Hvordan skal dit mønster forståes. [engine] kan vælges enten via funktion navn, så som `stri_detect_regex`, 
#              eller som et parameter i funktionen, såsom `stri_detect(regex = 'mit mønster')`.
#              Vi vil kun kigge på regex mønstre, og vil som udgangpunkt indikere dette via parametret. Du er velkommen til at 
#              gøre som det passer dig :)


#### 1 - Detect - findes et pattern i en streng? ####
# Afgør om en regex mønster findes i en tekst-streng

# EKSEMPEL
detected <- stri_detect(str = 'aaa', regex = 'a')
assert(detected, TRUE)

# Du kan også bruge `fixed = 'a'` når du søger efter string literals istedet for
# regex mønstrer - stri_detect(str = 'aaa', fixed = 'a')

#### OPGAVE 1.1 ####
# Nu er det din tur til at checke om my_string er et CPR-nummer
my_string <- c("111111-1111", "555-456-159")
detected <- # ...
assert(detected, c(TRUE, FALSE))

#### OPGAVE 1.2 ####
# Hvad antager du at følgende 4 funktioner vil give af resultater?
# skriv dit gæt i `assert()` , før du kører koden.

a <- stri_extract('aaa', regex = 'a')
assert(a, c('...'))

a <- stri_extract_all('aaa', regex = 'a')
assert(a, c('...'))

a <- stri_extract('aaa', regex = 'a+')
assert(a, c('...'))

a <- stri_extract_all('aaa', regex = 'a+')
assert(a, c('...'))

# Søg efter "stringi-search", for at læse mere om de forskellige "engines" (vi kigger kun på Regex)
# og de forskellige search-based operationer, der findes i stringi

#************************************#
#### 2 - Identificér nummerplader ####
#************************************#

# Ligesom til sidste kursus dag, vil vi identificere danske og tyske nummerplader

nummerplader <- get_nummerplader()

# lad os først inspicere vores data_frame
nummerplader %>% head()

# Skriv dine regex patterns her
dk_pattern <- "..."
de_pattern <- "..."

# Vi bruger dplyr's mutate til at anvende vores patterns.
nummerplader <- nummerplader %>% 
  mutate(land = ifelse(stri_detect(regex = dk_pattern),
                       'DK',
                       land),
         land = ifelse(stri_detect(regex = de_pattern),
                       'DE',
                       land)
         )

assert_nummerplader(nummerplader)
