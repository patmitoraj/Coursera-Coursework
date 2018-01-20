library(xml)
fileUrl<-'http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
doc<-xmlTreeParse(fileUrl,useInternal=TRUE)
rootnode<-xmlRoot(doc)
xmlName(rootnode)
df<-xpathSApply(rootnode,"//zipcode",xmlValue)
a<-table(df)
a[names(a)==21231]
