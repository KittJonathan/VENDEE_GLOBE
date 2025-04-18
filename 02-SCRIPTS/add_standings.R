# 📦 Load packages --------------------------------------------------------

library(tidyverse)
library(readxl)
library(parzer)

# ⌨️ Create function ------------------------------------------------------

dir = "01-DATA_RAW/"
old_file = "03-DATA_PROCESSED/standings.csv"
skippers = "03-DATA_PROCESSED/skippers.csv"

add_standings <- function(date = NULL, time = NULL, from = NULL, to = NULL,
                          dir, old_file, skippers) {
  
  if (!is.null(date) & !is.null(time)) {
    url <- paste0("https://www.vendeeglobe.org/sites/default/files/ranking/vendeeglobe_leaderboard_",
                  date, "_", time, ".xlsx")
    
    download.file(url = url,
                  destfile = paste0(dir, "vendeeglobe_leaderboard_", date, "_", time, ".xlsx"),
                  mode = "wb")
  }
  
  if (!is.null(date) & is.null(time)) {
    
    df <- tibble(date = rep(date, 6),
                 time = c("020000", "060000", "100000", "140000", "180000", "220000")) |> 
      mutate(url = paste0("https://www.vendeeglobe.org/sites/default/files/ranking/vendeeglobe_leaderboard_",
                          date, "_", time, ".xlsx"),
             path = paste0(dir, "vendeeglobe_leaderboard_", date, "_", time, ".xlsx"))
    
    for (i in 1:nrow(df)) {
      
        download.file(url = df$url[i],
                      destfile = df$path[i],
                      mode = "wb")
      }
  }
  
  if (is.null(date) & is.null(time) & !is.null(from) & !is.null(to)) {
    
    df <- tibble(date = rep(seq(from, to, 1), each = 6),
                 time = rep(c("020000", "060000", "100000", "140000", "180000", "220000"),
                            times = length(seq(from, to, 1)))) |> 
      mutate(url = paste0("https://www.vendeeglobe.org/sites/default/files/ranking/vendeeglobe_leaderboard_",
                          date, "_", time, ".xlsx"),
             path = paste0(dir, "vendeeglobe_leaderboard_", date, "_", time, ".xlsx"))
    
    for (i in 1:nrow(df)) {
      
      download.file(url = df$url[i],
                    destfile = df$path[i],
                    mode = "wb")
    }
    
  }
}

get_standings(date = "20250108", time = "020000", dir = "01-DATA_RAW/")
get_standings(date = "20250108", time = "060000", dir = "01-DATA_RAW/")
# get_standings(date = "20250108", time = "100000", dir = "01-DATA_RAW/")
# get_standings(date = "20250108", time = "140000", dir = "01-DATA_RAW/")
# get_standings(date = "20250108", time = "180000", dir = "01-DATA_RAW/")
# get_standings(date = "20250108", time = "220000", dir = "01-DATA_RAW/")

get_standings(from = "20250101", to = "20250105", dir = "01-DATA_RAW/")





date <- "20241202"
time <- "100000"

url <- paste0("https://www.vendeeglobe.org/sites/default/files/ranking/vendeeglobe_leaderboard_",
              date, "_", time, ".xlsx")

download.file(url = url,
              destfile = paste0("01-DATA_RAW/vendeeglobe_leaderboard_", date, "_", time, ".xlsx"),
              mode = "wb")

df <- readxl::read_xlsx("01-DATA_RAW/vendeeglobe_leaderboard_20241113_100000.xlsx", 
                        range = "B6:U45", col_names = FALSE)
