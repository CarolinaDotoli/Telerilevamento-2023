# LEZIONE 8a: COPERNICUS
# Download and visualize data of Earth Observation

# Install and load the required packages
library(raster)
library(ggplot2)
library(viridis)
install.packages("ncdf4")
library(ncdf4)

# Register and download data from:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

# Upload data as raster object
soil_moisture <- raster("c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc")
soil_moisture
ncell(soil_moisture) # 28311808
plot(soil_moisture)

# Coerce data into a dataframe
soil_moisture_df <- as.data.frame(soil_moisture, xy=T)

# Columns' names of the dataframe
colnames(soil_moisture_df)

# Plot with ggplot()
ggplot() +
  geom_raster(soil_moisture_df,
              mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
  ggtitle("Soil Moisture from Copernicus")

# Let's crop image by coordinates
ext <- c(23, 30, 62, 68)
soil_moisture_crop <- crop(soil_moisture, ext)
soil_moisture_crop

# Coerce the cropped image into a dataframe
soil_moisture_crop_df <- as.data.frame(soil_moisture_crop, xy=T)
soil_moisture_crop_df

# Plot the cropped image with ggplot(), adding viridis scale colour
ggplot() +
  geom_raster(soil_moisture_crop_df,
              mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
  ggtitle("Soil Moisture from Copernicus") +
  scale_fill_viridis()





# EXERCISE: chose another image from Copernicus and follow the same path

# Upload data as raster object
forest_cover <- raster("c_gls_FCOVER-RT0_202006300000_GLOBE_PROBAV_V2.0.1.nc")
forest_cover
ncell(forest_cover) # 28311808
plot(forest_cover)

# The file size is too big, let's crop it
ext_1 <- c(14, 19, 39, 42) # Part of South Italy
forest_cover_crop <- crop(forest_cover, ext_1)
forest_cover_crop
plot(forest_cover_crop)

# Coerce into a dataframe
forest_cover_crop_df <- as.data.frame(forest_cover_crop, xy=T)

# Columns' names of the dataframe
colnames(forest_cover_crop_df) # Fraction.of.green.Vegetation.Cover.1km

# Plot with ggplot()
ggplot() +
  geom_raster(forest_cover_crop_df,
              mapping=aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.1km)) +
  ggtitle("Forest Cover from Copernicus") +
  scale_fill_viridis()

# Let's focus on Salento area
ext_2 <- c(17, 19, 39.5, 41) # Salento
forest_cover_Sal <- crop(forest_cover, ext_2)
forest_cover_Sal
plot(forest_cover_Sal)

# Coerce into a dataframe
forest_cover_Sal_df <- as.data.frame(forest_cover_Sal, xy=T)

# Columns' names of the dataframe
colnames(forest_cover_Sal_df) # Fraction.of.green.Vegetation.Cover.1km

# Plot with ggplot()
ggplot() +
  geom_raster(forest_cover_Sal_df,
              mapping=aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.1km)) +
  ggtitle("Forest Cover of Salento from Copernicus") +
  scale_fill_viridis()
