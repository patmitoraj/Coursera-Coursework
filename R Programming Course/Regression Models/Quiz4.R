install.packages("MASS")
library(MASS)
library(dplyr)
#Q1
data(shuttle)
new_shuttle=mutate(shuttle,autobin= ifelse(use=='auto',1,0))
logfit = glm(new_shuttle$autobin~factor(new_shuttle$wind)-1,family="binomial")
coeff=summary(logfit)$coeff[,1]
ans=exp(coeff[1]-coeff[2])
ans
#Q2
logfit2 = glm(new_shuttle$autobin~factor(new_shuttle$wind)-1+factor(new_shuttle$magn),family="binomial")
coeff2=summary(logfit2)$coeff[,1]
ans2=exp(coeff2[1]-coeff2[2])
ans2
#Q3
logfit3 = glm(1-new_shuttle$autobin~factor(new_shuttle$wind)-1+factor(new_shuttle$magn),family="binomial")
summary(logfit2)
summary(logfit3)
#Q4
data(InsectSprays)
head(InsectSprays)
logFitInsect=glm(InsectSprays$count~factor(InsectSprays$spray)-1,family="poisson")
coeff3=summary(logFitInsect)$coeff[,1]
ans=exp(coeff3[1]-coeff3[2])
ans
#Q6
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
spline_term = x*(x>0)
regr = cbind(1,x,spline_term)
fit = lm(y~regr-1)
yhat = predict(fit)
plot(x,y,frame=FALSE,pch=21,bg='lightblue',cex=2)
lines(x,yhat,col='red',lwd=2)
ans=(yhat[11]-yhat[7])/4
ans
