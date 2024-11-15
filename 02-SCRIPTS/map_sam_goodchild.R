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

# ⬇️ Get data and clean ---------------------------------------------------

sam_data <- list()

for (i in 1:nrow(all_files)) {
  
  #i <- 1
  
  df <- readxl::read_xlsx(all_files$path[i], 
                          range = "B6:U45", col_names = FALSE)
  
  names(df) <- c("Rank", "Nat_Sail", "Skipper", "Hour_FR", "Latitude", "Longitude",
                 "Last30min_heading", "Last30min_speed", "Last30min_VMG", "Last30min_distance",
                 "SinceLastStandings_heading", "SinceLastStandings_speed", "SinceLastStandings_VMG",
                 "SinceLastStandings_distance", "Last24hrs_heading", "Last24hrs_speed", 
                 "Last24hrs_VMG", "Last24hrs_distance", "Distance_to_finish", "Distance_to_leader")
  
  sam_data[[i]] <- df |> 
    filter(Nat_Sail == "GBRFRA 100") |> 
    select(Latitude, Longitude, Distance_to_finish) |> 
    mutate(lon = parzer::parse_lon(Longitude),
           lat = parzer::parse_lat(Latitude)) |> 
    select(lon, lat, Distance_to_finish) |> 
    mutate(Distance_to_finish = str_remove(string = Distance_to_finish, pattern = " nm"))
  

}

sam <- bind_rows(sam_data)

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
