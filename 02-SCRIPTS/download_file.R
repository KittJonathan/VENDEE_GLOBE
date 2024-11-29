# Download files

date <- "20241111"
time <- "020000"

url <- paste0("https://www.vendeeglobe.org/sites/default/files/ranking/vendeeglobe_leaderboard_",
              date, "_", time, ".xlsx")

download.file(url = url,
              destfile = paste0("01-DATA_RAW/vendeeglobe_leaderboard_", date, "_", time, ".xlsx"),
              mode = "wb")

df <- readxl::read_xlsx("01-DATA_RAW/vendeeglobe_leaderboard_20241113_100000.xlsx", 
                        range = "B6:U45", col_names = FALSE)
