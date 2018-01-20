if(!file.exists("./Quiz4")){dir.create("./Quiz4")}
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL,destfile="./Quiz4/Q1_Data.csv")
Q1data<-read.csv("./Quiz4/Q1_Data.csv")
names(Q1data)
splitnames=strsplit(names(Q1data),"wgtp")
splitnames

if(!file.exists("./Quiz4")){dir.create("./Quiz4")}
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
columnheaders<-c("CountryCode","Ranking","skipCol","Economy","GDP","skip2","skip3","skip4","skip5","skip6")
columnClasses<-c("factor","numeric","NULL","factor","factor","NULL","NULL","NULL","NULL","NULL")
download.file(fileURL,destfile="./Quiz4/Q2_Data.csv")
Q2data<-read.csv("./Quiz4/Q2_Data.csv",,skip=5,nrows=190,header = FALSE, sep = ",", col.names = columnheaders, colClasses =columnClasses)
names(Q2data)
head(Q2data)
gdp=as.numeric(gsub(",","",Q2data$GDP))
mean(gdp)
grep("^United",Q2data$Economy)
fileURL2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileURL2,destfile="./Quiz4/Q3_Data.csv")
edu<-read.csv("./Quiz4/Q3_Data.csv")
mergedData<-inner_join(Q2data,edu,by="CountryCode")
head(mergedData)
length(grep("Fiscal year end: June*",mergedData$Special.Notes))

install.packages("quantmod")
library(quantmod)
amzn<-getSymbols("AMZN",auto.assign=FALSE)
sampleTimes<-index(amzn)
sampleTimes<-format(sampleTimes,"%a %b %d %Y")
sampleTimes
length(grep("Mon(.*)2012",sampleTimes))
       
