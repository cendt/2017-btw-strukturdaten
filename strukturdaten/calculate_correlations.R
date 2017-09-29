library(corrr)
parteien <- c("union", "SPD", "FDP", "Grüne", "Linke", "AfD")


# correlations can only be calculated with numeric variables, everything else must be removed
df_num <- 
  df %>%
  mutate(Partei = gsub("CDU","union",Partei),
         Partei = gsub("CSU","union",Partei)) %>% 
  select(Partei,5:47)

correlations <- data.frame()

for (i in parteien) {
  corr <- df_num %>% 
    filter(Partei == i) %>% 
    select(-Partei) %>% 
    correlate() %>% 
    select(rowname, Prozent) %>% 
    arrange(desc(Prozent)) %>% 
    as.data.frame()
  
  partei <- i %>% as.data.frame()
  corr_partei <- cbind(corr, partei)
  correlations <- rbind(correlations, corr_partei)    
}

colnames(correlations) <- c("indikator","corr","partei")

# * corr = 0 - 0.2: very weak
# * 0.2 - 0.4: weak to moderate
# * 0.4 - 0.6: medium to substantial
# * 0.6 - 0.8: very strong
# * 0.8 - 1: extremly strong

correlations <- correlations %>%
  mutate(strength= ifelse(abs(corr) > 0.8, "extremely strong", 
                                         ifelse(abs(corr) > 0.6, "strong",
                                                ifelse(abs(corr) > 0.4, "medium/substantial",
                                                  ifelse(abs(corr) > 0.2, "weak to moderate",
                                                         "very weak"))))) %>% 
  select(partei,indikator,corr,strength) %>% 
  tbl_df

