# (c) Der Bundeswahlleiter, Wiesbaden 2016
# 
#Ergebnis der Wahl zum 18. Deutschen Bundestag am 22. September 2013 
#umgerechnet auf die 299 Wahlkreise in der für die Bundestagswahl 2017 festgelegten Abgrenzung;

# Preprocessing:
# 1. Open .CSV files in Sublime (all other editors I tried couldn't handle the Umlaute)
# 2. Remove top rows
# 3. Save with encoding --> UTF-8

# import
df <- read.csv("strukturdaten/data/btwkr17_umrechnung_btw13.csv", stringsAsFactors = F, sep = ";", encoding ="utf-8")

# clean_data, especially colnames
colnames1 <- names(df) %>% as.data.frame()
names(colnames1) <- "colnames1"
colnames1 %>% head
# 1st row of data, indicating erst oder zweitstimme
colnames2 <- df %>% slice(1) %>% as.matrix() %>% as.vector() %>% as.data.frame()
names(colnames2) <- "colnames2"
colnames2 %>% head
# paste colnames2 on colnames
new_colnames <- cbind(colnames1, colnames2)
new_colnames %>% head()
new_colnames$names <- paste(new_colnames$colnames1, new_colnames$colnames2, sep="_")

# vector with new names
new_colnames <- new_colnames %>% select(names) %>% as.matrix() %>% as.vector()
# clean some names
new_colnames <- gsub("_NA", "", new_colnames)
new_colnames <- gsub("_", "", new_colnames)

# give df new colnames
names(df) <- new_colnames


# we only need zweitstimmen
base_cols <- c("Wkr.Nr.", "Land", "Wahlkreisname", "Wahlberechtigte", "Wähler")
df <- df %>% 
  select(base_cols, dplyr::contains("Zweitstimmen")) %>% 
  # filter 1st row
  filter(!is.na(Wahlberechtigte))

# get rid of "1" in col-names
colnames(df) <- gsub("1","",names(df))

# rename important columns
df <- df %>%
  rename(ungültig = Ungültige.Zweitstimmen,
         gültig = Gültige.Zweitstimmen)

names(df) <- tolower(names(df))
# get rid of Zweistimmen at the end of colnames
#colnames(df) <- gsub("\\.[^\\.]*$", "", names(df))
#colnames(df) <- gsub("zweistimmen", "", names(df))

df <- df %>% 
  select(1:7, matches('cdu|spd|linke|fdp|csu|afd|grüne'))
#colnames(df) <- gsub("\\.[^\\.]*$", "", names(df))

#df <- df %>% 
 # rename(linke = die.linke, grüne = gr.ne)


### calculate anteile
dim(df)
# as.numeric
df <- df %>% map_at(4:14, as.numeric)
df <- as.data.frame(df)
# percentages
df <-
  df %>%
  mutate(
    cdu = cdu.zweitstimmen/gültig,
    spd = spd.zweitstimmen/gültig,
    fdp = fdp.zweitstimmen/gültig,
    linke = die.linke.zweitstimmen/gültig,
    grüne = grüne.zweitstimmen/gültig,
    csu = csu.zweitstimmen/gültig,
    afd = afd.zweitstimmen/gültig,
    union = cdu + csu,
    wahlbeteiligung = wähler/wahlberechtigte
    ) %>% 
  # cdu und csu zusammenzählen
  select(everything(), -dplyr::contains("zweit"), -csu, -cdu, -wähler, -wahlberechtigte, -ungültig, -gültig) %>%
  # make longform
  gather(-wkr.nr., -land, -wahlkreisname, -wahlbeteiligung, key = "partei", value = "percent") %>% 
  mutate(percent = percent * 100)

results <- df

