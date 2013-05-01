require(data.table)
require(XML)

urlTemplate <- "http://www.uscho.com/scoreboard/division-i-men/%s/composite-schedule/"

seasons = 1999:2013
data = list()

for (i in 1:length(seasons)) {
  
  season = seasons[i]
  seasonString = sprintf("%d-%d", season-1, season)
  url <- sprintf(urlTemplate, seasonString)
  
  scoreboard.doc <- htmlParse(url)
  scoreboard.tabs <- readHTMLTable(scoreboard.doc, stringsAsFactors = FALSE)
  
  temp <- scoreboard.tabs[[1]]
  cur.data <- data.table(season = season,
                         date = as.Date(temp[,3], "%m/%d/%Y"),
                         visitor = temp[,5],
                         visitor.score = as.numeric(temp[,6]),
                         loc = temp[,7],
                         host = temp[,8],
                         host.score = as.numeric(temp[,9]),
                         ot = temp[,10],
                         tournament = temp[,11],
                         conference = temp[,12])
  
  minDate <- min(cur.data$date)
  maxDate <- max(cur.data$date)
  print(sprintf("%s Season: Game dates from %s to %s.", seasonString, minDate, maxDate))
  if (minDate < as.Date(sprintf("%d-07-01", season-1)) || maxDate > as.Date(sprintf("%s-06-30", season+1))) {
    print("Invalid dates. Ignoring season.")
  } else {
    data[[length(data)+1]] <- cur.data
  }
}

data <- do.call(rbind, data)

# Exclude exhibition games
data <- data[data$conference != "EX",]

# Exclude neutral site games
data <- data[data$loc == "@",]

# Exclude games with missing scores
data <- data[!is.na(data$host.score) & !is.na(data$visitor.score),]

write.csv(data, 
          sprintf("ncaa_hockey_scoreboard_%d_%d.csv", 
                  min(seasons), max(seasons)),
          row.names = FALSE)