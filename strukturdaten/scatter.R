dfdf <-
  df %>% 
  tbl_df %>% 
  select(-Land) %>% 
 # mutate(wahlbeteiligung = wahlbeteiligung * 100) %>% 
  gather(key = "indikator", value = "wert", 5:46) %>% 
  mutate(wert = as.numeric(wert),
         Prozent = as.numeric(Prozent),
         Partei = gsub("CDU","union",Partei),
         Partei = gsub("CSU","union",Partei)) %>% 
  filter(!is.na(Prozent))


party_colors <- c(
  AfD = "#4093B2",
  union = "#333333",
  FDP = "#F6CE5E",
  Grüne = "#60A961",
  Linke = "#B53360",
  SPD = "#E53E44",
  Sonstige = "#999999"
)

scatter <-
  function(partyy,structurr,headline = paste0(partyy,"_vs_",structurr), xlab = structurr){
   dfdf %>% 
      filter(
        Partei == partyy,
        indikator == structurr
        ) %>% 
      ggplot(aes(x = wert, y = Prozent)) +
      geom_point(aes(color = Partei), size = 0.8) +
      geom_smooth(aes(color = Partei), method="lm", se=F, fullrange=FALSE, level=0.95) +
      sztheme_base +
      sztheme_scatter +
      scale_color_manual(values = party_colors) +
      #ggtitle(headline,subtitle="Unterzeile tba") +
      geom_hline(aes(yintercept = mean(Prozent), color = Partei), alpha = .7) +
      geom_vline(aes(xintercept = mean(wert), color = Partei), alpha = .7) +
      labs(
        title = headline,
        subtitle = "Jeder Punkt steht für einen Wahlkreis.",
        caption = "SZ-Grafik: Brunner, Endt, Unterhitzenberger; Quelle: Bundeswahlleiter/Statistisches Bundesamt/Bundesagentur für Arbeit",
        x = xlab,
        y = "Zweitstimmen in Prozent"
      )
    #plot
    #write.csv(data,file = paste0("output/scatter/csv/",headline,".csv"), row.names = FALSE, quote = FALSE, fileEncoding = "UTF-8")
    #export_plots(headline)
    }
