# Script used to create dataset with skippers and boats
# 2025-02-26

# 📦 Load packages --------------------------------------------------------

library(tidyverse)

# 📄 Create dataset -------------------------------------------------------

head(skippers)

skippers2 <- tibble::tribble(
  ~name, ~surname, ~nationality, ~date_of_birth, ~boat, ~sail, ~appendices, ~nb_participations,
  "Fabrice", "Amedeo", "FR", "1978-02-24", "Nexans - Wewise", "FRA 56", "straight keels", 3,
  "Romain", "Attanasio", "FR", "1977-06-26", "Fortinet - Best Western", "FRA 10", "foils", 3,
  "Eric", "Bellion", "FR", "1976-03-15", "Stand as one - Altavia", "FRA 5", "straight keels", 2,
  "Yannick", "Bestaven", "FR", "1972-12-28", "Maître Coq V", "FRA 17", "foils", 3,
  "Jérémie", "Beyou", "FR", "1976-06-26", "Charal", "FRA 3", "foils", 5,
  "Arnaud", "Boissières", "FR", "1972-07-20", "La Mie câline", "FRA 14", "foils", 5,
  "Louis", "Burton", "FR", "1985-06-04", "Bureau Vallée 3", "FRA 18", "foils", 4,
  "Conrad", "Colman", "NZL/USA", "1983-12-02", "MS Amlin", "NZL 64", "straight keels", 2,
  "Antoine", "Cornic", "FR", "1980-01-04", "Human Immobilier", "FRA 1461", "straight keels", 1,
  "Manuel", "Cousin", "FR", "1967-07-10", "Coup de pouce", "FRA 71", "straight keels", 2,
  "Clarisse", "Crémer", "FR", "1989-12-30", "L'Occitane en Provence", "FRA 15", "foils", 2,
  "Charlie", "Dalin", "FR", "1984-05-10", "Macif santé prévoyance", "FRA 79", "foils", 2,
  "Samantha", "Davies", "GBR", "1974-08-23", "Initiatives-Coeur", "FRA 109", "foils", 4,
  "Violette", "Dorange", "FR", "2001-04-17", "Devenir", "FRA 01", "straight keels", 1,
  "Louis", "Duc", "FR", "1983-09-18", "Fives Group - Lantana Environnement", "FRA 172", "straight keels", 1,
  "Benjamin", "Dutreux", "FR", "1990-04-05", "Guyot Environnement - Water Family", "FRA 09", "foils", 2,
  "Benjamin", "Ferré", "FR", "1990-10-31", "Monnoyeur - Duo For a Job", "FRA 30", "straight keels", 1,
  "Sam", "Goodchild", "GBR", "1989-11-19", "Vulnerable (Advens 1)", "FRA 100", "foils", 1,
  "Pip", "Hare", "GBR", "1974-02-07", "Medallia", "GBR 777", "foils", 2,
  "Oliver", "Heer", "SUI", "1988-05-10", "Tut gut", "SUI 49", "straight keels", 1,
  "Boris", "Herrmann", "GER", "1981-05-28", "Malizia - Sea explorer", "MON 1297", "foils", 2,
  "Isabelle", "Joschke", "GER/FR", "1977-01-27", "MACSF", "FRA 27", "foils", 2,
  "Jean", "Le Cam", "FR", "1959-04-27", "Tout commence en Finistère - Armor lux", "FRA 29", "straight keels", 6,
  "Tanguy", "Le Turquais", "FR", "1989-06-25", "Lazare", "FRA 1000", "straight keels", 1,
  "Nicolas", "Lunven", "FR", "1982-11-28", "Holcim - PRB", "FRA85", "foils", 1,
  "Sébastien", "Marsset", "FR", "1984-12-15", "Foussier", "FRA 83", "straight keels", 1,
  "Paul", "Meilhat", "FR", "1982-05-17", "Biotherm", "FRA 2030", "foils", 2,
  "Justine", "Mettraux", "SUI", "1986-10-04", "Teamwork - Team Snef", "FRA 08", "foils", 1,
  "Giancarlo", "Pedote", "ITA", "1975-12-26", "Prysmian Group", "ITA 34", "foils", 2,
  "Yoann", "Richomme", "FR", "1983-07-12", "Paprec Arkéa", "FRA 24", "foils", 1,
  "Alan", "Roura", "SUI", "1993-02-26", "Hublot", "SUI 7", "foils", 3,
  "Thomas", "Ruyant", "FR", "1981-05-24", "Vulnerable (Advens 2)", "FRA 59", "foils", 3,
  "Damien", "Seguin", "FR", "1979-09-03", "Groupe Apicil", "FRA 13", "foils", 2,
  "Kojiro", "Shiraishi", "JAP", "1967-05-08", "DMG Mori Global One", "JPN 11", "foils", 3,
  "Sébastien", "Simon", "FR", "1990-05-06", "Groupe Dubreuil", "FRA 112", "foils", 2,
  "Maxime", "Sorel", "FR", "1986-08-11", "V and B - Monbana-Mayenne", "FRA 53", "foils", 2,
  "Guirec", "Soudée", "FR", "1992-01-03", "Freelance.com", "FRA 22", "straight keels", 1,
  "Denis", "Van Weynbergh", "BEL", "1967-07-29", "D'Ieteren Group", "BEL 207", "straight keels", 1,
  "Szabolcs", "Weöres", "HUN", "1973-08-20", "New Europe", "HUN 23", "straight keels", 1,
  "Jingkun", "Xu", "CHI", "1989-09-09", "Singchain Team Haikou", "CHN 5", "foils", 1
  )

