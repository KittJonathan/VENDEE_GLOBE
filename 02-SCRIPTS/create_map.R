# 📦 Load packages --------------------------------------------------------

library(tidyverse)
library(readxl)
library(maps)
library(parzer)


# ⬇️ Import the dataset ---------------------------------------------------

df <- read_csv("03-DATA_PROCESSED/clean_data.csv")

# 🌍 Create map -----------------------------------------------------------

top_five <- df |> 
  filter(Date == 20241120,
         Time == "060000",
         Rank %in% 1:5) |> 
  mutate(lon = parzer::parse_lon(Longitude),
         lat = parzer::parse_lat(Latitude))

# sam <- df |> 
#   filter(Surname == "Goodchild") |> 
#   mutate(lon = parzer::parse_lon(Longitude),
#          lat = parzer::parse_lat(Latitude))

# top5 <- df |> 
#   filter(Surname %in% top_five) |> 
#   mutate(lon = parzer::parse_lon(Longitude),
#          lat = parzer::parse_lat(Latitude))

world <- map_data("world")

p <- ggplot() +
  geom_polygon(data = world, aes(x = long, y = lat, group = group),
               fill = "#afcfdf") +
  geom_point(data = top_five, aes(x = lon, y = lat),
             col = "white", size = 0.5) +
  geom_text(aes(x = -25, y = 0), label = "Sam Goodchild") +
  coord_fixed(ratio = 1.3, xlim = c(-32, -5), ylim = c(0, 45)) +
  # labs(title = "Vendée Globe 2024",
  #      subtitle = "Sam Goodchild") +
  theme_void() +
  theme(panel.background = element_rect(colour = "#485fb0",
                                        fill = "#485fb0"),
        plot.background = element_rect(colour = "#485fb0",
                                        fill = "#485fb0"),
        plot.margin = margin(t = -50, r = -150),
        plot.title = element_text(colour = "white"),
        plot.subtitle = element_text(colour = "white"))

ggsave(filename = "04-MAPS/sam.png", plot = p, dpi = 320, width = 6, height = 6)

p <- ggplot() +
  geom_polygon(data = world, aes(x = long, y = lat, group = group),
               fill = "#afcfdf") +
  geom_point(data = top5, aes(x = lon, y = lat),
             col = "white", size = 0.5) +
  geom_text(aes(x = -25, y = 0), label = "Sam Goodchild") +
  coord_fixed(ratio = 1.3, xlim = c(-32, 20), ylim = c(0, 65)) +
  # labs(title = "Vendée Globe 2024",
  #      subtitle = "Sam Goodchild") +
  theme_void() +
  theme(panel.background = element_rect(colour = "#485fb0",
                                        fill = "#485fb0"),
        plot.background = element_rect(colour = "#485fb0",
                                       fill = "#485fb0"),
        plot.margin = margin(t = -50, r = -150),
        plot.title = element_text(colour = "white"),
        plot.subtitle = element_text(colour = "white"))
