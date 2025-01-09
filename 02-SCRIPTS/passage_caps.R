# Script used to create dataset with skippers and times
# 2024-12-18

# 📦 Load packages --------------------------------------------------------

library(tidyverse)

# ⬇️ Import skippers dataset ----------------------------------------------

skippers <- read_csv("03-DATA_PROCESSED/skippers.csv")

# 🌍 Add data -------------------------------------------------------------

# Temps de passage a l'Equateur
# https://www.vendeeglobe.org/article/les-temps-de-passage-lequateur-0

times_equator_1 <- tibble(
  surname = c("Ruyant", "Dalin",
              "Goodchild", "Lunven",
              "Richomme", "Beyou",
              "Simon", "Bestaven", "Meilhat", "Mettraux",
              "Crémer", "Hare", "Davies", "Herrmann", "Attanasio",
              "Dutreux", "Séguin", "Burton", "Joschke", "Bellion",
              "Dorange", "Le Cam", "Duc", "Le Turquais", "Ferré",
              "Boissières", "Shiraishi", "Marsset", "Pedote",
              "Soudée", "Cousin", "Colman", "Roura", "Cornic",
              "Amedeo", "Heer", "Van Weynbergh", "Xu", "Weöres"),
  equator = c(duration("11d 7H 8M 15S"), duration("11d 9H 3M 54S"),
              duration("11d 9H 45M 39S"), duration("11d 10H 58M 24S"),
              duration("11d 11H 12M 50S"), duration("11d 11H 17M 49S"),
              duration("11d 11H 25M 50S"), duration("11d 11H 35M 58S"),
              duration("11d 11H 41M 22S"), duration("11d 12H 7M 22S"),
              duration("11d 15H 19M 37S"), duration("11d 15H 47M 48S"),
              duration("11d 15H 59M 16S"), duration("11d 17H 42M 42S"),
              duration("11d 19H 46M 49S"), duration("11d 20H 8M 33S"),
              duration("12d 0H 27M 49S"), duration("12d 8H 57M 9S"),
              duration("12d 11H 50M 55S"), duration("12d 19H 5M 41S"),
              duration("12d 20H 15M 29S"), duration("12d 20H 52M 38S"),
              duration("12d 21H 20M 8S"), duration("12d 23H 16M 21S"),
              duration("13d 0H 5M 2S"), duration("13d 0H 5M 31S"),
              duration("13d 1H 49M 47S"), duration("13d 2H 11M 6S"),
              duration("13d 2H 19M 11S"), duration("13d 3H 34M 50S"),
              duration("13d 5H 32M 7S"), duration("13d 5H 41M 23S"),
              duration("13d 5H 41M 52S"), duration("13d 10H 38M 51S"),
              duration("13d 11H 14M 6S"), duration("13d 14H 18M 16S"),
              duration("13d 17H 10M 59S"), duration("14d 8H 42M 16S"),
              duration("18d 8H 47M 2S"))
)


write_csv(x = times_equator_1, file = "03-DATA_PROCESSED/times_equator_1.csv")
