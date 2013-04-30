data <- data.table(read.csv("c:/users/elliot/documents/data/ncaa_hockey.csv"),
                   stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, "%m/%d/%Y")
data <- data[order(data$Date),]
data$Team1[data$Team1 == "Quinnipiac College"] <- "Quinnipiac"
data$Team2[data$Team2 == "Quinnipiac College"] <- "Quinnipiac"

data <- data[data$GameType != "EX" & data$Loc == "@",]

dateCounts <- data[, list(n = length(Team1)), by = list(Date)]

homeData <- data[, list(games = length(Date),
                        goalsFor = mean(Score2), 
                        goalsAgainst = mean(Score1),
                        winPct = mean((Score2 > Score1) + 0.5 * (Score2 == Score1))),
                 by = list(Team = Team2)]
roadData <- data[, list(games = length(Date),
                        goalsFor = mean(Score1),
                        goalsAgainst = mean(Score2),
                        winPct = mean((Score1 > Score2) + 0.5 * (Score1 == Score2))),
                 by = list(Team = Team1)]

comb.data  <- merge(homeData, roadData, by = "Team", suffixes = c(".home", ".road"))
comb.data$games <- comb.data$games.home + comb.data$games.road
comb.data$winPct.total <- (comb.data$winPct.home * comb.data$games.home +
                             comb.data$winPct.road * comb.data$games.road) / 
  (comb.data$games.home + comb.data$games.road)
comb.data <- comb.data[comb.data$games >= 20,]

adv.data <- data.table(team = comb.data$Team,
                       winPct.total = comb.data$winPct.total,
                       winPct = comb.data$winPct.home - comb.data$winPct.road,
                       goalsFor = comb.data$goalsFor.home - comb.data$goalsFor.road,
                       goalsAgainst = comb.data$goalsAgainst.home - comb.data$goalsAgainst.road)
adv.data$goalDifferential <- adv.data$goalsFor - adv.data$goalsAgainst

correlations <- cor(adv.data[, list(winPct.total, winPct, goalsFor, goalsAgainst, goalDifferential)])