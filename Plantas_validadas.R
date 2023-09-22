#Unir nombres de plantas validados a archivos de plantas#

#librerias
library(dplyr)

#Cargar listado de plantas#

Plantas <- read.csv("2da_lista_de_spp.csv", header =TRUE)

#Extraemos columnas de interés#
Plantas2 <- subset(Plantas, select=c(searched_taxon_name, target_taxon_name,	country_name,	Estatus.Taxonómico,	Nombre.Válido,	Autoridad,	Rango.Taxonómico,	Familia,	Forma.biológica
))

#Cargamos plantas por abeja#
AGAANG <-read.csv("AGAANG.csv")

#Extraemos plantas para esta abeja del listado completo de plantas
AGAANG$target_taxon_name %in% Plantas2$searched_taxon_name

#Establecemos un criterio para extraer las plantas de interés del listado#
Criterio1 <-AGAANG$target_taxon_name[AGAANG$target_taxon_name %in% Plantas2$searched_taxon_name==TRUE]


#Extraemos las plantas de interés del listado
AGAANG2 <-Plantas2[Plantas2$searched_taxon_name %in% Criterio1, ]

#Unimos las columnas de interés al listado de plantas de esa abeja#
merge(x = AGAANG, y = AGAANG2)
AGAANG2<-merge(x = AGAANG, y = AGAANG2, by = c("target_taxon_name"), all.x = T) # Equivalente

#Generamos archivo .csv#
write.csv(AGAANG2, "AGAANG2.csv")
