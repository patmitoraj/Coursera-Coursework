library(ggplot2)
set.seed(21)
n <- 40
lambda <- 0.2
sim <- 1000
dist<-matrix(rexp(n*sim, lambda), sim)
rowMeans <- apply(dist,1,mean)
sampleMean <- mean(rowMeans)
sampleMean
sampleVar <- var(rowMeans)
sampleVar
popMean<-1/lambda
popMean
popSd<-((1/lambda) * (1/sqrt(n)))
popVar<- popSd^2
popVar
data<-data.frame(rowMeans)
xfit <- seq(min(rowMeans), max(rowMeans), length=100)
yfit <- dnorm(xfit, mean=1/lambda, sd=(1/lambda/sqrt(n)))
hist(data$rowMeans,breaks=n,prob=T,col="blue",xlab = "means",main="Density Distribution of Average of Exponentials",ylab="density") 
lines(xfit, yfit, pch=22, col="black", lty=5)
#Part 2#
data("ToothGrowth")
summary(ToothGrowth)
head(ToothGrowth)
length(ToothGrowth)
ToothGrowth$dose<-as.factor(ToothGrowth$dose)
ggplot(aes(x=dose, y=len), data=ToothGrowth) + geom_boxplot(aes(fill=dose)) + xlab("Dose Amount") + ylab("Tooth Length") + facet_grid(~ supp) + ggtitle("Tooth Length vs. Dose Amount \nby Delivery Method") + 
  theme(plot.title = element_text(lineheight=.8, face="bold"))
ggplot(aes(x=supp, y=len), data=ToothGrowth) + geom_boxplot(aes(fill=supp)) + xlab("Supplement Delivery") + ylab("Tooth Length") + facet_grid(~ dose) + ggtitle("Tooth Length vs. Delivery Method \nby Dose Amount") + 
  theme(plot.title = element_text(lineheight=.8, face="bold"))
t.test(len~supp,data=ToothGrowth)
ToothGrowth_sub <- subset(ToothGrowth, ToothGrowth$dose %in% c(1.0,0.5))
t.test(len~dose,data=ToothGrowth_sub)
ToothGrowth_sub <- subset(ToothGrowth, ToothGrowth$dose %in% c(0.5,2.0))
t.test(len~dose,data=ToothGrowth_sub)
ToothGrowth_sub <- subset(ToothGrowth, ToothGrowth$dose %in% c(1.0,2.0))
t.test(len~dose,data=ToothGrowth_sub)
