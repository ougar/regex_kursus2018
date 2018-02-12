# Regex opgaver


## 1 Basic
**Opgave 1.1**

Find alle steder i følgende tekst hvor der står refereres til regex https://regex101.com/r/NOK4l4/2

* Der er 7 omtaler af regex på engelsk og 4 på dansk i teksten. Hvor mange kan du finde med 1 søgning?
* Hvis du søger på `regex` finder du kun dem, der står med småt og ikke `Regex` eller nogle af de danske udgaver
* Hvis du søger på `reg` finder du også de danske omtaler, men stadig kun dem med småt samt andre ord, der starter med `reg`, så som "regel"

Når man søger i tekst, er der en masse små finurligheder, som man ofte selv tænker "jamen, det er jo det samme", men som dit mønster vil differentiere på.

** Opgave 1.2 **
Lad os se på nogle flere problemer. Forestil dig at du har modtaget et datasæt over patienter, hvor en af kolonnerne hedder "symptomer". Kan du finde antallet af patienter med feber? Hvad med alle, der har smerte? Hvilket problem er der med at finde antallet af patienter med smerte? Når du begynder at bruge regex i R, vil du nemt kunne spørge hvor mange linier/datapunkter et mønster matcher på, frem for kun hvor mange matches der er. Men det er vigtigt at holde sig for øje at disse 2 ting ikke er det samme! https://regex101.com/r/9g6SoR/2

## 2 Klammer

**Opgave 2.1**
Vi fortsætter med at kigge på patienterne fra opgave 1.2. Du er interesseret i at finde alle patienter med smerter i ryggen. Desværre er symptomerne noget en læge er tastet ind i fri-tekst. Kan du ved hjælp af klammer finde alle 62 patienter med rygsmerter? https://regex101.com/r/9g6SoR/2

**Opgave 2.2**
En mere typisk opgave vil være at finde løbe-numrer, fx nummerplader. Forestil dig at du har modtaget et datasæt med 500 nummerplader, både danske og tyske.
Kan du finde et regex mønster, der kan finde de 248 danske nummerplader? Kan du finde de tyske? https://regex101.com/r/4Sxzad/1

* En dansk nummerplade består af 2 bogstaver og 5 tal. I dette tilfælde er en seperator imellem det sidste bogstav og det første tal
* En tysk nummerplade består af 4 bogstaver og 2 tal. Der er en seperator imellem hver blok af 2 tegn.
* For nemhedsskyld antager vi at der altid bliver brugt en seperator, og at de eneste seperator tegn der bliver brugt er " " (`mellemrum`) "-" (`bindestreg`) og ":" (`kolon`)

## 3 Character Classes

**Opgave 3.1**
Kan du løse opgave 2.2 uden brug af klammer, men kun med brug af character classes? Du kan antage at seperatoren kan være et hvilketsomhelst tegn, undtagen bogstaver eller tal. Kig under *meta sequences* i kassen *Quick References* på regex101.com for at få inspiration til character classes du kan bruge i dit mønster.

## 4 Repititions

**Opgave 4.1**
Kan du forkorte længden af dit mønster fra opgave 3.1 vha. repititions?

## Special Characters

## Groups

## Større opgave
