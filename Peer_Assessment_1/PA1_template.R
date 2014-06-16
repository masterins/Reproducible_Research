
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

print(final_mean)
print(final_median)

# average 5 minutes of steps
interval_number_final<-0:(nrow(files)-1)
interval_final<-factor(interval_number_final%%288)
int_mean<-tapply(files$steps,interval_final,mean,na.rm=TRUE)
dimnames(int_mean)[[1]]<-NULL  ##to avoid confusions
int_mean_final<-as.data.frame(int_mean)
point0<-as.character(files$date[1])
point1<-as.POSIXlt(point0)
lines<-dim(int_mean_final)[1]
int_mean_final$times<-as.POSIXct(seq.POSIXt(from=point1,by="5 min",length.out=lines))
graph<-ggplot(int_mean_final,aes(x=times,y=int_mean))
graph_final<-graph+labs(title = "Average steps on 5 minute of intervals")+
geom_point(size=1)+
geom_line(size=.5,col="black")+
labs(x="time",y="number of steps")+
ggsave(filename="average_steps_5_minutes.png",width=5,height=4)

print(max(int_mean_final$int_mean))

# no null effects or missing values
#exploratory analysis
print(table(is.na(files)))
print(table(is.na(files$steps)))
print(mean(is.na(files$steps)))

#change de files a new files2

files2<-files
nona<-which(is.na(files2$steps))
nona2<- nona%%288
files2$steps[nona]<-int_mean_final$int_mean[nona2]

# Get a graphic2 with the mean, median 
daily_steps<-tapply(files2$steps,files2$date,sum)
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
ggsave(filename="daily_steps_missing_values.png",width=5,height=4)



