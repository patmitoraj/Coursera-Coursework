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
new_df<-df[df$fips=="24510",]
head(new_df)
totals<-aggregate( new_df$Emissions ~ new_df$year, FUN = sum )
png(filename="./Plot2.png")
barplot(totals$`new_df$Emissions`,names.arg = totals$`new_df$year`, main="Total PM2.5 Emissions by Year for Baltimore City",ylab="Amount of PM2.5 Emitted (tons)", xlab="Year")
dev.off()
