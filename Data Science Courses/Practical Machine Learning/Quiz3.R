library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(e1071)
library(rattle)
head(segmentationOriginal)
train<-segmentationOriginal[segmentationOriginal$Case=="Train",]
test<-segmentationOriginal[segmentationOriginal$Case=="Test",]
set.seed(125)
modFit<-train(Class~.,method="rpart",data=segmentationOriginal)
print(modFit$finalModel)
fancyRpartPlot(modFit$finalModel)
# Q3
library(pgmm)
library(tree)
data(olive)
olive = olive[,-1]
modFit<-train(Area~.,method="rpart",data=olive)
newdata = as.data.frame(t(colMeans(olive)))
# Q4
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]
set.seed(13234)
head(trainSA)
modFit<-glm(chd~age+alcohol+obesity+tobacco+typea+ldl,family="binomial"
            ,data=trainSA)
missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
trainPredict<-predict(modFit, trainSA, type="response") 
testPreditc<-predict(modFit, testSA, type="response") 
missClass(trainSA$chd,trainPredict)
# Q5
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)
vowel.train$y<-as.factor(vowel.train$y)
vowel.test$y<-as.factor(vowel.test$y)
set.seed(33833)
library(randomForest)
modFit<-randomForest(y~.,data=vowel.train)
sort(varImp(modFit)[,c(1:2)])
