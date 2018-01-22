if(!file.exists("./Project2")){dir.create("./Project2")}
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL,destfile="./Project2/ProjectData.zip")
zipF<-file.choose("./Project2/ProjectData.zip") 
outDir<-"./Project2"
unzip(zipF,exdir=outDir)
list.files("./Project2")
setwd("./Project2")
library(ggplot2)
df<- readRDS("summarySCC_PM25.rds")
classification<-readRDS("Source_Classification_Code.rds")
if(!exists("NEISCC")){
  NEISCC <- merge(df, classification, by="SCC")
}
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)
png("plot4.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()