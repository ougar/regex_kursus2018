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
#
# Søg efter "stringi-search", for at læse mere om de forskellige "engines" (vi kigger kun på Regex)
# og de forskellige search-based operationer, der findes i stringi






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

a <- stri_extract(str = 'aaa', regex = 'a')
assert(a, c('...'))

a <- stri_extract_all('aaa', regex = 'a')
assert(a, c('...'))

a <- stri_extract(str = 'aaa', regex = 'a+')
assert(a, c('...'))

a <- stri_extract_all(str = 'aaa', regex = 'a+')
assert(a, c('...'))






#### OPGAVE 1.3 ####
# Escape sequences. Vi lærte at `\d` og `\w` etc. har speciel betydning i regex.
# Grundlæggende er `\` en escape character, der betyder at det umiddelbart efterfølgende skal forståes på en
# speciel måde. `\d` skal læses som `[0-9]` og `\.` skal læses som et punktum, bogstaveligt og ikke som et wildcard
#
# Desværre er det ikke kun regex der benytter sig af escape sequences. Det gør R også. Når R ser en backslash i en 
# tekststreng forventer den at tegnet umiddelbart efter, escapes. R vil escape alt tekst i din tekststreng inden den
# når stringi's regex engine. Hvis R ikke kan genkende en escape character, vil R melde fejl!

# 1.3.1 Hvordan vil du printe `\d`? 

paste('\d')

# 1.3.2 Find alle tal i følgende tekststreng, ved brug af den korrekte stringi funktion og escapes.

tal <- "123456789"
pattern <- "\d"

str_*_*(str = tal, regex = pattern)







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





#************************************#
#### 3 - Symptomer                ####
#************************************#
#
# Du har modtaget et datasæt over patienter, hvor en af kolonnerne hedder "symptomer". 
# Hver række repræsenterer en patient.
#
# * 3.1 Kan du finde antallet af patienter med feber? 
# * 3.2 Hvad med alle, der har smerte? 
# * 3.3 Alle der har rygsmerter

patient_journal <- get_journal()

assert_symptoms(har_feber, patient_journal)
assert_symptoms(har_smerte, patient_journal)
assert_symptoms(har_har_rygsmerte, patient_journal)
