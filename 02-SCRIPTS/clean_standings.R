# 📦 Load packages --------------------------------------------------------

library(tidyverse)
library(readxl)
library(parzer)

# ⌨️ Create function ------------------------------------------------------

dir = "01-DATA_RAW/"
old_file = "03-DATA_PROCESSED/standings.csv"
skippers = "03-DATA_PROCESSED/skippers.csv"
output <- NULL

add_standings <- function(dir, old_file = NULL, skippers, output = NULL) {
  
  paths <- list.files(path = "01-DATA_RAW/", full.names = T, pattern = "*.xlsx")
  
  skippers <- read_csv("03-DATA_PROCESSED/skippers.csv")
  
  all_files <- tibble(path = paths) |> 
    separate(col = path, into = c("dir", "file"), sep = "/", remove = FALSE) |> 
    select(-dir) |> 
    mutate(date_time = str_remove_all(string = file, pattern = "vendeeglobe_leaderboard_"),
           date_time = str_remove_all(string = date_time, pattern = ".xlsx")) |> 
    separate(col = date_time, into = c("date", "time"), sep = "_") |> 
    select(-file) |> 
    arrange(date, time)
  
  if (is.null(old_file)) {
    all_data <- list()
    
    for (i in 1:nrow(all_files)) {
      
      df <- readxl::read_xlsx(all_files$path[i], 
                              range = "B6:U45", col_names = FALSE)
      
      names(df) <- c("rank", "nat_sail", "skipper_boat", "hour_FR", "lat_deg", "lon_deg",
                     "last30min_heading_deg", "last30min_speed_kts", "last30min_VMG_kts", "last30min_distance_nm",
                     "since_last_standings_heading_deg", "since_last_standings_speed_kts", "since_last_standings_VMG_kts",
                     "since_last_standings_distance_nm", "last24hrs_heading_deg", "last24hrs_speed_kts", 
                     "last24hrs_VMG_kts", "last24hrs_distance_nm", "distance_to_finish_nm", "distance_to_leader_nm")
      
      all_data[[i]] <- df |> 
        mutate(nat = str_extract(string = nat_sail, pattern = "^.{3}"),
               sail = str_remove(string = nat_sail, pattern = "^.{3}"),
               .after = nat_sail) |> 
        left_join(skippers) |> 
        select(rank, nat, sail, surname, name, hour_FR:distance_to_leader_nm) |> 
        mutate(date = all_files$date[i],
               time = all_files$time[i],
               .before = rank)
      
    }
    
    all_data <- bind_rows(all_data)
  }
  
  if (!is.null(old_file)) {
    
    standings_old <- read_csv(old_file)
    
    all_files |> 
      mutate(date = as_date(date),
             time = paste(strwrap(time, width = 2), collapse = ":")) |>
      head()
  }
  
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
