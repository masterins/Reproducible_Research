
library(ggplot2)
library(chron)
library(scales)
library(reshape2)

# load datas 
files<-read.csv("activity.csv")

# transform de datos
files$date <- as.Date(files$date, format = "%Y-%m-%d")

# remove the na data and select the columns and put all in a new variable

daily_steps<-tapply(files$steps,files$date,sum,na.rm=TRUE)

# Get a graphic with the mean, median 
dsf<-data.frame(daily_steps)
final_mean<-mean(daily_steps)
final_median<-median(daily_steps)
final_result<-as.data.frame(c(final_mean,final_median))
names(final_result)<-"par"
final_result$cat<-factor(c("mean","median"))
# with the ggplot2 utility create a graphic histogram
g<-ggplot(dsf,aes(x=daily_steps))
g+geom_histogram(fill="blue",colour="darkblue",binwidth=3000)+
  labs(title = "Daily Steps")+
  scale_linetype_discrete(breaks=c("mean","median")) 
#save the new graphic and call this new graph is pd1steps
ggsave(filename="daily_steps.png",width=5,height=4)


