                                                     #PROGETTO TELERILEVAMENTO 2023#

#Analisi dell'incendio in Grecia avvenuto nel 2023 a fine Agosto, in particolar modo concentrandoci sulla foresta di Dadia (Parco Nazionale); per analizzare i danni causati dall'incendio e comparare anche nel 
#corso del 2023 il benessere e la copertura vegetale della foresta dal 2022 al 2023. 

#Carichiamo le librerire necessarie
library(raster) #Serve per aprire i dati raster 
library(ggplot2) #Per creare dei plot migliori  
library(patchwork) #Per affiancare due grafici fatti con ggplot



#1. CARICAMENTO E VISUALIZZAZIONE DELLE IMMAGINI
#Iniziamo con l'importazione delle immagini sentinel

                                                       #IMMAGINI 2022#
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

#Visualizziamo le informazioni
Dadia_22

#BANDA 2: blu 
#BAMDA 3: verde
#BANDA 4: rosso 
#BANDA 6: SWIR
#BANDA 7: NIR

#Plottiamo con colori naturali e NIR 
par(mfrow=c(1,2), oma= c(3, 3, 2, 2))
plotRGB(Dadia_22, 4,3,2, stretch="lin")
plotRGB(Dadia_22, 7,3,2, stretch="lin" )

#Esportiamo l'immagine 
pdf("Dadia_22.pdf")
dev.off ()

 
                                                  #IMMAGINI 3 AGOSTO 2023#
#Impostiamo la working directory
setwd("C:/Exam/Dadia_pre")

#Creiamo una lista 
list_pre <- list.files(pattern="T35TLF_20230803T090601_B")

#Applichiamo la funzione raster 
import_pre <- lapply(list_pre, raster)

#Uniamo le bande
sen_pre <- brick(import_pre)

#tagliamo l'immagine 
Dadia_pre <- crop(sen_pre, ext)

#Visualizziamo le informazioni 
Dadia_pre

#BANDA 2: blu 
#BAMDA 3: verde
#BANDA 4: rosso 
#BANDA 6: SWIR
#BANDA 7: NIR

#Plottiamo con colori naturali e falsi colori
par(mfrow=c(1,2), oma= c(3, 3, 2, 2))
plotRGB(Dadia_pre, 4,3,2, stretch="lin")
plotRGB(Dadia_pre, 7,3,2, stretch="lin" )


#esportiamo il grafico 
pdf("Dadia_pre.pdf")
dev.off()



                                                     #IMMAGINI 28 AGOSTO 2023#
#Impostiamo la working directory
setwd("C:/Exam/Dadia_during")

#Creiamo una lista 
list_post <- list.files(pattern="T35TLF_20230828T090559_B")

#Applichiamo la funzione raster 
import_post <- lapply(list_post, raster)

#Uniamo le bande
sen_post <- brick(import_post)

#tagliamo l'immagine 
Dadia_post <- crop(sen_post, ext)

#Visualizziamo le informazioni
Dadia_post

#BANDA 1: BLU
#BANDA 2: VERDE 
#BANDA 3: ROSSA 
#BANDA 5: SWIR 
#BANDA 6: NIR

#Plottiamo con colori naturali e falsi colori
#N.B: Qui manca il livello 1, quindi le bande sono sfalsate 
par(mfrow=c(1,2), oma= c(3, 3, 2, 2))
plotRGB(Dadia_post, 3,2,1, stretch="lin")
plotRGB(Dadia_post, 6,2,1, stretch="lin" )


#esportiamo il grafico 
pdf("Dadia_post.pdf")
dev.off()


#Analizziamo ora le immagini in RGB però inserendo sulla banda del rosso lo SWIR, ovvero l'infrarosso 
#medio, in grado di calcolare la temperatura in superifice per poter determinare l'estensione dell'area 
#dell'incendio; sulla banda del verde invece è posto l'infrarosso vicino (NIR), per poter determinare la presenza
#di piante 

par(mfrow=c(1,3))
plotRGB(Dadia_22, 6,7, 4, stretch="lin")
plotRGB(Dadia_pre, 6,7, 4, stretch="lin")
plotRGB(Dadia_post, 5,6, 3, stretch="lin")

#Esportiamo l'immagine 
pdf("Dadia_SWIR.pdf")
dev.off()







#2. CALCOLO DELLA DVI E NDVI


#CALCOLO DVI 
#DVI = NIR - RED
DVI22 <- Dadia_22[[7]] - Dadia_22[[4]] #7= Banda NIR; #4=Banda rosso. 
DVIpre <- Dadia_pre[[7]] - Dadia_pre [[4]]
DVIpost <- Dadia_post[[6]] - Dadia_post[[3]] #Manca la banda 1 quindi i colori sono sfalsati 

#Creiamo una palette di colori per visualizzare la DVI
clDVI <- colorRampPalette(c("blue4", "aquamarine3", "antiquewhite", "darkred")) (100)

