# 📦 Load packages --------------------------------------------------------

library(tidyverse)
library(readxl)
library(maps)
library(parzer)


# ⬇️ Import the dataset ---------------------------------------------------

df <- read_csv("03-DATA_PROCESSED/clean_data.csv")

# 🌍 Create map -----------------------------------------------------------

sam <- df |> 
  filter(Surname == "Goodchild") |> 
  mutate(lon = parzer::parse_lon(Longitude),
         lat = parzer::parse_lat(Latitude))

world <- map_data("world")

p <- ggplot() +
  geom_polygon(data = world, aes(x = long, y = lat, group = group),
               fill = "#afcfdf") +
  geom_point(data = sam, aes(x = lon, y = lat),
             col = "white", size = 0.5) +
  coord_fixed(ratio = 1.3, xlim = c(-32, 5), ylim = c(6, 50)) +
  labs(title = "Vendée Globe 2024",
       subtitle = "Sam Goodchild") +
  theme_void() +
  theme(panel.background = element_rect(colour = "#485fb0",
                                        fill = "#485fb0"),
        plot.background = element_rect(colour = "#485fb0",
                                        fill = "#485fb0"),
        plot.title = element_text(colour = "white"),
        plot.subtitle = element_text(colour = "white"))

ggsave(filename = "04-MAPS/sam.png", plot = p, dpi = 320, width = 6, height = 6)
