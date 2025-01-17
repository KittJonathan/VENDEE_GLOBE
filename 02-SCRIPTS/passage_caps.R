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


write_csv(x = times_equator_1, file = "04-RESULTS/times_equator_1.csv")

# Temps de passage au Cap de Bonne Esperance
# https://www.vendeeglobe.org/article/les-temps-de-passage-au-cap-de-bonne-esperance

times_good_hope <- tibble(
  surname = c( "Dalin", "Ruyant", "Simon", "Richomme", "Beyou", "Lunven",
               "Goodchild", "Bestaven", "Meilhat", "Davies", "Mettraux",
               "Herrmann", "Crémer", "Dutreux", "Attanasio", "Burton", "Hare",
               "Séguin", "Joschke", "Le Cam", "Roura", "Le Turquais", "Ferré",
               "Pedote", "Boissières", "Dorange", "Marsset", "Soudée", "Duc",
               "Bellion", "Shiraishi", "Colman", "Heer", "Cornic",  "Cousin",
              "Amedeo", "Van Weynbergh", "Xu"),
  equator = c(duration("19d 3H 43M 2S"), duration("19d 5H 53M 21S"),
              duration("19d 6H 40M 10S"), duration("19d 07H 01M 02S"),
              duration("19d 12H 17M 56S"), duration("19d 13H 14M 01S"),
              duration("19d 17H 20M 01S"), duration("20d 00H 21M 18S"),
              duration("20d 05H 18M 34S"), duration("21d 21H 24M 01S"),
              duration("22d 02H 14M 17S"), duration("22d 02H 31M 00S"),
              duration("22d 05H 14M 56S"), duration("22d 17H 54M 32S"),
              duration("22d 18H 56M 02S"), duration("23d 04H 07M 02S"),
              duration("23d 12H 53M 02S"), duration("23d 16H 07M 53S"),
              duration("24d 10H 46M 14S"), duration("24d 12H 02M 05S"),
              duration("24d 16H 05M 06S"), duration("24d 19H 15M 38S"),
              duration("24d 19H 59M 22S"), duration("24d 22H 22M 35S"),
              duration("25d 00H 03M 41S"), duration("25d 01H 02M 44S"),
              duration("25d 03H 13M 26S"), duration("25d 09H 05M 33S"),
              duration("25d 09H 21M 30S"), duration("25d 15H 02M 43S"),
              duration("25d 17H 34M 33S"), duration("25d 19H 05M 02S"),
              duration("26d 04H 57M 34S"), duration("26d 07H 55M 09S"),
              duration("27d 19H 17M 19S"), duration("28d 06H 14M 46S"),
              duration("28d 10H 17M 20S"), duration("29d 02H 38M 45S")),
  datetime = c("2024-11-29 15:45:02", "2024-11-29 17:55:21", "2024-11-29 18:42:10",
               "2024-11-29 19:03:02", "2024-11-30 00:19:56", "2024-11-30 01:16:01",
               "2024-11-30 05:22:01", "2024-11-30 12:23:18", "2024-11-30 17:20:34",
               "2024-12-02 09:26:01", "2024-12-02 14:16:17", "2024-12-02 14:33:00",
               "2024-12-02 17:16:56", "2024-12-03 05:56:32", "2024-12-03 06:58:02",
               "2024-12-03 16:09:02", "2024-12-04 00:55:02", "2024-12-04 04:09:53",
               "2024-12-04 22:48:14", "2024-12-05 00:04:05", "2024-12-05 04:07:06",
               "2024-12-05 07:17:38", "2024-12-05 08:01:22", "2024-12-05 10:24:35",
               "2024-12-05 12:05:41", "2024-12-05 13:04:44", "2024-12-05 15:15:26",
               "2024-12-05 21:07:33", "2024-12-05 21:23:30", "2024-12-06 03:04:43",
               "2024-12-06 05:36:33", "2024-12-06 07:07:02", "2024-12-06 16:59:34",
               "2024-12-06 19:57:09", "2024-12-08 07:19:19", "2024-12-08 18:16:46",
               "2024-12-08 22:19:20", "2024-12-09 14:40:45")
  )

write_csv(x = times_good_hope, file = "04-RESULTS/times_good_hope.csv")

# Temps de passage au Cap Leeuwin
# https://www.vendeeglobe.org/article/tous-les-temps-de-passage-au-cap-leeuwin

