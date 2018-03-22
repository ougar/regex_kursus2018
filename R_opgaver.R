library(stringi)
library(tidyverse)
source("R_opgaver_datagen.R")

#**************************#
#### Introduktion ...   ####
#**************************#
#
# Ser du 3 prikker, så skal du kode!
#
# Alle opgaver er sat op til at du/skal færdiggøre
# noget kode, der hvor der er 3 prikker `...`
#
# Som opgaverne skrider frem, skal du kode mere og mere, og det er ikke kun 
# regex du skal lave, men også manipulation af data_frames, gerne ved brug ad dplyr





#**************************#
#### Stringi funktioner ####
#**************************#

# `stringi` er en meget kraftfuld pakke til at søge, og manipulere tekst strenge i
# R. Vi vil kun kigge på stringi's regex search & replace funktioner.
#
# Alle funktioner i stringi er navngivet efter et sindrigt system, som umiddelbart kan
# se meget forvirrende ud:
#
# fx kan en stringi funktion se sådan ud: `stri_extract_all_regex`
# Denne funktion består af følgende 4 elementer: 
#
# `stri_[operation]_[scope]_[engine]`
#
#
# * stri:      basenavn, der viser at du har med en stringi funktion at gøre.
#
# * Operation: vil du søge, vil du replace, vil du tælle, vil du splitte? Operationen er "det du gør"
#              Eksempler: stri_detect_*, stri_count_*
# * Scope:     Også kaldet mode. Vil du kigge efter det første, sidste eller alle tilfælde, hvor dit regex mønster matcher?
#              Der er en række funktioner hvor det ikke vil give mening at bruge et scope, som foreksempel `str_count`
#
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

tal <- "1-2asd3ds4asd5qw6--7**8()9"
pattern <- "\d"

stri_*_*(str = tal, regex = pattern)







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
# * 3.1 Kan du finde alle patienter med feber? 
# * 3.2 Hvad med alle, der har smerte? 
# * 3.3 Alle der har rygsmerter

patient_journal <- get_journal()

# ...

assert_symptoms(har_feber, patient_journal)
assert_symptoms(har_smerte, patient_journal)
assert_symptoms(har_har_rygsmerte, patient_journal)



#************************************#
#### 4 - Splitting & cleaning     ####
#************************************#
#
# Regex er et vigtigt værktøj når mere eller mindre struktureret data skal renses. Der er mange små
# "got'cha" når man manuelt skal konvertere et unormalt tekstformat, og du vil i denne opgave støde ind
# i mange små-ting, som alligvel alle er store nok til at stå fuldstændigt i vejen.
#
# Her er noget noisy data om en række firmaer og deres ejere. I nogle tilfælde har ejeren ikke et CVR nummer, 
# for større firmaer kan det ske at ejeren ikke figurerer med CPR nummer, men som udgangspunkt bør de begge stå
# i ID-kolonnen.
# Firmaets nøgletal er skrevet i et format brugt af et forældet revisions-program, og man skal lige tænke sig om
# før det er til at arbejde med. Men bare roligt, det hele kan nemt løses med stringi og regex!
#
# Noisy firma data
# * `ID` kan enten være et CPR nummer eller et CVR nummer eller begge dele i vilkårlig rækkefølge.
#    Nogle af dem der har tastet disse, har været flinke nok til at skrive ting såsom "CPR123456-1234, CVR12345678"
#    mens andre bare har skrevet tallene. 
# * `key_numbers`, Nøgletal for firmaet i formatet "[indtægter]([udgifter])/[årstal] | [skat]/[moms]/[fradrag]".
#    Alle penge tal kan skrives med tusind-seperator [.] og komma [,]. Tal, der ikke er relevante, skrives ikke.
#    fx: "11.235.232,92(151.100)/1996 | 1002200//250,55
#
#
# Dit endelige produkt skal være en data frame med samme format som eksempel_df

eksempel_df <- data_frame(cpr = "1234567890",
                          cvr = "12345678",
                          indtaegt = 123.45,
                          udgift = 123.45,
                          aar = 1996
                          skat = 123.45,
                          moms = 123.45,
                          fradrag = 123.45
                         )


firma_df <- get_noisy_firma()


clean_firma <- firma_df %>% mutate(...) #...

assert_firma(clean_firma)

# Hints
#
# På dansk er `.` tusind-seperator, men på engelsk (og i R) er punktum markør for
# decimal-tal (som vi forvirrende nok kalder for komma tal. Så punktum er komma og komma er punktum!) 
# 

as.numeric("1.000,3") # giver fejl
as.numeric("1.000") == 1 # og ikke et-tusind!
as.numeric("1000.3") # giver et tal du forventer









#************************************#
#### 5 - T9 ordbog                ####
#************************************#
#
# T9 ordbogen fungerer ved at man trykker en række tal ind, som
# programmet vil oversætte til ord. Hvert tal kan repræsentere op til
# 4 bogstaver. Fx er 2 A, B eller C og 7 er P, Q, R, S.
#
# Tag et kig på en god gammel Nokia 3310 for at se hvad hvert tal betyder
# Nokia 3310 -> https://www.vintagemobile.fr/58/nokia-3310.jpg
#
# Til dem af jer, der er for unge til at have haft andet end en smart phone
# er der en handy guide på YouTube https://youtu.be/K-zK_0fNTjY
#
# Fx kan man skrive "HALLO" ved at indtaste følgende tal: 4, 2, 5, 5, 6




# Start med at overvej hvordan ovenstående kan ses som regex mønstrer
patterns <- c('0' = '...',
              '1' = '...')


# Herefter skal vi have noget tekst vi kan slå op i.
# Desværre er det ikke altid lige sådan at finde store mængder tekst i
# et pænt format, så det skal renses!
#
# Her er en liste over 80.000 danske ord, deres bøjninger og disses grammatiske
# katagori. Se http://korpus.dsl.dk/flexikon.html for dokumentation
#
unclean_wordlist <- readLines("data/flexikon.txt")

# Du skal nu overveje om du kun vil have grundstammen (lemma) eller alle bøjninger (inflected forms).
# Vær opmærksom på at grundstammen også optræder som den første bøjning!
# Du skal også overveje om din tekst skal være i lower- eller uppercase. Og om det har en betydning for dine
# regex'es!

wordlist <- unclean_wordlist %>% #stri_...


# du kan bruge dette skelet til at lave dine opslag
opslag_i_t9 <- function(input, patterns=patterns, wordlis = wordlist) {
  
  pattern # <- ...input ... patterns
  opslag <- c()
  opslag # <- ... pattern ... wordlist
  
  return(opslag)
  
}


assert(opslag_i_t9("42556"), "hallo")