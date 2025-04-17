# 📦 Load packages --------------------------------------------------------

library(tidyverse)

# ⬇️ Read the data --------------------------------------------------------

skippers <- read_csv("03-DATA_PROCESSED/skippers.csv")
skippers2 <- read_csv("03-DATA_PROCESSED/skippers2.csv")

standings <- read_csv("03-DATA_PROCESSED/standings.csv")

cape_01 <- read_csv("04-RESULTS/times_equator_1.csv")
cape_02 <- read_csv("04-RESULTS/times_good_hope.csv")
cape_03 <- read_csv("04-RESULTS/times_leeuwin.csv")
cape_04 <- read_csv("04-RESULTS/times_horn.csv")
cape_05 <- read_csv("04-RESULTS/times_equator_2.csv")

cape_01 |> 
  mutate(start = as_datetime("2024-11-10 12:02:00"),
         cape_estimation = as.duration(equator) + start)

cape_02 |> 
  mutate(start = as_datetime("2024-11-10 12:02:00"),
         cape_estimation = as.duration(equator) + start)

         