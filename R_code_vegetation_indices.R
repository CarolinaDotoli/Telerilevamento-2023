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