times_leeuwin <- tribble(
  ~surname, ~duration, ~datetime,
  "Dalin", "29d 02H 10M 58S", "2024-12-09 14:12:58",
  "Simon", "29d 13H 22M 18S", "2024-12-10 01:24:18",
  "Richomme", "30d 02H 11M 37S", "2024-12-10 14:13:37",
  "Ruyant", "30d 10H 14M 27S", "2024-12-10 22:16:27",
  "Beyou", "30d 22H 11M 14S", "2024-12-11 10:13:14",
  "Lunven", "30d 23H 03M 03S", "2024-12-11 11:05:03",
  "Goodchild", "31d 06H 42M 58S", "2024-12-11 18:44:58",
  "Meilhat", "31d 10H 11M 05S", "2024-12-11 22:13:05",
  "Bestaven", "31d 11H 20M 31S", "2024-12-11 23:22:31",
  "Herrmann", "32d 04H 20M 54S", "2024-12-12 16:22:54",
  "Mettraux", "32d 07H 48M 57S", "2024-12-12 19:50:57",
  "Cremer", "32d 15H 00M 57S", "2024-12-13 03:02:57",
  "Davies", "32d 15H 27M 35S", "2024-12-13 03:29:35",
  "Dutreux", "33d 14H 48M 10S", "2024-12-14 02:50:10",
  "Attanasio", "33d 22H 32M 05S", "2024-12-14 10:34:05",
  "Hare", "33d 23H 18M 25S", "2024-12-14 11:20:25",
  "Seguin", "35d 08H 05M 24S", "2024-12-15 20:07:24",
  "Le Cam", "36d 17H 45M 01S", "2024-12-17 05:47:01",
  "Joschke", "36d 18H 13M 23S", "2024-12-17 06:15:32",
  "Pedote", "36d 19H 53M 32S", "2024-12-17 07:55:32",
  "Roura", "36d 20H 10M 18S", "2024-12-17 08:12:18",
  "Le Turquais", "36d 23H 44M 02S", "2024-12-17 11:46:02",
  "Ferre", "37d 00H 32M 25S", "2024-12-17 12:34:25",
  "Marsset", "37d 18H 47M 24S", "2024-12-18 06:49:24",
  "Duc", "37d 20H 19M 39S", "2024-12-18 08:21:39",
  "Dorange", "37d 23H 53M 45S", "2024-12-18 11:55:45",
  "Colman", "38d 07H 36M 45S", "2024-12-18 19:38:45",
  "Bellion", "38d 10H 04M 02S", "2024-12-18 22:06:02",
  "Boissieres", "38d 12H 44M 19S", "2024-12-19 00:46:19",
  "Soudee", "39d 16H 11M 29S", "2024-12-20 04:13:29",
  "Shiraishi", "39d 20H 39M 55S", "2024-12-20 08:41:55",
  "Heer", "40d 09H 41M 14S", "2024-12-20 21:43:14",
  "Cornic", "41d 13H 49M 19S", "2024-12-22 01:51:19",
  "Xu", "43d 09H 24M 34S", "2024-12-23 21:26:34",
  "Cousin", "44d 03H 34M 02S", "2024-12-24 15:36:02",
  "Amedeo", "44d 05H 11M 05S", "2024-12-24 17:13:05",
  "Van Weynbergh", "45d 15H 59M 36S", "2024-12-26 06:00:36"
)

times_leeuwin

write_csv(x = times_leeuwin, file = "04-RESULTS/times_leeuwin.csv")

# Temps de passage au Cap Horn
# https://www.vendeeglobe.org/article/tous-les-temps-de-passage-au-cap-horn

# Temps de passage a l'Equateur (retour)

times_equator_2 <- tribble(
  ~surname, ~duration, ~datetime,
  "Dalin", "56d 02H 36M 23S", "2025-01-05 14:38:23",
  "Richomme", "56d 10H 27M 01S", "2025-01-05 22:29:01",
  "Simon", "57d 18H 06M 19S", "2025-01-07 06:08:19",
  "Goodchild", "63d 11H 17M 16S", "2025-01-12 23:19:16",
  "Beyou", "63d 11H 20M 55S", "2025-01-12 23:22:55",
  "Meilhat", "63d 13H 59M 39S", "2025-01-13 02:01:39",
  "Lunven", "64d 02H 15M 54S", "2025-01-13 14:17:54",
  "Ruyant", "64d 07H 52M 48S", "2025-01-13 19:54:48",
  "Herrmann", "64d 11H 30M 30S", "2025-01-13 23:32:30",
  "Mettraux", "64d 14H 48M 24S", "2025-01-14 02:50:24",
  "Dutreux", "65d 19H 11M 36S", "2025-01-15 07:13:36",
  "Crémer", "65d 19H 19M 16S", "2025-01-15 07:21:16",
  "Davies", "65d 23H 29M 59S", "2025-01-15 11:31:59"
)

write_csv(x = times_equator_2, file = "04-RESULTS/times_equator_2.csv")


# Arrivee 

arrival <- tibble(
  surname = c("Dalin", "Richomme", "Simon"),
  date = c("2025-01-14", "2025-01-15", "2025-01-17"),
  time = c("08:24:49", "07:12:02", "01:27:37"),
  duration = c(duration("64d 19H 22M 49S"), duration("65d 18H 10M 2S"),
               duration("67d 12H 25M 37S"))
)

write_csv(x = arrival, file = "04-RESULTS/arrival.csv")
