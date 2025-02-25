# 📦 Load packages --------------------------------------------------------

library(tidyverse)
library(readxl)
library(parzer)

# ⬇️ Import skippers dataset ----------------------------------------------

skippers <- read_csv("03-DATA_PROCESSED/skippers.csv")

# ⬇️ Get data and clean (up to Dalin's arrival) ---------------------------

paths <- list.files(path = "01-DATA_RAW/", full.names = T, pattern = "*.xlsx")
paths <- paths[1:383]

all_files <- tibble(path = paths) |> 
  separate(col = path, into = c("dir", "file"), sep = "/", remove = FALSE) |> 
  select(-dir) |> 
  mutate(date_time = str_remove_all(string = file, pattern = "vendeeglobe_leaderboard_"),
         date_time = str_remove_all(string = date_time, pattern = ".xlsx")) |> 
  separate(col = date_time, into = c("date", "time"), sep = "_") |> 
  select(-file) |> 
  arrange(date, time)

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

all_data <- all_data |> 
  mutate(datetime = as_datetime(paste0(date, time)),
         .before = date, .keep = "unused") |> 
  select(-hour_FR) |> 
  mutate(sail = case_when(sail == "FRA85" ~ "FRA 85",
                          .default = sail)) |> 
  mutate(across(.cols = ends_with("heading_deg"),
                .fns = ~ str_remove_all(string = .x, pattern = "°")),
         across(.cols = ends_with(c("speed_kts", "VMG_kts")),
                .fns = ~ str_remove_all(string = .x, pattern = " kts")),
         across(.cols = contains("distance_"),
                .fns = ~ str_remove_all(string = .x, pattern = " nm")),
         across(.cols = last30min_heading_deg:distance_to_leader_nm,
                .fns = ~ as.numeric(.x)),
         across(.cols = c(rank:sail),
                .fns = ~ as_factor(.x))) |> 
  mutate(lat = parzer::parse_lat(lat_deg), .after = lat_deg) |>
  mutate(lon = parzer::parse_lon(lon_deg), .after = lon_deg) |> 
  mutate(lat = case_when(is.na(lat_deg) ~ NA,
                         .default = lat)) |> 
  mutate(lon = case_when(is.na(lon_deg) ~ NA,
                         .default = lon))

# Export the dataset

write_csv(x = all_data, file = "03-DATA_PROCESSED/standings_to_20250224_220000.csv")

# ⬇️ Get and clean data from Dalin's arrival to 2025-02-24 ----------------



# Dalin : 2025_01_14 08:24:49 (paths[1] -> paths[383])
# Richomme : 2025_01_15 07:21:02 (paths[384] -> )
# 2025-02-24 : paths[626]


paths <- list.files(path = "01-DATA_RAW/", full.names = T, pattern = "*.xlsx")
paths <- paths[384:626]

all_files <- tibble(path = paths) |> 
  separate(col = path, into = c("dir", "file"), sep = "/", remove = FALSE) |> 
  select(-dir) |> 
  mutate(date_time = str_remove_all(string = file, pattern = "vendeeglobe_leaderboard_"),
         date_time = str_remove_all(string = date_time, pattern = ".xlsx")) |> 
  separate(col = date_time, into = c("date", "time"), sep = "_") |> 
  select(-file) |> 
  arrange(date, time)

# all_files |> 
#   mutate(datetime = as_datetime(date, time))
#   mutate(sheet_range = case_when(date <= 20250113 ~ "B6:U45",
#                                  .default = NA))

all_data <- list()

ok_val <- c(1:40, "RET")

