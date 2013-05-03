percentileRank <- function(x) {
  result <- rank(x) / length(x)
  return (result)
}