#Classification of remote sensing data via Rtoolbox

#Installing devtools
install.packages("devtools")
library(devtools)

devtools::install_github ("bleutner/RStoolbox")

#Importing the imagine
setwd("C:/Lab")
Solar_Orbiter <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#Plotting the file
plotRGB(Solar_Orbiter, 1, 2, 3, stretch="Lin")

# 1. Get values
singlenr <- getValues(so)
singlenr

# 2. kmeans
kcluster <- kmeans(singlenr, centers = 3)
kcluster

# 3. Set values to a raster on the basis of so
soclass <- setValues(so[[1]], kcluster$cluster) # assign new values to a raster object

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soclass, col=cl)

# class 1: highest energy level
# class 2: medium energy level
# class 3: lowest energy level

frequencies <- freq(soclass)
tot = 2221440
percentages =  frequencies * 100 / tot

# class 1: highest energy level: 21.2%
# class 2: medium energy level: 41.4%
# class 3: lowest energy level: 37.3%



#---- Grand Canyon exercise
library(raster)
setwd("C:/Lab/")
GrandCanyon <- brick(GrandCanyon <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
                     
 #Plotting the imagine 
 plotRGB(GrandCanyon, 1, 2, 3, stretch="Lin")
 
#Crop the image
gcc <- crop(GrandCanyon, drawExtent())
gcc

ncell(GrandCanyon)
ncell(gcc) 

#1. Get values
singlenr <- getValues(gcc)
singlenr

#2. Classify 
kcluster <- kmeans(gcc, centers=3)
kcluster

#3. Set values
gcclass <- setValues(gcc$dolansprings_oli_2013088_canyon_lrg_1, kcluster$cluster)
gcclass
plot(gcclass)

# class 1: volcanic rocks
# class 2: sandstone
# class 3: conglomerates

frequencies <- freq(gcclass)
frequencies

total <- ncell(gcclass)

percentages <- frequencies * 100 / total
percentages

                     
                     
                     
                     
                     
                     
                     
                     
                    
                    
                     
