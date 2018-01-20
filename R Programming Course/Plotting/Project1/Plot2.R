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
df$newdate <- strptime(as.character(df$Date), "%d/%m/%Y")
df$Date <- format(df$newdate, "%Y-%m-%d")
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$newtime <- as.POSIXct(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")
png(filename="./Plot2.png")
par("ps" = 11)
plot(df$newtime, df$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
