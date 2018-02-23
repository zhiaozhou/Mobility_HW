#1
download.file('https://data.transportation.gov/api/views/jc5e-psbx/rows.csv?accessType=DOWNLOAD','weather.csv')
weather = read.csv('weather.csv')

#2
HW1 = read.csv('HW1_Dataset.csv')

#2.1
length(colnames(HW1))
colnames(HW1)

#2.2
unique(HW1$Segment_Length.mile.)/min(HW1$Actual_Speed.mph.)
unique(HW1$Segment_Length.mile.)/min(HW1$Historical_Speed.mph.)

#2.3
HW1$time = substr(HW1$Local_Time,12,13)
HW1$actual_time = HW1$Segment_Length.mile./HW1$Actual_Speed.mph.
aggregate(HW1$actual_time,list(HW1$time),var)

#2.4
HW1$historical_time = HW1$Segment_Length.mile./HW1$Historical_Speed.mph.
HW1$diff = HW1$actual_time - HW1$historical_time
HW1[HW1$diff == max(HW1$diff),]$Local_Time

Sys.setlocale('LC_TIME','C')
HW1$Local_Time = strptime(HW1$Local_Time, format="%m/%d/%Y %H:%M")
plot(HW1$Local_Time,HW1$diff, typ = 'p', col = 2, cex = 1,xlab = "Time interval", ylab = "Travel Time Difference", main = "Travel Time Difference Distribution")
legend("top", legend=c("Travel Time Difference"),col=2,pch=1, cex=0.8)

#2.5
reg1 = lm(HW1$actual_time ~ HW1$historical_time)
summary(reg1)
