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
