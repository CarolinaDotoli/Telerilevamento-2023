#My first code in GitHub 
#Let's install the raster package
install.packages("raster")
library(raster)

#Import data, setting the working directory
 setwd("C:/Lab/") for Windows
#Import data:
l2011 <- brick("p224r63_2011_masked.grd")

#plotting the data
plot(l2011)

cl <- colorRampPalette(c("red", "orange", "yellow")) (100) #100 sono le sfumature

#plotting one element 
plot(l2011 [[4]], col=cl)
#We can use also the name: 
plot(l2011$B4_sre, col=cl)


nir <- l2011[[4]] #or nr <- l2011$B4_sre
plot(nir, col=cl)

#Plot the nir band 
# b1=blue
# b2=green
# b3=red
# b4=NIR
plot(l2011[[4]], col=cl)
plot(l2011$B4_sre, col=cl)

#dev.off () close the grapich

#Export graphs in R
pdf("myfirstgraph.pdf")
plot(l2011$B4_sre, col=cl)
dev.off()

# Plotting several bands in a multiframe
par(mfrow=c(2,1))
plot(l2011[[3]], col=cl)
plot(l2011[[4]], col=cl)

# Plotting the first 4 layers / bands
# blue
clb <- colorRampPalette(c("blue4","blue2","light blue"))(100) # 100 sono le sfumature
plot(l2011[[1]], col=clb)
#green
clg <- colorRampPalette(c("chartreuse4","chartreuse2","chartreuse"))(100)
#red
clr <- colorRampPalette(c("coral3","coral1","coral"))(100)
#nir
cln <- colorRampPalette(c("darkorchid4","darkorchid2","darkorchid4"))(100)
par(mfrow=c(2,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
plot(l2011$B3_sre, col=clr)
plot(l2011$B4_sre, col=cln)

# RGB plotting
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

# Multiframe with natural and false colours
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

# Histogram stretching
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="Hist")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# Linear vs. Histogram stretching
par(mfrow=c(2,1))
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# Exercise: plot the NIR band
plot(l2011[[4]])

# Exercise: import the 1988 image
l1988 <- brick("p224r63_1988_masked.grd")

# Exercise: plot in RGB space (natural colours)
plotRGB(l1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin") #you can also write plotRGB(l1988, 4, 3, 2, stretch="Lin")

# multiframe
par(mfrow=c(2,1))
plotRGB(l1988, 4, 3, 2, stretch="Lin")
plotRGB(l2011, 4, 3, 2, stretch="Lin")

dev.off()
plotRGB(l1988, 4, 3, 2, stretch="Hist")

# multiframe with 4 images
par(mfrow=c(2,2))
plotRGB(l1988, 4, 3, 2, stretch="Lin")
plotRGB(l2011, 4, 3, 2, stretch="Lin")
plotRGB(l1988, 4, 3, 2, stretch="Hist")
plotRGB(l2011, 4, 3, 2, stretch="Hist")

