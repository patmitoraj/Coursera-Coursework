install.packages("R.utils")
library(R.utils)
library(ggplot2)
library(plyr)
library(dplyr)
install.packages("tidyr")
library(tidyr)
setwd("./Documents/R Programming Course/Reproducible Research/Project2")
datafile<-bunzip2("repdata%2Fdata%2FStormData.csv.bz2",remove=FALSE)
df<-read.csv("repdata%2Fdata%2FStormData.csv")
newdf<-df %>% separate(BGN_DATE, c("BGN_DATE", "DROP"), " ")
newdf$DROP<-NULL
which(grepl("1/1/1996", newdf$BGN_DATE))
newdf2<-newdf[-c(1:249454),]
delete<-c("STATE__", "BGN_TIME", "TIME_ZONE","COUNTY","COUNTYNAME","STATE","END_DATE","END_TIME","COUNTY_END","COUNTYENDN","WFO","STATEOFFIC","ZONENAMES","LATITUDE","LONGITUDE","LATITUDE_E","LONGITUDE_","REMARKS")
newdf2<- newdf2[, !(names(newdf2) %in% delete)] 
newdf2$PROPDMGEXP<- mapvalues(newdf2$PROPDMGEXP, from = c("K", "M","", "B", "m", "+", "0", "5", "6", "?", "4", "2", "3", "h", "7", "H", "-", "1", "8"), to = c(10^3, 10^6, 1, 10^9, 10^6, 0,1,10^5, 10^6, 0, 10^4, 10^2, 10^3, 10^2, 10^7, 10^2, 0, 10, 10^8))
newdf2$PROPDMGEXP<- as.numeric(as.character(newdf2$PROPDMGEXP))
newdf2$PROPDMGTOTAL<- (newdf2$PROPDMG * newdf2$PROPDMGEXP)/1000000000
newdf2$CROPDMGEXP<- mapvalues(newdf2$CROPDMGEXP, from = c("","M", "K", "m", "B", "?", "0", "k","2"), to = c(1,10^6, 10^3, 10^6, 10^9, 0, 1, 10^3, 10^2))
newdf2$CROPDMGEXP<- as.numeric(as.character(newdf2$CROPDMGEXP))
newdf2$CROPDMGTOTAL<- (newdf2$CROPDMG * newdf2$CROPDMGEXP)/1000000000
newdf2$DAMAGETOTAL<- newdf2$PROPDMGTOTAL + newdf2$CROPDMGEXP
storm_type<- newdf2 %>%
  mutate(evtypegrp = ifelse(grepl("LIGHTNING|LIGNTNING", EVTYPE), "LIGHTNING", ifelse(grepl("HAIL", EVTYPE), "HAIL", ifelse(grepl("RAIN|FLOOD|WET|FLD", EVTYPE), "RAIN", ifelse(grepl("SNOW|WINTER|WINTRY|BLIZZARD|SLEET|COLD|ICE|FREEZE|AVALANCHE|ICY", EVTYPE), "WINTER",
                                                                                                                                                                      ifelse(grepl("TORNADO|FUNNEL", EVTYPE), "TORNADO",
                                                                                                                                                                                       ifelse(grepl("WIND|HURRICANE", EVTYPE), "WINDS",
                                                                                                                                                                                              ifelse(grepl("STORM|THUNDER|TSTM|TROPICAL +STORM", EVTYPE), "STORM",
                                                                                                                                                                                                     ifelse(grepl("FIRE", EVTYPE), "FIRE",
                                                                                                                                                                                                            ifelse(grepl("FOG|VISIBILITY|DARK|DUST", EVTYPE), "FOG",
                                                                                                                                                                                                                   ifelse(grepl("WAVE|SURF|SURGE|TIDE|TSUNAMI|CURRENT|SWELL", EVTYPE), "WAVE",
                                                                                                                                                                                                                          ifelse(grepl("HEAT|HIGH +TEMP|RECORD +TEMP|WARM|DRY", EVTYPE), "HEAT",
                                                                                                                                                                                                                                 ifelse(grepl("VOLCAN", EVTYPE), "VOLCANO",
                                                                                                                                                                                                                                        ifelse(grepl("DROUGHT", EVTYPE), "DROUGHT","OTHER"))))))))))))))
event_sum<- storm_type %>% group_by(evtypegrp) %>% summarise(damage = sum(DAMAGETOTAL), property= sum(PROPDMGTOTAL), crops = sum(CROPDMGTOTAL), fatalities = sum(FATALITIES), injuries = sum(INJURIES))
event_sum
fatalities_graph <-ggplot(event_sum, aes(evtypegrp, fatalities))+
  geom_bar(stat="identity")+
  ylab("Number of Fatalities")+
  xlab("Event Type")+
  ggtitle("Fatalities by Storm Type (1996-November 2011)")+
  geom_text(aes(label=fatalities), position=position_dodge(width=0.9), vjust=-0.25)
fatalities_graph
injuries_graph <-ggplot(event_sum, aes(evtypegrp, injuries))+
  geom_bar(stat="identity")+
  ylab("Number of Injuries")+
  xlab("Event Type")+
  ggtitle("Injuries by Storm Type (1996-November 2011)")+
  geom_text(aes(label=injuries), position=position_dodge(width=0.9), vjust=-0.25)
injuries_graph
damage <-head(event_sum[order(event_sum$damage, decreasing=TRUE),],5)
property <- damage %>% mutate(damage_type="Property", damage_amount=property)
crops <- damage %>% mutate(damage_type="Crops", damage_amount=crops)
damage_major <- rbind(property,crops)
ggplot(damage_major, aes(evtypegrp, damage_amount, fill=factor(damage_type))) +
  geom_bar(stat = "identity") + 
  ylab("Economic damage 1996 to November 2011") +
  xlab("Event Type") +
  scale_fill_discrete(name = "Damage") +
  ggtitle ("Total Economic Damage by Storm Type") +
  theme_gray(base_size = 10, base_family = "")
