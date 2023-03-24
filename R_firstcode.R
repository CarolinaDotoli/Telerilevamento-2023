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
