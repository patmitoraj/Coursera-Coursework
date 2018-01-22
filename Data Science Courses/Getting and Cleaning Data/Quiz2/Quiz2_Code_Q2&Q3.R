acs<-read.csv("Quiz2_Doc")
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select distinct AGEP from acs")
