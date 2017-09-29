library(dplyr)
library(tidyr)

# verzeichnis <- read.csv("data/kerg.csv", stringsAsFactors = F, sep=";", fill = T, encoding ="utf-8", skip = 2)
# 
# spaltennamen <- read.csv("data/kerg.csv", stringsAsFactors = F, sep = ";", fill = T, encoding = "utf-8", skip = 2, nrows = 1)
# 
# dict <- select(verzeichnis, Wahlkreis.Nr, Gemeindename, PLZ.GemVerwaltung)
# names(dict) <- c("wk_nr", "name", "plz")
# 
# # write.csv(dict, "Daten/wk-plz-klein.csv", row.names = F, quote = T)
# 
# index_names_nr <- unique(select(verzeichnis, Wahlkreis.Nr, Wahlkreis.Bez))
# names(index_names_nr) <- c("wk_nr", "wk_name")
# write.csv(index_names_nr, "dpa_daten/output/wk-nr-names.csv", row.names = F, quote = T)

link_ergebnisdatei <- "data/kerg.csv"
rename_parties <- c("Christlich Demokratische Union Deutschlands" = "CDU", 
                    "Sozialdemokratische Partei Deutschlands" = "SPD", 
                    "DIE LINKE" = "Linke", 
                    "BÜNDNIS 90/DIE GRÜNEN" = "Grüne", 
                    "Christlich-Soziale Union in Bayern e.V." = "CSU", 
                    "Freie Demokratische Partei" = "FDP", 
                    "Alternative für Deutschland" = "AfD", 
                    "Piratenpartei Deutschland" = "Piraten", 
                    "Nationaldemokratische Partei Deutschlands" = "NPD", 
                    "FREIE WÄHLER" = "Freie Wähler",
                    "Ökologisch-Demokratische Partei", "ÖDP")

header_2017 <- scan(link_ergebnisdatei, nlines = 1, skip = 2, what = character(), sep = ";")
header_2017_2 <- scan(link_ergebnisdatei, skip = 3, nlines = 1, what = character(), sep = ";")
header_2017_3 <- scan(link_ergebnisdatei, skip = 4, nlines = 1, what = character(), sep = ";")
ergebnisse_2017 <- read.csv(link_ergebnisdatei, stringsAsFactors = F, sep=";", fill = T, encoding ="utf-8", skip = 4, header = T)

fill_header_2017 <- function (header_2017_to_fill){
  fill = ""
  for(detail in seq_along(header_2017_to_fill)){
    if(detail > 3){ # 3 bedeutet, das er ab der dritten spalte anfangen soll zu verändern
      if(header_2017_to_fill[detail] != ""){
        fill = header_2017_to_fill[detail]
      }
      if (header_2017_to_fill[detail] == ""){
        header_2017_to_fill[detail] = fill
      }
    }
  }
  return(header_2017_to_fill)
}

check_fill <- function (fill){
  rv <- rename_parties[fill]
  return(rv)
}
do_rename_parties <- function(header_to_rename){
  for(detail in seq_along(header_to_rename)){
    checked <- check_fill(header_to_rename[detail])
    header_to_rename[detail] = ifelse(!is.na(checked),checked, header_to_rename[detail])
  }
  return(header_to_rename)
}
header_2017 <- do_rename_parties(header_2017)
header_2017 <- fill_header_2017(header_2017)
header_2017_2 <- fill_header_2017(header_2017_2)

names(ergebnisse_2017) <- paste0(header_2017,"_", header_2017_2, "_", header_2017_3)
# colnames(ergebnisse)[1:5] <- c("wk_nr", "wk_name", "belongs_to", "berechtigte", "waehler")

# ergebnisse_2017 <- mutate(ergebnisse_2017, beteiligung = ('Wähler_Erststimmen_Vorläufig')/'Wahlberechtigte_Erststimme_Vorläufig')
# ergebnisse <- select(ergebnisse, wk_nr, wk_name, beteiligung, grep("Zweitstimme", names(ergebnisse)))
# ergebnisse <- select(ergebnisse, 1:3, 5:ncol(ergebnisse), 4)
# 162749
# districts <- filter(ergebnisse, wk_nr > 900 & wk_nr < 990 )
# germany <- filter(ergebnisse, wk_nr > 990)
# 6596 + 156153
# germany <- gather(germany, "partei", "stimmen", 6:ncol(germany))
# germany <- mutate(germany, anteil = round(stimmen/Gültige_Zweitstimmen, 3))
# # germany <- filter(germany, )
# # germany <- mutate(germany, anteil_ungueltig = Ungültige_Zweitstimmen/(Ungültige_Zweitstimmen + Gültige_Zweitstimmen))
# 
# wk_data <- filter(ergebnisse, wk_nr < 900)
# # wk_data[8:ncol(wk_data)]
# wk_data <- gather(wk_data, "partei", "stimmen", 6:ncol(wk_data))
# wk_data <- mutate(wk_data, anteil = round(stimmen/Gültige_Zweitstimmen,3))
# # wk_data <- mutate(wk_data, anteil_ungueltig = Ungültige_Zweitstimmen/(Ungültige_Zweitstimmen + Gültige_Zweitstimmen))
# wk_data$partei <- gsub("_Zweitstimmen" , "", wk_data$partei)


## überprüfen, wie oft es vorkommt, dass Parteien, die unter der 5%-Hürde blieben, in bestimmten Wahlkreisen drüber liegen
# Sonderfall 2013: Wird bei der FDP tatsächlich oft der Fall sein

# 
# wk_data %>% count(partei)
# parlament_parties <- c("GRÜNE", "CSU", "CDU", "DIE LINKE", "SPD")
# wk_data <- wk_data %>% mutate(parlament = ifelse(partei %in% parlament_parties, 1, 0))
# 
# # welche parteien wie oft über der fünf prozenthürde liegen - es aber trotzdem nicht in den bundestag geschafft haben:
# wk_data %>% filter(parlament == 0, anteil > 0.05) %>% count(partei)