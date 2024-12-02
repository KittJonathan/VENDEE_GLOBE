# Download files

# df <- tibble(date = c(rep("20241129", 4), rep("20241130", 6), rep("20241201", 6), rep("20241202", 2)),
#        time = c("100000", "140000", "180000", "220000",
#                 "020000", "060000", "100000", "140000", "180000", "220000",
#                 "020000", "060000", "100000", "140000", "180000", "220000",
#                 "020000", "060000"))

# df <- df |> 
#   mutate(url = paste0("https://www.vendeeglobe.org/sites/default/files/ranking/vendeeglobe_leaderboard_",
#                       date, "_", time, ".xlsx"),
#          path = paste0("01-DATA_RAW/vendeeglobe_leaderboard_", date, "_", time, ".xlsx"))

# for (i in 1:nrow(df)) {
#   
#   download.file(url = df$url[i],
#                 destfile = df$path[i],
#                 mode = "wb")
#   
# }

date <- "20241202"
time <- "100000"

url <- paste0("https://www.vendeeglobe.org/sites/default/files/ranking/vendeeglobe_leaderboard_",
              date, "_", time, ".xlsx")

download.file(url = url,
              destfile = paste0("01-DATA_RAW/vendeeglobe_leaderboard_", date, "_", time, ".xlsx"),
              mode = "wb")

df <- readxl::read_xlsx("01-DATA_RAW/vendeeglobe_leaderboard_20241113_100000.xlsx", 
                        range = "B6:U45", col_names = FALSE)
