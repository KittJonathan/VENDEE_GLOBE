# 📦 Load packages --------------------------------------------------------

library(tidyverse)
library(glue)
library(gt)

# ⬇️ Import the data ------------------------------------------------------


standings <- read_csv("03-DATA_PROCESSED/standings_to_20250225_100000.csv")

arrivals <- read_csv("04-RESULTS/arrivals.csv")

withdrawals <- read_csv("04-RESULTS/withdrawals.csv")

# 🧹 Clean the data -------------------------------------------------------

arrivals |> 
  separate(col = duration,
           into = c("days", "hours", "minutes", "seconds"),
           remove = FALSE) |> 
  mutate(across(.cols = days:seconds,
                .fns = ~parse_number(.x))) |> 
  mutate(duration = duration(duration),
         race_time = glue("{days} days {hours} hours {minutes} minutes {seconds} seconds")) |>
  select(surname, race_time) |> 
  gt()

standings |> 
  filter(datetime >= "2025-02-25 10:00:00") |> 
  drop_na() |> select(surname, name, distance_to_finish_nm)
