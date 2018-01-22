library(dplyr)
library(tidyr)
data(mtcars)
head(mtcars)
library(ggplot2)
mtcars<-mtcars %>%
  mutate(transmission = ifelse(am == 1,"Manual","Automatic"))
mtcars
g<-ggplot(mtcars,aes(transmission,mpg))+geom_point(color="firebrick")
g+ggtitle("Miles Per Gallon vs Transmission Type")+labs(x="Transmission Type",y="Miles Per Gallon")
g2<-ggplot(mtcars,aes(transmission))+geom_bar(aes(fill=factor(cyl)))
g2+ggtitle("Count of Cars by Tranmission and Cylinder Number")+
  theme(legend.position = "top")+
  guides(fill=guide_legend(title="Number of Cylinders"))
g3<-ggplot(mtcars,aes(transmission,wt))+geom_point(color="firebrick")
g3+ggtitle("Car Weight vs. Transmission Type")
model<-lm(mtcars$mpg~mtcars$am)
summary(model)
predicted<-predict(model)
ggplot(mtcars, aes(x = am, y = mpg)) +
  geom_smooth(method = "lm", se = FALSE, color = "lightgrey") +  
  geom_segment(aes(xend = am, yend = predicted), alpha = .2) +
  geom_point() +
  geom_point(aes(y = predicted), shape = 1) +
  theme_bw()  # Add theme for cleaner look
model2<-lm(mtcars$mpg~mtcars$am+mtcars$wt+mtcars$cyl)
summary(model2)
d <- mtcars %>% select(mpg, am, wt, cyl)
d$predicted2<-predict(model2)
d$residuals2<-resid(model2)
d %>% 
  gather(key = "iv", value = "x", -mpg, -predicted2, -residuals2) %>% 
  ggplot(aes(x = x, y = mpg)) +
  geom_segment(aes(xend = x, yend = predicted2), alpha = .2) +
  geom_point(aes(color = residuals2)) +
  scale_color_gradient2(low = "blue", mid = "white", high = "red") +
  guides(color = FALSE) +
  geom_point(aes(y = predicted2), shape = 1) +
  facet_grid(~ iv, scales = "free_x") +
  theme_bw()

