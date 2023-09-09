                                                                        #PROGETTO TELERILEVAMENTO 2023#

#Analisi dell'incendio in Grecia avvenuto nel 2023 a fine Agosto, in particolar modo concentrandoci sulla foresta di Dadia (Parco Nazionale); per analizzare i danni causati dall'incendio e comparare anche nel 
#corso del 2023 il benessere e la copertura vegetale della foresta. 

#Carichiamo le librerire necessarie
library(raster) #Serve per aprire i dati raster 
library(ggplot2) #Per creare dei plot migliori  
library(viridis) #Per creare delle palette di colori gradutate per facilitare la lettura dei grafici a persone con deficit visivi
library(patchwork) #Per affiancare due grafici fatti con ggplot



#1. CARICAMENTO E VISUALIZZAZIONE DELLE IMMAGINI
#Iniziamo con l'importazione delle immagini sentinel
#IMMAGINI 2022#

#Impostiamo la working directory
setwd("C:/Grecia/14-07-22")

#creiamo una lista con tutte le bande del 2022 che ci interessano
list_22 <- list.files(pattern="T35TMF_20220714T090559_B")
list_22

#Applichiamo la funzione raster all'intera lista
import_22 <- lapply(list_22, raster)
import_22

#Uniamo i diversi livelli in un unica immagine 
sen_22 <- brick(import_22)
sen_22

#Plottiamo tutte le bande dell'immagine 
plot(sen_22)

#B1: BLU
#B2: VERDE
#B3: ROSSO
#B4: NIR

#Ritagliamo l'area di studio sul parco Nazionale delle foreste di Dadia, 
#Posto al confine con la Turchia


#Tagliamo l'area di studio
ext <- c(399960, 463760, 4520220, 4590020 )
Dadia22 <- crop(sen_22, ext)

#Plot in RGB della foresta di Dadia con colori naturali e affiancata l'immagine con falsi colori
par(mfrow=c(2,2))
plotRGB(Dadia22, 3,2,1, stretch="lin")
plotRGB(Dadia22, 4,3,2, stretch="lin")

#Banda 4= NIR 
#Banda 3= Rosso
#Banda 2= Verde
#Banda 1= Blu


#Ripetiamo l'operazione per importare le immagini anche per gli altri due anni
#IMMAGINI 2023 PRE INCENDIO#

#Impostiamo la working directory
setwd("C:/Grecia/24-07-23")

#Creiamo una lista con le bande da importare 
list_07_23 <- list.files(pattern="T35TMF_20230729T090559_B")

#Applichiamo la funzione raster all'intera lista 
import_07_23 <- lapply(list_07_23, raster)

#Uniamo tutti i livelli in un unica immagine 
sen_07_23 <- brick(import_07_23)

#Ritagliamo l'area di studio 
Dadia_07_23 <- crop(sen_07_23, ext)

#Plottiamo con colori naturali comparato a falsi colori 
par(mfrow=c(1,2))
plotRGB(Dadia_07_23, 3,2,1, stretch="lin")
plotRGB(Dadia_07_23, 4,3,2, streth="lin")
dev.off()
                            
                              
#DURANTE INCENDIO 2023#
#Importiamo l'immagine dell'agosto del 2023

#Impostiamo la working directory
setwd("C:/Grecia/28-08-23")

#Importiamo la lista di bande 
list_08_23 <- list.files(pattern = "T35TMF_20230828T090559_B")

#Applichiamo la funzione raster 
import_08_23 <- lapply(list_08_23, raster)

#Uniamo i diversi livelli
sen_08_23 <- stack(import_08_23)

#Tagliamo l'area di studio
ext <- c(399960, 463760, 4520220, 4590020 )
Dadia_08_23 <- crop(sen_08_23, ext)

#Compariamo prima e post incendio 
par(mfrow=c(1,2))
plotRGB(Dadia_08_23, 3,2,1, stretch="Lin")
plotRGB(Dadia_08_23, 4,3,2, stretch="Lin")


  

###CALCOLO DVI (difference vegetation index) è un indice utilizzato per quantificare la 
##vegetazione verde attraverso la sottrazione NIR - RED e per quantificarne il suo stato di 
##salute 
