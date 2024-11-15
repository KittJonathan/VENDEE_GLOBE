library(tidyverse)
library(readxl)
library(maps)
library(parzer)

df <- readxl::read_xlsx("01-DATA_RAW/vendeeglobe_leaderboard_20241115_060000.xlsx", 
                        range = "B6:U45", col_names = FALSE)

names(df) <- c("Rank", "Nat_Sail", "Skipper", "Hour_FR", "Latitude", "Longitude",
               "Last30min_heading", "Last30min_speed", "Last30min_VMG", "Last30min_distance",
               "SinceLastStandings_heading", "SinceLastStandings_speed", "SinceLastStandings_VMG",
               "SinceLastStandings_distance", "Last24hrs_heading", "Last24hrs_speed", 
               "Last24hrs_VMG", "Last24hrs_distance", "Distance_to_finish", "Distance_to_leader")

df <- df |> 
  mutate(lon = parzer::parse_lon(Longitude),
         lat = parzer::parse_lat(Latitude))

world <- map_data("world")



ggplot() +
  geom_polygon(data = world, aes(x = long, y = lat, group = group),
               fill = "#afcfdf") +
  geom_point(data = df, aes(x = lon, y = lat),
             col = "#f4f0f0") +
  coord_fixed(ratio = 1.3, xlim = c(-26, -12), ylim = c(25, 36)) +
  theme_void() +
  theme(panel.background = element_rect(colour = "#485fb0",
                                        fill = "#485fb0"))
