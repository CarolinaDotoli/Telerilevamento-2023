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

#Esportiamo l'immagine 
setwd("C:/Grecia/")
pdf("Dadia_22.pdf")

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

#Esportiamo l'immagine 
pdf("Dadia_incendio23.pdf")
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

#Compariamo le immagini con colori naturali e colori falsi 
par(mfrow=c(1,2))
plotRGB(Dadia_08_23, 3,2,1, stretch="Lin")
plotRGB(Dadia_08_23, 4,3,2, stretch="Lin")

#Visualizziamo con un plot a colori naturali la foresta di Dadia nel 2022, a luglio del 2023 e dopo l'incendio
par(mfrow=c(1,3))
plotRGB(Dadia22, 3,2,1, stretch="lin")
plotRGB(Dadia_07_23, 3,2,1, stretch = "lin")
plotRGB(Dadia_08_23, 3,2,1, stretch = "lin")

#Esportiamo l'immagine 
pdf("Comparazione Dadia.pdf")
dev.off()

#Per visualizzare al meglio l'area dell'incendio importiamo le immagini dell'incendio ad una risoluzione di 20m
#Impostiamo la working directory 
setwd("C:/Grecia/Dadia_28Agosto")


#Creiamo una lista con le bande che vogliamo importare 
list_Dadia2320m <- list.files(pattern = "T35TLF_20230828T090559_B")

#Applichiamo la funzione raster a tutte le bande della lista 
import_2320m <- lapply(list_Dadia2320m, raster)

##Uniamo tutte le bande in un'unica immagine 
sen_2320m <- brick(import_2320m)

#Ritagliamo l'area di studio sul parco Nazionale delle foreste di Dadia, 
#Posto al confine con la Turchia
#Tagliamo l'area di studio
ext <- c(379700, 429900, 4523600, 4549900 )
Dadia_2320m <- crop(sen_2320m, ext)
Dadia_2320m


dev.off()
par(mfrow=c(1,3))
plotRGB(Dadia_2320m, 5,6, 3, stretch="lin" )
plotRGB(Dadia_2320m, 3,2,1, stretch="lin", main = "colori naturali")
plotRGB(Dadia_2320m, 6,3,2, stretch="lin", main = "falsi colori")


###CALCOLO DVI (difference vegetation index) è un indice utilizzato per quantificare la 
##vegetazione verde attraverso la sottrazione NIR - RED e per quantificarne il suo stato di 
##salute 

#Calcolo DVI per i diversi anni
DVI22 <- Dadia22$T35TMF_20220714T090559_B08_10m - Dadia22$T35TMF_20220714T090559_B04_10m      #il layer 4 corrisponde al NIR, quello 3 al rosso
DVI23 <- Dadia_07_23$T35TMF_20230729T090559_B08_10m - Dadia_07_23$T35TMF_20230729T090559_B04_10m
DVIincendio23 <- Dadia_08_23$T35TMF_20230828T090559_B08_10m - Dadia_08_23$T35TMF_20230828T090559_B04_10m


#Creiamo una palette di colori per visualizzare la DVI
clDVI <- colorRampPalette(c("chocolate3","khaki2", "olivedrab", "forestgreen")) (100)

#MARRONCINO: vegetazione assente
#OCRA: vegetazione presente
#VERDE: vegetazione sana

#Plottiamo la DVI per i 3 anni 
par(mfrow=c(1,3))
plot(DVI22, col=clDVI, main = "DVI nel 2022")
plot(DVI23, col=clDVI, main = "DVI nel 2023")
plot(DVIincendio23, col=clDVI, main="DVI post incendio 2023")

#Esportiamo l'immagine 
pdf("DVI.pdf")
dev.off()

#Commento: Già dalla DVI si evidenzia un grande aumento di aree caratterizzate da assenza di vegetazione localizzate nel parco nazionale di Dadia a seguito dell'
#incendio di fine Agosto del 2023; si evince anche che sebbene il focolaio principale sia localizzato all'interno del parco la diffusione è stata estremmamente vasta

#Calcolo la NDVI (ovvero la normalized difference vegetation index), ovvero una DVI normalizzata, con valori 
#che sono compresi tra 0 e 1 per visualizzare al meglio la comparazione tra i diversi anni
#NDVI = DVI / (NIR + RED)

NDVI22 <- DVI22 / (Dadia22$T35TMF_20220714T090559_B08_10m + Dadia22$T35TMF_20220714T090559_B04_10m)
NDVI23pre <- DVI23 / (Dadia_07_23$T35TMF_20230729T090559_B08_10m + Dadia_07_23$T35TMF_20230729T090559_B04_10m)
NDVI23post <- DVIincendio23 / (Dadia_08_23$T35TMF_20230828T090559_B08_10m + Dadia_08_23$T35TMF_20230828T090559_B04_10m)

#Plottiamo le tre immagini con la NDVI
par(mfrow=c(1,3))
plot(NDVI22, col=clDVI, main ="NDVI nel 2022")
plot(NDVI23pre, col=clDVI, main ="NDVI nel 2023")
plot(NDVI23post, col=clDVI, main = "NDVI post incendio 2023")

#Indici negativi indicano acqua o suolo nudo
#Valori compresi tra 0.2-0.5 indicano la presenza di aree agricole o vegetazione malsana 
#Valori superiori a 0.5 indicano una vegetazione sana
