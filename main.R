# Generelle Config
source("sz-config.R")
source("export.R")

# Daten einlesen und aufräumen
source("read_kerg.R")
source("clean_kerg.R")

# Direktmandate für QGIS
source("direktmandate.R")

# Länder
# a) Ergebnis-Export für Print
# b) Ergebnis-Balken für Online&Digital
#### WICHTIG: ggf Search&Replace "Vorläufig" !!!
source("laender.R")

# Ost und West

# Strukturdaten
source("strukturdaten/import_strukturdaten_btw17.R")
source("strukturdaten/join_kerg_struktur17.R")
