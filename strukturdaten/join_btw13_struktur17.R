# join results btw 13 and strukturdaten btw 17 for bund/länder and wahlkreise

#und_land <- anti_join(ergebnisse, struktur, by =c("Nr" = "Wahlkreis.Nr."))
#write.table(bund_land, "output/bund_länder.csv", sep="\t", row.names = F, quote = F)

ergebnisse_2017 <-
  ergebnisse %>%
  filter(Status == "Vorläufig",
         Stimme == "Zweitstimme",
         Typ == "Wahlkreis")

df <-
  ergebnisse_2017 %>% 
  left_join(struktur, by = c("Nr" = "Wahlkreis.Nr.")) %>%
  mutate(wahlbeteiligung = Wähler / Wahlberechtigte) %>% 
 select(Nr,Gebiet,Land = "Land.x", Partei, Prozent, 16:58)


#write.table(bund_land, "output/results_btw13_struktur17.csv", sep="\t", row.names = F, quote = F)