#Plottiamo le immagini della DVI
par(mfrow=c(1,3))
plot(DVI22, col=clDVI, main="DVI nel 2022")
plot(DVIpre, col=clDVI, main="DVI nel 2023 (pre incendio)")
plot(DVIpost, col=clDVI, main="DVI nel 2023 (post incendio)")

#Blu: vegetazione assente 
#Azzurro: vegetazione scarsa 
#giallo: vegetazione presente 
#rosso scuro: vegetazione ottimale 

#Commento: Già dalla DVI si evidenzia un grande aumento di aree caratterizzate da assenza di vegetazione localizzate nel parco nazionale di Dadia a seguito dell'
#incendio di fine Agosto del 2023; si evince anche che sebbene il focolaio principale sia localizzato all'interno del parco la diffusione è stata estremmamente vasta


#Calcolo la NDVI (ovvero la normalized difference vegetation index), ovvero una DVI normalizzata, con valori 
#che sono compresi tra 0 e 1 per visualizzare al meglio la comparazione tra i diversi anni
#NDVI = DVI / (NIR + RED)
#NDVI 

NDVI22 <- DVI22 / (Dadia_22[[7]] + Dadia_22[[4]])
NDVIpre <- DVIpre / (Dadia_pre[[7]] + Dadia_pre[[4]])
NDVIpost <- DVIpost / (Dadia_post[[6]] + Dadia_post[[3]])


#Creiamo una palette di colori per visualizzare al meglio la NDVI
clNDVI <- colorRampPalette(c("chocolate3","khaki2", "olivedrab", "forestgreen")) (100)

#Plottiamo le tre immagini con la NDVI
par(mfrow=c(1,3))
plot(NDVI22, col=clNDVI, main = "NDVI nel 2022")
plot(NDVIpre, col=clNDVI, main = "NDVI nel 2023 (pre incendio)")
plot(NDVIpost, col=clNDVI, main = "NDVI nel 2023 (post incendio)")
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

#Compariamo le immagini della differenza tra il 2022 e il 2023 ed i danni subiti dall'incendio
par(mfrow=c(1,2))
plot(difNDVI_norm, col=cldiff, main ="Differenza NDVI tra il 2022 e 2023")
plot(difNDVI_incendio, col=cldiff, main = "Differenza di NDVI dovuta all'incendio")

#Esportiamo l'immagine 
pdf("Differenza_NDVI")
dev.off ()

#Mostriamo ora l'immagine della differenza totale, ovvero dal 2022 alla situazione post incendio
plot(difNDVI_tot, col=cldiff, main = "Differenza totale NDVI tra il 2022 e 2023 post incendio")

#Le aree verdi indicano che c'è stato un incremento nella vegetazione dall'immagine precedente usata per il confronto
#Le aree bianche indicano assenza di variazione della NDVI 
#Le aree rosa indicano una diminuzione della componente vegetale



#3. CLASSIFICAZIONE 
# Analizziamo la percentuale di copertura vegetale nel corso del tempo 

#Inizio con l'immagine del 2022#
#Estrazione valori dall'immagine 
single_nr_22 <- getValues(Dadia_22)
single_nr_22

#Applichiamo la funzione kmeans che serve per dividere in gruppi omogenei i dati estratti in precedenza
kcluster22 <- kmeans(single_nr_22, centers = 2)

#Set dei valori 
Dadia_22_class <- setValues(Dadia_22[[1]], kcluster22$cluster )


#CLASSE 1: (GIALLO) SUOLO NUDO 
#CLASSE 2: (VEGETAZIONE) VEGETAZIONE PRESENTE 

#Calcoliamo le frequenze
freq_22 <- freq(Dadia_22_class)
freq_22

#Calcoliamo il totale del numero di celle di pixel per fare poi la percentuale
total <- ncell(Dadia_22)

#Calcoliamo la percentuale 
perc_22 <- freq_22 * 100 / total
perc_22

#Nel 2022 abbiamo quindi: 
#Suolo nudo: 36%
#Vegetazione: 64%


#Ripetiamo questa operazione di classificazione anche per gli altri anni 

#2023 pre incendio#
#Estrazione dei valori
single_nr_pre <- getValues(Dadia_pre)

#Utilizziamo la funzione kmeans 
kcluster_pre <- kmeans (single_nr_pre, centers = 2)

#set dei valori 
Dadia_pre_class <- setValues(Dadia_pre[[1]], kcluster_pre$cluster)

#Calcoliamo la frequenza 
freq_pre <- freq(Dadia_pre_class)
perc_pre <- freq_pre * 100 / total
perc_pre

#Nel 2023 pre incendio avremo 
#SUOLO NUDO: 35%
#VEGETAZIONE: 65 %


#2023 post incendio#
#Estrazione dei valori
single_nr_post <- getValues(Dadia_post)

