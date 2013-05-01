require(data.table)

# Convert to a data.table
data <- data.table(ncaa.hockey.scoreboard.1999.2013)

# Convert date column to Date type and sort
data$date <- as.Date(data$date)
data <- data[order(data$date),]

# Exclude exhibition games
data <- data[data$conference != "EX",]

# Get a list of all teams that played conference games. This should be all
# the D-I schools
all.teams <- data[data$conference != "NC", list(host, visitor)]
all.teams <- sort(unique(c(all.teams$host, all.teams$visitor)))

# Exclude games involving non-D-I schools
data <- data[data$host %in% all.teams & data$visitor %in% all.teams,]

# Rename "Quinnipiac College" to "Quinnipiac"
data$host[data$host == "Quinnipiac College"] <- "Quinnipiac"
data$visitor[data$visitor == "Quinnipiac College"] <- "Quinnipiac"

host.data <- data[, list(games = length(date),
                         goals.for = mean(host.score), 
                         goals.against = mean(visitor.score),
                         win.pct = mean((host.score > visitor.score) + 0.5 * (host.score == visitor.score))),
                  by = list(season = season, team = host)]

visitor.data <- data[, list(games = length(date),
                         goals.for = mean(visitor.score),
                         goals.against = mean(host.score),
                         win.pct = mean((visitor.score > host.score) + 0.5 * (host.score == visitor.score))),
                  by = list(season = season, team = visitor)]

agg.data  <- merge(host.data, visitor.data, by = c("season", "team"), suffixes = c(".host", ".visitor"))
agg.data$games <- agg.data$games.host + agg.data$games.visitor
agg.data$win.pct <- ((agg.data$win.pct.host * agg.data$games.host +
                        agg.data$win.pct.visitor * agg.data$games.visitor) / 
                        agg.data$games)

# agg.data <- agg.data[agg.data$games >= 20,]
# 
agg.data$win.pct.adv <- agg.data$win.pct.host - agg.data$win.pct.visitor
agg.data$goals.for.adv <- agg.data$goals.for.host - agg.data$goals.for.visitor
agg.data$goals.against.adv <- agg.data$goals.against.host - agg.data$goals.against.visitor
agg.data$goal.diff.adv <- agg.data$goals.for.adv - agg.data$goals.against.adv

# correlations <- cor(adv.data[, list(winPct.total, winPct, goalsFor, goalsAgainst, goalDifferential)])