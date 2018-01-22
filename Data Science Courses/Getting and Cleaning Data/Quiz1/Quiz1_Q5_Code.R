DT<-fread("Quiz1_Q5")
system.time(mean(DT$pwgtp15,by=DT$SEX))
