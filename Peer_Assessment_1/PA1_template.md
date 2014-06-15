## Assigment 1

# load library and file


```r
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 3.0.3
```

```r
library(chron)
```

```
## Warning: package 'chron' was built under R version 3.0.3
```

```r
library(scales)
```

```
## Warning: package 'scales' was built under R version 3.0.3
```

```r
library(reshape2)
```

```
## Warning: package 'reshape2' was built under R version 3.0.3
```

```r
# load datas 
files<-read.csv("activity.csv")
```

# transform data


```r
files$date <- as.Date(files$date, format = "%Y-%m-%d")

# remove the na data and select the columns and put all in a new variable

daily_steps<-tapply(files$steps,files$date,sum,na.rm=TRUE)
```


