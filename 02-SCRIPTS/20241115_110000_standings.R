# 📦 Load packages --------------------------------------------------------

library(tidyverse)
library(readxl)
library(maps)
library(parzer)

# ⬇️ Import and clean data ------------------------------------------------

df <- readxl::read_xlsx(path = "01-DATA_RAW/vendeeglobe_leaderboard_20241115_100000.xlsx", 
                        range = "B6:U45", col_names = FALSE)

names(df) <- c("Rank", "Nat_Sail", "Skipper", "Hour_FR", "Latitude", "Longitude",
               "Last30min_heading", "Last30min_speed", "Last30min_VMG", "Last30min_distance",
               "SinceLastStandings_heading", "SinceLastStandings_speed", "SinceLastStandings_VMG",
               "SinceLastStandings_distance", "Last24hrs_heading", "Last24hrs_speed", 
               "Last24hrs_VMG", "Last24hrs_distance", "Distance_to_finish", "Distance_to_leader")

df <- df |> 
  select(Latitude, Longitude) |> 
  mutate(lon = parzer::parse_lon(Longitude),
         lat = parzer::parse_lat(Latitude))

# 🌍 Create map -----------------------------------------------------------

world <- map_data("world")

p <- ggplot() +
  geom_polygon(data = world, aes(x = long, y = lat, group = group),
               fill = "#384a89") +
  geom_point(data = df, aes(x = lon, y = lat),
             col = "white", size = 0.8) +
  coord_fixed(ratio = 1.3, xlim = c(-30, 5), ylim = c(25, 50)) +
  labs(title = "Vendée Globe 2024",
       subtitle = "2024-11-15") +
  theme_void() +
  theme(panel.background = element_rect(colour = "#485fb0",
                                        fill = "#485fb0"),
        plot.background = element_rect(colour = "#485fb0",
                                        fill = "#485fb0"),
        plot.title = element_text(colour = "white", hjust = 0.5, margin = margin(t = 5)),
        plot.subtitle = element_text(colour = "white", hjust = 0.5))

ggsave(filename = "04-MAPS/20241115_110000.png", plot = p, dpi = 320, width = 6, height = 6)
