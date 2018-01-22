Course Project
================
Pat Mitoraj
December 17, 2017

### Course Project

Executive Summary
-----------------

Examining data from the mtcars dataset, their does not appear to be a statistically significan relationship between transmission type and a car's average miles per gallon. While manual transmission cars have a higher miles per gallon on average, once car weight and engine cylinders are accounted for there is not a statistical difference betwee automatic and manual transmission cars.

Exploratory Analysis
--------------------

Exploratory analysis was done to investigate the realtionships bnetween several of the variables in the dataset. First, the relationship between transmission type and miles per gallon was plotted. \`\`\`(r){ library(dplyr) mtcars&lt;-mtcars %&gt;% mutate(transmission = ifelse(am == 1,"Manual","Automatic")) mtcars g&lt;-ggplot(mtcars,aes(transmission,mpg))+geom\_point(color="firebrick") g+ggtitle("Miles Per Gallon vs Transmission Type")+labs(x="Transmission Type",y="Miles Per Gallon") }
