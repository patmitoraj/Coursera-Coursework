setwd("~/R Programming Course/Developing Data Products")
df<-read.csv("CollegeEnrollPersist_2017_SchoolLevel.csv",header=TRUE)
head(df)
colnames(df)
library(leaflet)
pal <- colorNumeric(
  palette = colorRampPalette(c('red', 'green'))(length(df$X2016.College.Enrollment.Rate)), 
  domain = df$X2016.College.Enrollment.Rate)
myMap<-leaflet(data=df) %>%
  addTiles () %>%
  addCircles (lng=df$Longitude,lat=df$Latitude, 
              popup=paste(df$School.Name,"<br>",df$X2016.College.Enrollment.Rate,"% of 2016 graduates enrolled in 2 or 4 year college")
              ,color = ~pal(X2016.College.Enrollment.Rate),
              radius= 500,
              weight=2) %>%
addLegend("bottomright", pal = pal, values = ~X2016.College.Enrollment.Rate,
          title = "College Enrollment Rate",
          labFormat = labelFormat(suffix = "%"),
          opacity = 1
)
myMap
