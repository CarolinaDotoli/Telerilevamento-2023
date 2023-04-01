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