for (i in 1:nrow(all_files)) {
  
  df <- readxl::read_xlsx(all_files$path[i], 
                          range = "B6:U47", col_names = FALSE) |> 
    filter(...1 %in% ok_val)
  
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

all_data <- all_data |> 
  mutate(datetime = as_datetime(paste0(date, time)),
         .before = date, .keep = "unused") |> 
  select(-hour_FR) |> 
  mutate(sail = case_when(sail == "FRA85" ~ "FRA 85",
                          .default = sail)) |> 
  mutate(across(.cols = ends_with("heading_deg"),
                .fns = ~ str_remove_all(string = .x, pattern = "°")),
         across(.cols = ends_with(c("speed_kts", "VMG_kts")),
                .fns = ~ str_remove_all(string = .x, pattern = " kts")),
         across(.cols = contains("distance_"),
                .fns = ~ str_remove_all(string = .x, pattern = " nm")),
         across(.cols = last30min_heading_deg:distance_to_leader_nm,
                .fns = ~ as.numeric(.x)),
         across(.cols = c(rank:sail),
                .fns = ~ as_factor(.x))) |> 
  mutate(lat = parzer::parse_lat(lat_deg), .after = lat_deg) |>
  mutate(lon = parzer::parse_lon(lon_deg), .after = lon_deg) |> 
  mutate(lat = case_when(is.na(lat_deg) ~ NA,
                         .default = lat)) |> 
  mutate(lon = case_when(is.na(lon_deg) ~ NA,
                         .default = lon))

# Read first dataset
d1 <- read_csv("03-DATA_PROCESSED/standings_to_20250114060000.csv")

# Combine both datasets
full_data <- bind_rows(d1, all_data)

# Export the dataset

write_csv(x = full_data, file = "03-DATA_PROCESSED/standings_to_20250224_220000.csv")

# ⬇️ Add latest standings -------------------------------------------------

paths <- list.files(path = "01-DATA_RAW/", full.names = T, pattern = "*.xlsx")

# 2025-02-24 : paths[626]

paths <- paths[627:length(paths)]

all_files <- tibble(path = paths) |> 
  separate(col = path, into = c("dir", "file"), sep = "/", remove = FALSE) |> 
  select(-dir) |> 
  mutate(date_time = str_remove_all(string = file, pattern = "vendeeglobe_leaderboard_"),
         date_time = str_remove_all(string = date_time, pattern = ".xlsx")) |> 
  separate(col = date_time, into = c("date", "time"), sep = "_") |> 
  select(-file) |> 
  arrange(date, time)

# all_files |> 
#   mutate(datetime = as_datetime(date, time))
#   mutate(sheet_range = case_when(date <= 20250113 ~ "B6:U45",
#                                  .default = NA))

all_data <- list()

ok_val <- c(1:40, "RET")

for (i in 1:nrow(all_files)) {
  
  df <- readxl::read_xlsx(all_files$path[i], 
                          range = "B6:U47", col_names = FALSE) |> 
    filter(...1 %in% ok_val)
  
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

all_data <- all_data |> 
  mutate(datetime = as_datetime(paste0(date, time)),
         .before = date, .keep = "unused") |> 
  select(-hour_FR) |> 
  mutate(sail = case_when(sail == "FRA85" ~ "FRA 85",
                          .default = sail)) |> 
  mutate(across(.cols = ends_with("heading_deg"),
                .fns = ~ str_remove_all(string = .x, pattern = "°")),
         across(.cols = ends_with(c("speed_kts", "VMG_kts")),
                .fns = ~ str_remove_all(string = .x, pattern = " kts")),
         across(.cols = contains("distance_"),
                .fns = ~ str_remove_all(string = .x, pattern = " nm")),
         across(.cols = last30min_heading_deg:distance_to_leader_nm,
                .fns = ~ as.numeric(.x)),
         across(.cols = c(rank:sail),
                .fns = ~ as_factor(.x))) |> 
  mutate(lat = parzer::parse_lat(lat_deg), .after = lat_deg) |>
  mutate(lon = parzer::parse_lon(lon_deg), .after = lon_deg) |> 
  mutate(lat = case_when(is.na(lat_deg) ~ NA,
                         .default = lat)) |> 
  mutate(lon = case_when(is.na(lon_deg) ~ NA,
                         .default = lon))

# Read existing standings dataset
d1 <- read_csv("03-DATA_PROCESSED/standings_to_20250224_220000.csv")

# Combine both datasets
full_data <- bind_rows(d1, all_data)

# Export the dataset

write_csv(x = full_data, file = "03-DATA_PROCESSED/standings_to_20250225_100000.csv")
