library(dplyr)
library(readr)
library(rgbif)

#Lista de especies a descargar#

lista <- read.csv("lista_abejas.csv", header=T)

# match the names
gbif_taxon_keys <- lista %>%
head(1000) %>% # only first 1000 names
name_backbone_checklist() %>% # match to backbone
filter(!matchType == "NONE") %>% # get matched names
pull(usageKey)

# gbif_taxon_keys should be a long vector like this c(2977832,2977901,2977966,2977835,2977863)

# download the data
occ_download(
pred_in("taxonKey", gbif_taxon_keys), # important to use pred_in
pred("hasCoordinate", TRUE),
pred("hasGeospatialIssue", FALSE),
format = "SIMPLE_CSV"
)



