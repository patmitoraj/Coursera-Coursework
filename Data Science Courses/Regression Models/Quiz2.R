x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
fit<-lm(y~x)
summary(fit)
sigma(fit)
## Q3
attach(mtcars)
mtcars.lm<-lm(mpg~wt)
df<-data.frame(wt=mean(wt))
interval<-predict(mtcars.lm,df,interval='confidence')
help(mtcars)
(3000*-5.3445)
## Q5
mtcars.lm<-lm(mpg~wt)
df<-data.frame(wt=3)
predict(mtcars.lm,df,interval='predict')
##Q6
newWt=wt/2
mtcars.lm<-lm(mpg~newWt)
summary(mtcars.lm)
coefficients(mtcars.lm)
##Q9
model1<-lm(mpg~wt)
model2<-lm(mpg~1)
summary(model2)
errors1<-sum(residuals(model1)^2)
errors2<-sum(residuals(model2)^2)
errors1/errors2
