if(!file.exists("./Project1")){dir.create("./Project1")}
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile="./Project1/ProjectData.zip")
zipF<-file.choose("./Project1/ProjectData.zip") 
outDir<-"./Project1"
unzip(zipF,exdir=outDir)
list.files("./Project1")
setwd("./Project1")
df<-read.table("household_power_consumption.txt",header=FALSE,skip = 66637,nrows=2881, sep=";")
head(df)
names(df)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
head(df)
png(filename="./Plot1.png")
hist(df$Global_active_power, xlab="Global Active Power(kilowatts)",main="Global Active Power",col="red1",axes=FALSE)
axis(side=1, at=c(0:6))
axis(side=2, at=seq(0, 1200, by=200))
dev.off()
