

# load data strukturdaten des bundeswahlleiters
# Strukturdaten für die Wahlkreise zum 19. Deutschen Bundestag (Bundestagswahl am 24.09.2017)                      
# Zeichensatz: CP 1252. Trennzeichen: Semikolon.                      
# Link https://www.bundeswahlleiter.de/bundestagswahlen/2017/strukturdaten.html

df <- read.csv("strukturdaten/data/btw17_strukturdaten.csv", stringsAsFactors = F, sep = ";", encoding ="latin1", skip = 8)

# get all the variable names
colnames(df)

# a litte bit of data cleaning with purrr
df <- df %>% map(gsub, pattern = ",", replacement = ".")
df <- df %>% map_at(4:51, as.numeric)
#df %>% map_at(4:51, )


# map and map_at converts data frames to matrices --> as.data.frame() neccessary:
df <- as.data.frame(df) %>% 
  mutate(Wahlkreis.Nr. = as.numeric(as.character(Wahlkreis.Nr.)))

# get decimal numbers
#df <- df %>% mutate_at(4:51, funs(./100))

# make column names more reader-friendly
df <-
  df %>%
  select(
    Land, Wahlkreis.Nr., Wahlkreis.Name,
    Fläche.km2 = Fläche.am.31.12.2015..km..,
    Einwohner.tausend = Bevölkerung.am.31.12.2015...Insgesamt..in.1000.,
    Deutsche.tausend = Bevölkerung.am.31.12.2015...Deutsche..in.1000.,
    Ausländeranteil.Prozent = Bevölkerung.am.31.12.2015...Ausländer....,
    Einwohner.Dichte = Bevölkerungsdichte.am.31.12.2015..Einwohner.je.km..,
    Geburtensaldo.je1000 = Zu......bzw..Abnahme.....der.Bevölkerung.2015...Geburtensaldo..je.1000.Einwohner.,
    Wanderungssaldo.je1000 = Zu......bzw..Abnahme.....der.Bevölkerung.2015...Wanderungssaldo..je.1000.Einwohner.,
    Alter_U18.Prozent = Alter.von.....bis.....Jahren.am.31.12.2015...unter.18....,
    Alter_18_24.Prozent = Alter.von.....bis.....Jahren.am.31.12.2015...18.24....,
    Alter_25_34.Prozent = Alter.von.....bis.....Jahren.am.31.12.2015...25.34....,
    Alter_35_59.Prozent = Alter.von.....bis.....Jahren.am.31.12.2015...35.59....,
    Alter_60_74.Prozent = Alter.von.....bis.....Jahren.am.31.12.2015...60.74....,
    Alter_Ü75.Prozent = Alter.von.....bis.....Jahren.am.31.12.2015...75.und.mehr....,
    Ohne_Migrationshintergrund.Prozent = Zensus.2011..Bevölkerung.nach.Migrationshintergrund.am.09.05.2011...ohne.Migrationshintergrund....,
    Mit_Migrationshintergrund.Prozent = Zensus.2011..Bevölkerung.nach.Migrationshintergrund.am.09.05.2011...mit.Migrationshintergrund....,
    Reli_Katholisch.Prozent = Zensus.2011..Bevölkerung.nach.Religionszugehörigkeit.am.09.05.2011...Römisch.katholische.Kirche....,
    Reli_Evangelisch.Prozent = Zensus.2011..Bevölkerung.nach.Religionszugehörigkeit.am.09.05.2011...Evangelische.Kirche....,
    Reli_Sonst.Prozent = Zensus.2011..Bevölkerung.nach.Religionszugehörigkeit.am.09.05.2011...Sonstige..keine..ohne.Angabe....,
    Wohnungen_gebaut2014.je1000Einw = Bautätigkeit.und.Wohnungswesen...Fertiggestellte.Wohnungen.2014..je.1000.Einwohner.,
    Wohnungen_Bestand.je1000Einw = Bautätigkeit.und.Wohnungswesen...Bestand.an.Wohnungen.am.31.12.2015..je.1000.Einwohner.,
    BIP.jeEinw = Bruttoinlandsprodukt.2014....je.Einwohner.,
    Haushaltseinkommen.jeEinw = Verfügbares.Einkommen.der.privaten.Haushalte.2014....je.Einwohner.,
    Kfz_Bestand.je1000Einw = Kraftfahrzeugbestand.am.01.01.2016..je.1000.Einwohner.,
    Ohne_Abschluss.Prozent = Absolventen.Abgänger.allgemeinbildender.Schulen.2015...ohne.Hauptschulabschluss....,
    Hauptschule.Prozent = Absolventen.Abgänger.allgemeinbildender.Schulen.2015...mit.Hauptschulabschluss....,
    Mittlere_Schule.Prozent = Absolventen.Abgänger.allgemeinbildender.Schulen.2015...mit.mittlerem.Schulabschluss....,
    Abitur.Prozent = Absolventen.Abgänger.allgemeinbildender.Schulen.2015...mit.allgemeiner.und.Fachhochschulreife....,
    Betreute_Kinder.je1000Einw = Kindertagesbetreuung..Betreute.Kinder.am.01.03.2016..je.1000.Einwohner.,
    Unternehmen.je1000Einw = Unternehmensregister.2014...Unternehmen.insgesamt..je.1000.Einwohner.,
    Handwerksunternehmen.je1000Einw = Unternehmensregister.2014...Handwerksunternehmen..je.1000.Einwohner.,
    Svp_Beschäftigte.je1000Einw = Sozialversicherungspflichtig.Beschäftigte.am.30.06.2016...insgesamt..je.1000.Einwohner.,
    Svp_Beschäftigte_LandwForstwFischerei.Prozent = Sozialversicherungspflichtig.Beschäftigte.am.30.06.2016...Land..und.Forstwirtschaft..Fischerei....,
    Svp_Beschäftigte_ProduzierendesGewerbe.Prozent = Sozialversicherungspflichtig.Beschäftigte.am.30.06.2016...Produzierendes.Gewerbe....,
    Svp_Beschäftigte_HandelGastgewerbeVerkehr.Prozent = Sozialversicherungspflichtig.Beschäftigte.am.30.06.2016...Handel..Gastgewerbe..Verkehr....,
    Svp_Beschäftigte_ÖffentlicheUndPrivateDienstleister.Prozent = Sozialversicherungspflichtig.Beschäftigte.am.30.06.2016...Öffentliche.und.private.Dienstleister....,
    HartzIV.je1000Einw = Empfänger.innen..von.Leistungen.nach.SGB.II.am.31.12.2016....insgesamt..je.1000.Einwohner.,
    HartzIV__Ausländer = Empfänger.innen..von.Leistungen.nach.SGB.II.am.31.12.2016...Ausländer....,
    Arbeitslose.Prozent = Arbeitslosenquote.März.2017...insgesamt,
    Arbeitslos_Männer.Prozent = Arbeitslosenquote.März.2017...Männer,
    Arbeitslos_Frauen.Prozent = Arbeitslosenquote.März.2017...Frauen,
    Arbeitslos_Alter_15_19.Prozent = Arbeitslosenquote.März.2017...15.bis.unter.20.Jahre,
    Arbeitslos_Alter_55_64.Prozent = Arbeitslosenquote.März.2017...55.bis.unter.65.Jahre
  )

struktur <- df %>% 
  arrange(Wahlkreis.Nr.)

