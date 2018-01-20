con<-url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode<-readLines(con)
htmlCode[10]
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

library(readr)

x <- read_fwf(
  file="http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for",   
  skip=4,
  fwf_widths(c(12, 7, 4, 9, 4, 9, 4, 9, 4)))
x
sum(x$x4)
sum(x$X3)