#Utilizziamo la funzione kmeans 
kcluster_post <- kmeans (single_nr_post, centers = 3)

#set dei valori 
Dadia_post_class <- setValues(Dadia_post[[1]], kcluster_post$cluster)

#Calcoliamo la frequenza 
freq_post <- freq(Dadia_post_class)
perc_post <- freq_post * 100 / total
perc_post

#Nel 2023 post incendio è stata aggiunta una classe, ovvero quella dell'area bruciata 
#SUOLO NUDO: 33%
#SUOLO BRUCIATO: 30%
#VEGETAZIONE: 36%

#Plottiamo le tre immagini affiancate 
#Alla terza immagine post incendio è stata aggiunta una classe (ovvero quella dell'area bruciata )
#Dunque è necessario modificare l'ordine di colori della palette per permettere una perfetta conincidenza 
#con le immagini precedenti 


#Carichiamo una palette con 2 colori per distinguere aree verdi da suolo nudo 
clclass <- colorRampPalette(c("yellow4", "darkred")) (100)
clclass2 <- colorRampPalette(c("darkred", "yellow4")) (100)
clclass3 <- colorRampPalette(c("darkorchid4", "yellow4", "darkred")) (100)


par(mfrow=c(1,3))
plot(Dadia_22_class, col=clclass, main = "2022")
plot(Dadia_pre_class, col=clclass2, main ="Pre Incendio")
plot(Dadia_post_class, col=clclass3, main ="Post Incendio")

#Le aree gialle rappresentano la porzione di suolo nudo
#Le aree rosse indicano la porzione con vegetazione 
#Le aree viola indicano il territorio colpito dall'incendio

#Esportiamo l'immagine 
pdf("Classificazione.pdf")
dev.off()

#Creiamo dunque un grafico con le percentuali ottenute per mostrare la percentuale di copertura del suolo per i diversi anni
#Iniziamo dal 2023
#Creiamo un data frame con le informazioni che ci interessano 
cover <- c("Suolo nudo", "Vegetazione", "Terreno bruciato")
percent_22 <- c(35.91, 64.09, 00)
percent_pre <- c(35.19, 64.81, 00)
percent_post <- c(30.95, 36.09, 32.96)

percentages <- data.frame(cover, percent_22, percent_pre, percent_post)
percentages

#Creiamo un grafico a barre con i valori del 2022
Percent_22_g <- ggplot(percentages, aes(x=cover, y=percent_22, fill=cover)) + geom_bar(position = "stack", stat = "identity")+
  labs(title = "Percentuale copertura suolo2022",
       x = "Copertura suolo", y = "Percentuale") + geom_text(aes(label =paste(round(percent_22,2), "%"), vjust = -0.5)) + ylim(c(0,100))

#2023 pre incendio
Percent_pre_g <- ggplot(percentages, aes(x=cover, y=percent_pre, fill=cover)) + geom_bar(position = "stack", stat = "identity")+
  labs(title = "Percentuale copertura suolo 2023",
       x = "Copertura suolo", y = "Percentuale") + geom_text(aes(label =paste(round(percent_pre,2), "%"), vjust = -0.5))+ ylim(c(0,100))

#2023 post incendio
Percent_post_g<- ggplot(percentages, aes(x=cover, y=percent_post, fill=cover)) + geom_bar(position = "stack", stat = "identity")+
  labs(title = "Percentuale copertura suolo post incendio",
       x = "Copertura suolo", y = "Percentuale") + geom_text(aes(label =paste(round(percent_post,2), "%"), vjust = -0.5)) + ylim(c(0,100))

#Andiamo ad affiancare i tre grafici creati grazie alla libreria "patchwork"
Percent_22_g + Percent_pre_g + Percent_post_g

#Esportiamo il grafico 
pdf(Grafico_coperturasuolo.pdf)
dev.off()



#4. CALCOLO INDICE NBR
#L'indice NBR (Normalized burned ratio) è un indice spettrale utilizzato per individuare le aree bruciate 
#Si basa sulla differenza tra le bande del vicino infrarosso (NIR) e quello del medio infrarosso (SWIR)
# NBR = (B08 - B12) / (B08 + B12)
Dadia_post
NBR <- (Dadia_post[[6]] - Dadia_post[[5]]) / (Dadia_post[[6]] + Dadia_post[[5]])

#Creiamo una palette di colori
color <- colorRampPalette(c("black", "darkorange3", "white", "blueviolet")) (100)

#Plottiamo la NBR
plot(NBR, col=color, main="NBR dopo l'incendio") 


#Esportiamo il grafico 
pdf("NBR.pdf")
dev.off()

#Compariamo l'immagine della NDVI con quella della NBR
par(mfrow=c(1,2))
plot(NDVIpost, col=color, main="NDVI")
plot(NBR, col=color, main ="NBR")

#Esportiamo il grafico 
pdf("NDVI_NBR.pdf")
dev.off()
