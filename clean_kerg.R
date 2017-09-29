# TODO:
# "gehört zu" als Bundesland kodieren

### Im Laufe der Nacht wird an stelle des Worts "Vorläufig" wahrscheinlich etwas anderes treten.
### Dann muss das ganze Skript mit Search&Replace angepasst werden.

ergebnisse <-
  ergebnisse_2017 %>% 
  # Leerzeilen raus
  filter(!is.na(Nr__)) %>% 
  #Trennung nach Gesamt, Ländern und Wahlkreisen
  mutate(
    Typ = ifelse(`gehört zu__`==99,
                 "Land",
                 ifelse(
                   is.na(`gehört zu__`),
                   "Bund",
                   ifelse(
                     Nr__ > 300,
                     "Berlin_halb",
                     "Wahlkreis"
                 )))
  ) %>% 
  # Kleinparteien raus
  select(1:47,Typ)

# Ländernamen extrahieren
laender <-
  ergebnisse %>%
  filter(Typ == "Land") %>% 
  select(Nr = "Nr__", Land = "Gebiet__")

#Ländernamen reinjoinen
ergebnisse <-
  ergebnisse %>% 
  left_join(laender, by = c("gehört zu__" = "Nr")) %>% 
  # Partei-Ergebnisse gathern
  gather(key = "partei", value = "Anzahl_Stimmen", 20:47) %>% 
  # Informatonen zu Erst- oder Zweitstimme und zum Status (Vorläufig, Vorjahr etc) aus Partei extrahieren
  separate(partei, into = c("Partei", "Stimme","Status"), sep = "_") %>% 
  # kosmetisches Umbenennen
  mutate(Stimme = ifelse(Stimme=="Erststimmen","Erststimme",ifelse(Stimme=="Zweitstimmen","Zweitstimme",NA))
  ) %>% 
  ### Matching der Wahlberechtigten, Wähler, Ungültigen und Gültigen zu Status und Stimme.
  mutate(
    Wahlberechtigte =
      ifelse(
        Stimme == "Erststimme" & Status == "Vorperiode",
        Wahlberechtigte_Erststimmen_Vorperiode,
        ifelse(
          Stimme == "Erststimme" & Status == "Vorläufig",
          Wahlberechtigte_Erststimmen_Vorläufig,
          ifelse(
            Stimme == "Zweitstimme" & Status == "Vorperiode",
            Wahlberechtigte_Zweitstimmen_Vorperiode,
            ifelse(
              Stimme == "Zweitstimme" & Status == "Vorläufig",
              Wahlberechtigte_Zweitstimmen_Vorläufig,
              NA
            )
          )
        )
      ),
    Wähler =
      ifelse(
        Stimme == "Erststimme" & Status == "Vorperiode",
        Wähler_Erststimmen_Vorperiode,
        ifelse(
          Stimme == "Erststimme" & Status == "Vorläufig",
          Wähler_Erststimmen_Vorläufig,
          ifelse(
            Stimme == "Zweitstimme" & Status == "Vorperiode",
            Wähler_Zweitstimmen_Vorperiode,
            ifelse(
              Stimme == "Zweitstimme" & Status == "Vorläufig",
              Wähler_Zweitstimmen_Vorläufig,
              NA
            )
          )
        )
      ),
    Ungültig =
      ifelse(
        Stimme == "Erststimme" & Status == "Vorperiode",
        Ungültige_Erststimmen_Vorperiode,
        ifelse(
          Stimme == "Erststimme" & Status == "Vorläufig",
          Ungültige_Erststimmen_Vorläufig,
          ifelse(
            Stimme == "Zweitstimme" & Status == "Vorperiode",
            Ungültige_Zweitstimmen_Vorperiode,
            ifelse(
              Stimme == "Zweitstimme" & Status == "Vorläufig",
              Ungültige_Zweitstimmen_Vorläufig,
              NA
            )
          )
        )
      ),
    Gültig =
      ifelse(
        Stimme == "Erststimme" & Status == "Vorperiode",
        Gültige_Erststimmen_Vorperiode,
        ifelse(
          Stimme == "Erststimme" & Status == "Vorläufig",
          Gültige_Erststimmen_Vorläufig,
          ifelse(
            Stimme == "Zweitstimme" & Status == "Vorperiode",
            Gültige_Zweitstimmen_Vorperiode,
            ifelse(
              Stimme == "Zweitstimme" & Status == "Vorläufig",
              Gültige_Zweitstimmen_Vorläufig,
              NA
            )
          )
        )
      )
  ) %>%
  select(Nr = "Nr__", Gebiet = "Gebiet__", Land, Typ, Status, Stimme, Wahlberechtigte, Wähler, Gültig, Ungültig, Partei, Anzahl_Stimmen) %>% 
  mutate(
    # Fill NAs in Land
    Land = ifelse(Typ == "Wahlkreis",Land,Gebiet),
    # Calculate Percents
    Prozent = Anzahl_Stimmen / Gültig * 100)