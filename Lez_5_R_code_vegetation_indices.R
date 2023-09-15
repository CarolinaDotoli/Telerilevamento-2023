# Calculating spectral indices
library(raster)

#Import the imagine
setwd("C:/Lab/")
l1992 <- brick("defor1_.png")

#Plot in RGB
PlotRGB(l1992, r=1, g=2, b=3, stretch="Lin")

# layer 1 = NIR
# layer 2 = red
# layer 3 = green


# Exercise: calculate DVI for 1992
dvi1992 = l1992[[1]] - l1992[[2]]

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1992, col=cl)

#Importing the second file 
l2006 <- brick("defor2_.png")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

# Exercise: plot in a multiframe the two images with one on top of the other
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

# DVI Difference Vegetation Index
dvi1992 = l1992[[1]] - l1992[[2]]
# or:
# dvi1992 = l1992$defor1_.1 - l1992$defor1_.2
#Calculating DVI for the second file 
dvil2006 = l2006$defor2__1 - l2006$defor2__2
plot(dvil2006, col=cl)

# Multitemporal analysis (DVI difference in time)
difdvi = dvil1992 - dvil2006

cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)



# Range DVI (8 bit): -255 a 255
# Range NDVI (8 bit): -1 a 1
# Range DVI (16 bit): -65535 a 65535
# Range NDVI (16 bit): -1 a 1
# NDVI can be used to compare images with a different radiometric resolution
ndvi1992 = dvil1992 / (l1992$defor1__1 + l1992$defor1__2)
plot(ndvi1992, col=cl)
ndvi2006 = dvil2006 / (l2006$defor2__1 + l2006$defor2__2)
plot(ndvi2006, col=cl)

difndvi= ndvi1992 - ndvi2006 
plot(difndvi, col=cld)
