# R code for importing and analysing several images
setwd("C:/LabGreenland/")

#Import the first image 
lst_2000 <- brick("lst_2000.tif")
plot(lst_2000)

# Exercise: import all the data
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

ls()

# list f files:
rlist <- list.files(pattern="lst")
rlist

import <- lapply(rlist,raster)
import

TGr <- stack(import)
TGr
plot(TGr)

#Plot the file in RGB
plotRGB(TGr, r=1, g=2, b=3, stretch="Lin")
plotRGB(TGr, r=2, g=3, b=4, stretch="Lin")

# difference:
dift = TGr[[2]] - TGr[[1]]


cl <- colorRampPalette(c("blue", "light blue", "pink", "red")) (100)
plot(TGr, col=cl)


#Exercise 2: European NO2
setwd("C:/Lab/EN")
library(raster)

#Importing a file
EN_1 <- raster("EN_0001.png")

cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(EN_1, col=cl)

#Importing all files togheter
rlist <- list.files(pattern="EN")
import <- lapply(rlist, raster)
EN <- stack(import)
plot(EN)

#Controllare che la prima immagine importanta corrisponda alla prima dello stack
par(mfrow=c(1,2))
plot(EN_1, col=cl)
plot(EN$EN_0001_1, col=cl)

#Second type of check
difcheck <- EN_1 - EN$EN_0001_1 
plot(difcheck)

#First and last data
par(mfrow=c(1,2))
plot(EN$EN_0001_1, col=cl)
plot(EN$EN_0013_1, col=cl)

#Differences between the first and the last data
difen = EN$EN_0001_1 - EN$EN_0013_1
cldif <- colorRampPalette(c("blue", "white", "red")) (100)
plot(difen, col=cldif)

plotRGB(EN, r=1, g=7, b=13, stretch="lin") #or plotRGB(EN, 1, 7, 13, stretch="lin")
