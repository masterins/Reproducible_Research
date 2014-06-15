#0
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
mn<-mean(daily_steps)
md<-median(daily_steps)
mm<-as.data.frame(c(mn,md))
names(mm)<-"par"
mm$cat<-factor(c("mean","median")) #for the 2 vertical lines
dsf$Vertical_Lines<-factor(rep("1",61)) #artificial factor needed to make a legend

# with the ggplot2 utility create a graphic histogram
g<-ggplot(dsf,aes(x=daily_steps,linetype=Vertical_Lines))
g+geom_histogram(fill="orange",colour="darkblue",binwidth=3000)+
  labs(title = "Daily Steps")+
  geom_vline(data=mm,aes(xintercept=par,linetype=cat))+
  scale_linetype_discrete(breaks=c("mean","median")) #removes artificial factor from legend

#save the new graphic and call this new graph is pd1steps
ggsave(filename="p1dsteps.png",width=5,height=4)
