
```
## Loading required package: ProjectTemplate
```

```
## Loading required package: testthat
```

```
## Loading project configuration
```

```
## Autoloading helper functions
```

```
## Running helper script: helpers.R
```

```
## Autoloading packages
```

```
## Loading package: reshape
```

```
## Loading required package: plyr
```

```
## Attaching package: 'reshape'
```

```
## The following object is masked from 'package:plyr':
## 
## rename, round_any
```

```
## Loading package: plyr
```

```
## Loading package: ggplot2
```

```
## Loading package: stringr
```

```
## Loading package: lubridate
```

```
## Attaching package: 'lubridate'
```

```
## The following object is masked from 'package:reshape':
## 
## stamp
```

```
## The following object is masked from 'package:plyr':
## 
## here
```

```
## Autoloading data
```

```
## Loading data set: ncaa.hockey.scoreboard.1999.2013
```

```
## Munging data
```

```
## Running preprocessing script: ncaa_hockey.R
```

```
## Loading required package: data.table
```

```
## Attaching package: 'data.table'
```

```
## The following object is masked from 'package:lubridate':
## 
## hour, mday, month, quarter, wday, week, yday, year
```


Home Ice Advantage in College Hockey
====================================

As a Cornell hockey fan, I've often heard Cornell's home rink, Lynah Rink, described as a tough place for opposing teams to play. Recently, I've started to wonder if that's actually true, and if so, what it means. Is Lynah a tough place to play because you have to play Cornell there, and they have typically had strong teams? Or does Cornell have  a particularly strong home ice advantage? More generally, does home ice advantage exist in college hockey, and if so, how is it characterized?

This is not intended as a very technical analysis. In fact, is as much an exercise in learning to scrape data from the web, use RStudio, and produce a report using R Markdown. But I hope to address a handful of questions about home ice advantage in college hockey. Specifically:
* How should home ice advantage be measured?
** Better winning percentage at home?
** More goals scored at home?
** Fewer goals allowed at home?
** Higher goal differential at home?
* Does home ice advantage exist?
* Is the overall level of home ice advantage across college hockey stable over time?
* Are individual teams' home ice advantages stable over time?

Measuring Home Ice Advantage
----------------------------

Does Home Ice Advantage Exist?
------------------------------

The answer to this question is a resounding YES! Over the past fifteen seasons (1998-2013), 86.6% of team-seasons experienced a higher goal differential at home than on the road. Over the entire fifteen year period, every single team has had a positive aggregate goal differential advantage.


```r
summary(cars)
```

```
##      speed           dist    
##  Min.   : 4.0   Min.   :  2  
##  1st Qu.:12.0   1st Qu.: 26  
##  Median :15.0   Median : 36  
##  Mean   :15.4   Mean   : 43  
##  3rd Qu.:19.0   3rd Qu.: 56  
##  Max.   :25.0   Max.   :120
```


You can also embed plots, for example:


```r
plot(cars)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