skippers <- tibble(
  name = c("Sam", "Sébastien", "Yoann", "Charlie", "Nicolas",
           "Thomas", "Jérémie", "Yannick", "Samantha", "Clarisse",
           "Justine", "Paul", "Jean", "Benjamin", "Damien",
           "Pip", "Boris", "Romain", "Isabelle", "Louis",
           "Sébastien", "Benjamin", "Eric", "Arnaud", "Louis",
           "Tanguy", "Giancarlo", "Conrad", "Violette", "Antoine",
           "Guirec", "Kojiro", "Alan", "Fabrice", "Manuel",
           "Oliver", "Denis", "Jingkun", "Szabolcs", "Maxime"),
  surname = c("Goodchild", "Simon", "Richomme", "Dalin", "Lunven",
              "Ruyant", "Beyou", "Bestaven", "Davies", "Crémer",
              "Mettraux", "Meilhat", "Le Cam", "Dutreux", "Séguin",
              "Hare", "Herrmann", "Attanasio", "Joschke", "Burton",
              "Marsset", "Ferré", "Bellion", "Boissières", "Duc",
              "Le Turquais", "Pedote", "Colman", "Dorange", "Cornic",
              "Soudée", "Shiraishi", "Roura", "Amedeo", "Cousin",
              "Heer", "Van Weynbergh", "Xu", "Weöres", "Sorel"),
  boat = c("VULNERABLE", "GROUPE DUBREUIL", "PAPREC ARKEA", "MACIF SANTE PREVOYANCE", "HOLCIM - PRB",
           "VULNERABLE", "CHARAL", "MAITRE COQ V", "INITIATIVES-COEUR", "L'OCCITANE EN PROVENCE",
           "TEAMWORK - TEAM SNEF", "BIOTHERM", "TOUT COMMENCE EN FINISTERE - ARMOR-LUX",
           "GUYOT ENVIRONNEMENT - WATER FAMILY", "GROUPE APICIL", "MEDALLIA", "MALIZIA - SEA EXPLORER",
           "FORTINET - BEST WESTERN", "MACSF", "BUREAU VALLEE", "FOUSSIER", "MONNOYEUR - DUO FOR A JOB",
           "STAND AS ONE - ALTAVIA", "LA MIE CALINE", "FIVES GROUP - LANTANA ENVIRONNEMENT", "LAZARE",
           "PRYSMIAN", "MS AMLIN", "DEVENIR", "HUMAN IMMOBILIER", "FREELANCE.COM", "DMG MORI GLOBAL ONE",
           "HUBLOT", "NEXANS - WEWISE", "COUP DE POUCE", "TUT GUT", "D'IETEREN GROUP", "SINGCHAIN TEAM HAIKOU",
           "NEW EUROPE", "V AND B - MONBANA - MAYENNE"),
  nat = c("GBR", rep("FRA", 7), "GBR", "FRA", "SUI", rep("FRA", 4), "GBR", "GER", rep("FRA", 9),
          "ITA", "NZL", rep("FRA", 3), "JPN", "SUI", "FRA", "FRA", "SUI", "BEL", "CHN", "HUN", "FRA"),
  sail = c("FRA 100", "FRA 112", "FRA 24", "FRA 79", "FRA85", "FRA 59", "FRA 3", "FRA 17", "FRA 109", "FRA 15", "FRA 08",
           "FRA 2030", "FRA 29", "FRA 09", "FRA 13", "GBR 777", "MON 1297", "FRA 10", "FRA 27", "FRA 18", "FRA 83", "FRA 30",
           "FRA 5", "FRA 14", "FRA 172", "FRA 1000", "ITA 34", "NZL 64", "FRA 01", "FRA 1461", "FRA 22", "JPN 11", "SUI 7",
           "FRA 56", "FRA 71", "SUI 49", "BEL 207", "CHN 5", "HUN 23", "FRA 53"))

# 💾 Save dataset ---------------------------------------------------------

write_csv(x = skippers, file = "03-DATA_PROCESSED/skippers.csv")
write_csv(x = skippers2, file = "03-DATA_PROCESSED/skippers2.csv")
