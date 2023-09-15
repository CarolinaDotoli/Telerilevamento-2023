library(raster)
library(ggplot2)
library(patchwork)

#Importing the images
setwd("C:/Lab/")
defor1 <- brick("defor1_.png")
defor2 <- brick("defor2_.png")

# NIR 1, RED 2, GREEN 3

#Compare the two images
par(mfrow=c(2,1))
plotRGB(defor1, 1, 2, 3, stretch="Lin")
plotRGB(defor2, 1, 2, 3, stretch="Lin")

#1. Get all the single values
#Get Values
singlenr1 <- getValues(defor1)
singlenr1

#Classify
kcluster1 <- kmeans(singlenr1, centers=2)
kcluster1

#Recreating an image
defor1class <- setValues(defor1$defor1__1, kcluster1$cluster)
plot(defor1class)

# class1: forest
# class2: bare soil

#---- Classification of the 2006 image
#Get Values
singlenr2 <- getValues(defor2)
singlenr2

#Classify
kcluster2 <- kmeans(singlenr2, centers=2)
kcluster2

#Creating an image
defor2class <- setValues(defor2$defor2__1, kcluster2$cluster)
plot(defor2class)

# class1: forest
# class2: bare soil

#--- multiframe
par(mfrow=c(2,1))
plot(defor1class)
plot(defor2class)

#Class percentages
frequencies1 <- freq(defor1class)
frequencies1
total1 <- ncell(defor1class)
total1

percentage1 <- frequencies1*100/total1
percentage1

# forest: 89.75
# bare soil: 10.25

#---- 2006

frequencies2 <- freq(defor2class)
total2 <- ncell(defor2class)
total2
percentage2 <- frequencies2*100/total2
percentage2

#Forest= 52.069%
#Bare soil= 47.93%

#Final table
cover <- c("Forest", "Bare soil")
percent1992 <- c(89.75, 10.25)
percent2006 <- c(52.07, 47.93)

percentages <- data.frame(cover, percent1992, percent2006)
percentages

#ggplot 2
ggplot(percentages, aes(x=cover, y=percent1992, color=cover)) + geom_bar(stat="identity",fill="white")

ggplot(percentages, aes(x=cover, y=percent2006, color=cover)) + geom_bar(stat="identity", fill="white")

#Patchwork
p1 <- ggplot(percentages, aes(x=cover, y=percent1992, color=cover)) + geom_bar(stat="identity",fill="white") + ggtitle("Year 1992")
p2 <- ggplot(percentages, aes(x=cover, y=percent2006, color=cover)) + geom_bar(stat="identity", fill="white") + ggtitle("Year 2006")
p1 + p2

p11 <- ggplot(percentages, aes(x=cover, y=percent1992, color=cover)) + geom_bar(stat="identity",fill="white") + ggtitle("Year 1992")+ ylim(c(0,100))
p22 <- ggplot(percentages, aes(x=cover, y=percent2006, color=cover)) + geom_bar(stat="identity", fill="white") + ggtitle("Year 2006")+ ylim(c(0,100))
p11 + p22



