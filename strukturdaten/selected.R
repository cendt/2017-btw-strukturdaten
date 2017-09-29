plot <- scatter("SPD","HartzIV.je1000Einw")
export_plots("spd_hartz4")
plot <- scatter("FDP","Haushaltseinkommen.jeEinw")
export_plots("fdp_einkommen")
plot <- scatter("union","Kfz_Bestand.je1000Einw")
export_plots("union_kfz")
plot <- scatter("union","Einwohner.Dichte")
export_plots("union_einwohner")
plot <- scatter("AfD","HartzIV__Ausländer")
export_plots("afd_hartz4")
plot <- scatter("Linke","Ohne_Abschluss.Prozent")
export_plots("linke_abschluss")
plot <- scatter("Grüne","Mit_Migrationshintergrund.Prozent")
export_plots("grüne_migranten")

scatter("AfD","Ausländeranteil.Prozent")

data <-
  dfdf %>%
  filter(
    Partei == "union",
    indikator == "Kfz_Bestand.je1000Einw"
  )
write.csv(data,file = paste0("output/scatter/csv/","afd_hartz4",".csv"), row.names = FALSE, quote = FALSE, fileEncoding = "UTF-8")

data.afd <-
  dfdf %>% 
  filter(
    Partei == "AfD",
    indikator == "Ausländeranteil.Prozent"
  )

write.csv(data.afd,file = paste0("output/scatter/csv/","afd_auslaender",".csv"), row.names = FALSE, quote = FALSE, fileEncoding = "UTF-8")


data.spd <-
  dfdf %>%
  filter(
    Partei == "SPD",
    indikator == "HartzIV.je1000Einw"
  )
