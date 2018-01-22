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
subsetNEI <- NEISCC[(NEISCC$fips=="24510"|NEISCC$fips=="06037") & NEISCC$type=="ON-ROAD",  ]
aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"
png("plot6.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab("Total Emissions (Tons)")
  ggtitle("Total Emissions from motor vehicles in Baltimore City vs Los Angeles, CA 1999-2008")
print(g)
dev.off()