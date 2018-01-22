options(java.home="C:\\Program Files\\Java\\jre1.8.0_144\\")
library(xlsx)
df<-read.xlsx('Quiz1_Q3',1)
dat<-df[18:23,7:15]
sum(dat$Zip*dat$Ext,na.rm=T)
