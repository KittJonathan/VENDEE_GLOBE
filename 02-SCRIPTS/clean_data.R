# 📦 Load packages --------------------------------------------------------

library(tidyverse)
library(readxl)
library(maps)
library(parzer)

# 📃 List files -----------------------------------------------------------

paths <- list.files(path = "01-DATA_RAW/", full.names = T)

all_files <- tibble(path = paths) |> 
  separate(col = path, into = c("dir", "file"), sep = "/", remove = FALSE) |> 
  select(-dir) |> 
  mutate(date_time = str_remove_all(string = file, pattern = "vendeeglobe_leaderboard_"),
         date_time = str_remove_all(string = date_time, pattern = ".xlsx")) |> 
  separate(col = date_time, into = c("date", "time"), sep = "_") |> 
  select(-file) |> 
  arrange(date, time)

# 📄 Create skippers/boats dataset ----------------------------------------

skipper_boat <- tibble(
  Name = c("Sam", "Sébastien", "Yoann", "Charlie", "Nicolas",
           "Thomas", "Jérémie", "Yannick", "Samantha", "Clarisse",
           "Justine", "Paul", "Jean", "Benjamin", "Damien",
           "Pip", "Boris", "Romain", "Isabelle", "Louis",
           "Sébastien", "Benjamin", "Eric", "Arnaud", "Louis",
           "Tanguy", "Giancarlo", "Conrad", "Violette", "Antoine",
           "Guirec", "Kojiro", "Alan", "Fabrice", "Manuel",
           "Oliver", "Denis", "Jingkun", "Szabolcs", "Maxime"),
  Surname = c("Goodchild", "Simon", "Richomme", "Dalin", "Lunven",
              "Ruyant", "Beyou", "Bestaven", "Davies", "Crémer",
              "Mettraux", "Meilhat", "Le Cam", "Dutreux", "Séguin",
              "Hare", "Herrmann", "Attanasio", "Joschke", "Burton",
              "Marsset", "Ferré", "Bellion", "Boissières", "Duc",
              "Le Turquais", "Pedote", "Colman", "Dorange", "Cornic",
              "Soudée", "Shiraishi", "Roura", "Amedeo", "Cousin",
              "Heer", "Van Weynbergh", "Xu", "Weöres", "Sorel"),
  Boat = c("VULNERABLE", "GROUPE DUBREUIL", "PAPREC ARKEA", "MACIF SANTE PREVOYANCE", "HOLCIM - PRB",
           "VULNERABLE", "CHARAL", "MAITRE COQ V", "INITIATIVES-COEUR", "L'OCCITANE EN PROVENCE",
           "TEAMWORK - TEAM SNEF", "BIOTHERM", "TOUT COMMENCE EN FINISTERE - ARMOR-LUX",
           "GUYOT ENVIRONNEMENT - WATER FAMILY", "GROUPE APICIL", "MEDALLIA", "MALIZIA - SEA EXPLORER",
           "FORTINET - BEST WESTERN", "MACSF", "BUREAU VALLEE", "FOUSSIER", "MONNOYEUR - DUO FOR A JOB",
           "STAND AS ONE - ALTAVIA", "LA MIE CALINE", "FIVES GROUP - LANTANA ENVIRONNEMENT", "LAZARE",
           "PRYSMIAN", "MS AMLIN", "DEVENIR", "HUMAN IMMOBILIER", "FREELANCE.COM", "DMG MORI GLOBAL ONE",
           "HUBLOT", "NEXANS - WEWISE", "COUP DE POUCE", "TUT GUT", "D'IETEREN GROUP", "SINGCHAIN TEAM HAIKOU",
           "NEW EUROPE", "V AND B - MONBANA - MAYENNE"),
  Nat = c("GBR", rep("FRA", 7), "GBR", "FRA", "SUI", rep("FRA", 4), "GBR", "GER", rep("FRA", 9),
                 "ITA", "NZL", rep("FRA", 3), "JPN", "SUI", "FRA", "FRA", "SUI", "BEL", "CHN", "HUN", "FRA"),
  Sail = c("FRA 100", "FRA 112", "FRA 24", "FRA 79", "FRA85", "FRA 59", "FRA 3", "FRA 17", "FRA 109", "FRA 15", "FRA 08",
                  "FRA 2030", "FRA 29", "FRA 09", "FRA 13", "GBR 777", "MON 1297", "FRA 10", "FRA 27", "FRA 18", "FRA 83", "FRA 30",
                  "FRA 5", "FRA 14", "FRA 172", "FRA 1000", "ITA 34", "NZL 64", "FRA 01", "FRA 1461", "FRA 22", "JPN 11", "SUI 7",
                  "FRA 56", "FRA 71", "SUI 49", "BEL 207", "CHN 5", "HUN 23", "FRA 53"))

# ⬇️ Get data and clean ---------------------------------------------------

all_data <- list()

for (i in 1:nrow(all_files)) {
  
  df <- readxl::read_xlsx(all_files$path[i], 
                          range = "B6:U45", col_names = FALSE)
  
  names(df) <- c("Rank", "Nat_Sail", "Skipper_Boat", "Hour_FR", "Latitude", "Longitude",
                 "Last30min_heading", "Last30min_speed", "Last30min_VMG", "Last30min_distance",
                 "SinceLastStandings_heading", "SinceLastStandings_speed", "SinceLastStandings_VMG",
                 "SinceLastStandings_distance", "Last24hrs_heading", "Last24hrs_speed", 
                 "Last24hrs_VMG", "Last24hrs_distance", "Distance_to_finish", "Distance_to_leader")
  
  all_data[[i]] <- df |> 
    mutate(Nat = str_extract(string = Nat_Sail, pattern = "^.{3}"),
           Sail = str_remove(string = Nat_Sail, pattern = "^.{3}"),
           .after = Nat_Sail) |> 
    left_join(skipper_boat) |> 
    select(Rank, Nat, Sail, Surname, Name, Hour_FR:Distance_to_leader) |> 
    mutate(Date = all_files$date[i],
           Time = all_files$time[i],
           .before = Rank)

  }

all_data <- bind_rows(all_data)

# 💾 Export the dataset ---------------------------------------------------

write_csv(x = all_data, file = "03-DATA_PROCESSED/clean_data.csv")

# 🌍 Create map -----------------------------------------------------------

world <- map_data("world")

p <- ggplot() +
  geom_polygon(data = world, aes(x = long, y = lat, group = group),
               fill = "#afcfdf") +
  geom_point(data = sam, aes(x = lon, y = lat),
             col = "white") +
  geom_line(data = sam, aes(x = lon, y = lat),
             col = "white") +
  geom_text(aes(x = -25, y = 35, label = "22748.9 nm to finish")) +
  coord_fixed(ratio = 1.3, xlim = c(-30, 5), ylim = c(25, 50)) +
  labs(title = "Vendée Globe 2024",
       subtitle = "2024-11-15 - Leader : Sam Goodchild") +
  theme_void() +
  theme(panel.background = element_rect(colour = "#485fb0",
                                        fill = "#485fb0"),
        plot.background = element_rect(colour = "#485fb0",
                                        fill = "#485fb0"),
        plot.title = element_text(colour = "white"),
        plot.subtitle = element_text(colour = "white"))

ggsave(filename = "04-MAPS/sam.png", plot = p, dpi = 320, width = 6, height = 6)
