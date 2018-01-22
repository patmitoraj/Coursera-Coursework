library(caret)
library(ElemStatLearn)
library(gbm)
library(dplyr)
data(vowel.train)
data(vowel.test)
vowel.train$y<-as.factor(vowel.train$y)
vowel.test$y<-as.factor(vowel.test$y)
set.seed(33833)
modFit1<-train(y~.,method="rf",data=vowel.train)
modFit2<-train(y~.,method="gbm",data=vowel.train)
pred1<-predict(modFit1,vowel.test)
pred2<-predict(modFit2,vowel.test)
agreement<-pred1==pred2
df<-data.frame(cbind(pred1,pred2,agreement))
confusionMatrix(pred1,vowel.test$y)
confusionMatrix(pred2,vowel.test$y)

##Q2
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
set.seed(62433)
modFit1<-train(diagnosis~.,method="rf",data=training)
modFit2<-train(diagnosis~.,method="gbm",data=training)
modFit3<-train(diagnosis~.,method="lda",data=training)
pred1<-predict(modFit1,testing)
pred2<-predict(modFit2,testing)
pred3<-predict(modFit3,testing)
predDF<-data.frame(pred1,pred2,pred3,diagnosis=testing$diagnosis)
combModelFit<-train(diagnosis~.,method="gam",data=predDF)
comPred<-predict(combModelFit,predDF)
confusionMatrix(comPred,testing$diagnosis)
confusionMatrix(pred1,testing$diagnosis)
confusionMatrix(pred2,testing$diagnosis)
confusionMatrix(pred3,testing$diagnosis)
#Q3
set.seed(3523)
library(elasticnet)
library(AppliedPredictiveModeling)
library(glmnet)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
head(concrete)
set.seed(233)
lassoMod<-train(CompressiveStrength~., data= training, method = "lasso")
plot(lassoMod$finalModel) 
#Q4
library(forecast)
library(lubridate) # For year() function below
dat<- read.csv("C:\\Users\\Pat Mitoraj\\Downloads\\gaData.csv")
training<-dat[year(dat$date) < 2012,]
testing<-dat[(year(dat$date)) > 2011,]
tstrain<-ts(training$visitsTumblr)
tstest<-ts(testing$visitsTumblr)
model<-bats(tstrain)
length(testing$visitsTumblr)
predictions<-forecast(model,235,level=95)
testing$Accuracy<-ifelse(testing$visitsTumblr<=predictions$upper,ifelse(testing$visitsTumblr>=predictions$lower,"Yes","No"),"No")
table(testing$Accuracy)
226/235
#Q5
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain<-createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training<-concrete[ inTrain,]
testing<-concrete[-inTrain,]
set.seed(325)
library(e1071)
modFit<-svm(CompressiveStrength~., data= training)
prediction<-predict(modFit,testing)
RMSE(prediction,testing$CompressiveStrength)
