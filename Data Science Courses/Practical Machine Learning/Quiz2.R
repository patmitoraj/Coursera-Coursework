#Question1
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
#Question2
library(AppliedPredictiveModeling)
library(ggplot2)
data(concrete)
library(caret)
library(Hmisc)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
head(concrete)
cutCement<-cut2(concrete$Cement,g=4)
cutWater<-cut2(concrete$Water,g=4)
cutFurnace<-cut2(concrete$BlastFurnaceSlag,g=4)
cutFlyAsh<-cut2(concrete$FlyAsh,g=4)
cutSuperPlasticizer<-cut2(concrete$Superplasticizer,g=4)
cutCoarseAggregate<-cut2(concrete$CoarseAggregate,g=4)
cutFineAggregate<-cut2(concrete$FineAggregate,g=4)
cutAge<-cut2(concrete$Age,g=4)
qplot(as.numeric(row.names(concrete)),concrete$CompressiveStrength,
      colour=cutAge, data=concrete)
#Question3
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
qplot(concrete$Superplasticizer)
#Question4
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
library(ggplot2)
library(caret)
ncol(training)
which(sapply(adData,class)=="factor")
summary(training$diagnosis)
training$diagnosis = as.numeric(training$diagnosis)
p <- prcomp(training[,grep('^IL',names(training))])
p$rotation[,1:7]
qplot(1:length(p$sdev),p$sdev / sum(p$sdev))
which(cumsum(p$sdev) / sum(p$sdev) <= .9)
(cumsum(p$sdev) / sum(p$sdev))[8]
preProc <- preProcess(training[,grep('^IL',names(training))],method="pca",thres=.9)
preProc
#Question5
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
trainSmall <- data.frame(training[,grep('^IL',names(training))],training$diagnosis)
testSmall <- data.frame(testing[,grep('^IL',names(testing))],testing$diagnosis)
preProc <- preProcess(trainSmall[-13],method="pca",thres=.8)
trainPC <- predict(preProc,trainSmall[-13])
testPC <- predict(preProc,testSmall[-13])
PCFit <- train(trainSmall$training.diagnosis~.,data=trainPC,method="glm")
NotPCFit <- train(trainSmall$training.diagnosis~.,data=trainSmall,method="glm")
PCTestPredict <- predict(PCFit,newdata=testPC)
NotPCTestPredict <- predict(NotPCFit,newdata=testSmall)
confusionMatrix(PCTestPredict,testSmall$testing.diagnosis)
confusionMatrix(NotPCTestPredict,testSmall$testing.diagnosis)