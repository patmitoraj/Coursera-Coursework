#Q1
attach(mtcars)
help(mtcars)
fit<-lm(mpg~factor(cyl)+wt)
summary(fit)
#Q2
fit2<-lm(mpg~factor(cyl))
summary(fit2)
#Q3
library(lmtest)
fit<-lm(mpg~factor(cyl)+wt)
fit3<-lm(mpg~factor(cyl)*wt)
lrtest(fit,fit3)
#Q5
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
fit4<-lm(y~x)
influence(fit4)
#Q6
dfbetas(fit4)
