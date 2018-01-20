if(!file.exists("./Project2")){dir.create("./Project2")}
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL,destfile="./Project2/ProjectData.zip")
zipF<-file.choose("./Project2/ProjectData.zip") 
outDir<-"./Project2"
unzip(zipF,exdir=outDir)
list.files("./Project2")
setwd("./Project2")
df<- readRDS("summarySCC_PM25.rds")
head(df)
df<-df[df$year==1999|df$year==2002|df$year==2005|df$year==2008,]
totals<-aggregate( df$Emissions ~ df$year, FUN = sum )
png(filename="./Plot1.png")
barplot(totals$`df$Emissions`,names.arg = totals$`df$year`, main="Total PM2.5 Emissions by Year",ylab="Amount of PM2.5 Emitted (tons)", xlab="Year")
dev.off()