# Script used to create dataset with skippers and boats
# 2024-11-21


# 📦 Load packages --------------------------------------------------------

library(tidyverse)

# 📄 Create dataset -------------------------------------------------------

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
