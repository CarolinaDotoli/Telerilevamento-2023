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



                             #Iniziamo ad importare le immmagini del 2022#
#Impostiamo la working directory sulla cartella dell'esame 
setwd("C:/Exam/Dadia2022")

#Creiamo una lista per importare più bande contemporaneamente 
list_22 <- list.files (pattern = "T35TLF_20220907T090611_B")

#Applichiamo la funzione raster a tutte le bande della lista 
import_22 <- lapply(list_22, raster)

#Uniamo le diverse bande in un unica immagine 
sen_22 <- brick(import_22)

#Ritagliamo l'area studio 
ext <- c(379700, 429900, 4523600, 4549900)
Dadia_22 <- crop(sen_22, ext)
Dadia_22

#BANDA 2: blu 
#BAMDA 3: verde
#BANDA 4: rosso 
#BANDA 6: SWIR
#BANDA 7: NIR

#Plottiamo con colori naturali, NIR e SWIR
par(mfrow=c(1,3))
plotRGB(Dadia_22, 4,3,2, stretch="lin")
plotRGB(Dadia_22, 7,3,2, stretch="lin" )
plotRGB(Dadia_22, 6,7, 4, stretch="lin")

              
                            #Carichiamo immagini pre incendio (inizio agosto 2023)#
setwd("C:/Exam/Dadia_pre")

#Creiamo una lista 
list_pre <- list.files(pattern="T35TLF_20230803T090601_B")

#Applichiamo la funzione raster 
import_pre <- lapply(list_pre, raster)

#Uniamo le bande
sen_pre <- brick(import_pre)

#tagliamo l'immagine 
Dadia_pre <- crop(sen_pre, ext)

#Plottiamo con colori naturali, NIR e SWIR
par(mfrow=c(1,3))
plotRGB(Dadia_pre, 4,3,2, stretch="lin")
plotRGB(Dadia_pre, 7,3,2, stretch="lin" )
plotRGB(Dadia_pre, 6,7, 4, stretch="lin")

#esportiamo il grafico 
pdf("Dadia_pre.pdf")
dev.off()



                         #Importiamo le immagini durante l'incendio (28 Agosto 2023)#
setwd("C:/Exam/Dadia_post")

#Creiamo una lista 
list_post <- list.files(pattern="T35TLF_20230902T090601_B")

#Applichiamo la funzione raster 
import_post <- lapply(list_post, raster)

#Uniamo le bande
sen_post <- brick(import_post)

#tagliamo l'immagine 
Dadia_post <- crop(sen_post, ext)
Dadia_post

#Plottiamo con colori naturali, NIR e SWIR
#N.B: Qui manca il livello 1, quindi le bande sono sfalsate 
par(mfrow=c(1,3))
plotRGB(Dadia_post, 3,2,1, stretch="lin")
plotRGB(Dadia_post, 6,2,1, stretch="lin" )
plotRGB(Dadia_post, 5,6, 3, stretch="lin")

#esportiamo il grafico 
pdf("Dadia_during.pdf")
dev.off()


#2. CALCOLO DELLA DVI E NDVI#
#CALCOLO DVI
DVI22 <- Dadia_22[[7]] - Dadia_22[[4]] #7= Banda NIR; #4=Banda rosso. 
DVIpre <- Dadia_pre[[7]] - Dadia_pre [[4]]
DVIpost <- Dadia_post[[6]] - Dadia_post[[3]] #Manca la banda 1 quindi i colori sono sfalsati 

#Creiamo una palette di colori per visualizzare la DVI
clDVI <- colorRampPalette(c("chocolate3","khaki2", "olivedrab", "forestgreen")) (100)


par(mfrow=c(1,3))
plot(DVI22, col=clDVI, main="DVI nel 2022")
plot(DVIpre, col=clDVI, main="DVI nel 2023 (pre incendio)")
plot(DVIpost, col=clDVI, main="DVI nel 2023 (post incendio)")

#MARRONCINO: vegetazione assente
#OCRA: vegetazione presente
#VERDE: vegetazione sana

#Commento: Già dalla DVI si evidenzia un grande aumento di aree caratterizzate da assenza di vegetazione localizzate nel parco nazionale di Dadia a seguito dell'
#incendio di fine Agosto del 2023; si evince anche che sebbene il focolaio principale sia localizzato all'interno del parco la diffusione è stata estremmamente vasta


#Calcolo la NDVI (ovvero la normalized difference vegetation index), ovvero una DVI normalizzata, con valori 
#che sono compresi tra 0 e 1 per visualizzare al meglio la comparazione tra i diversi anni
#NDVI = DVI / (NIR + RED)
#NDVI 
NDVI22 <- DVI22 / (Dadia_22[[7]] + Dadia_22[[4]])
NDVIpre <- DVIpre / (Dadia_pre[[7]] + Dadia_pre[[4]])
NDVIpost <- DVIpost / (Dadia_post[[6]] + Dadia_post[[3]])

#Plottiamo le tre immagini con la NDVI
par(mfrow=c(1,3))
plot(NDVI22, col=clDVI, main = "NDVI nel 2022")
plot(NDVIpre, col=clDVI, main = "NDVI nel 2023 (pre incendio)")
plot(NDVIpost, col=clDVI, main = "NDVI nel 2023 (post incendio)")
dev.off()

#MARRONCINO: vegetazione assente
#OCRA: vegetazione presente
#VERDE: vegetazione sana
#Indici negativi indicano acqua o suolo nudo
#Valori compresi tra 0.2-0.5 indicano la presenza di aree agricole o vegetazione malsana 
#Valori superiori a 0.5 indicano una vegetazione sana

#Esportiamo l'immagine 
pdf("NDVI.pdf")
dev.off()

#Visualizziamo ora la differenza di NDVI tra i diversi anni per poter derterminare se vi è stato un aumento 
#o una diminuzione tra il 2022 ed il 2023, oltre che per verificare i danni dell'incendio 

difNDVI_norm <- NDVI22 - NDVIpre
difNDVI_incendio <- NDVIpre - NDVIpost
difNDVI_tot <- NDVI22 - NDVIpost

#Creiamo una palette di colori per visualizzare la differenza di NDVI
cldiff <- colorRampPalette(c("seagreen4", "mediumseagreen", "white", "lightpink", "deeppink3")) (100)

par(mfrow=c(1,3))
plot(difNDVI_norm, col=cldiff, main ="Differenza NDVI tra il 2022 e 2023")
plot(difNDVI_incendio, col=cldiff, main = "Differenza di NDVI dovuta all'incendio")
plot(difNDVI_tot, col=cldiff, main = "Differenza totale NDVI tra il 2022 e 2023 post incendio")

#Le aree verdi indicano che c'è stato un incremento nella vegetazione dall'immagine precedente usata per il confronto
#Le aree bianche indicano assenza di variazione della NDVI 
#Le aree rosa indicano una diminuzione della componente vegetale



