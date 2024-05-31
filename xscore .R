

#  ------------------------------------------------------------------------
#
# Title : zscore - création du fichier patients
#    By : 
#  Date : 2024-05-27
#    
#  ------------------------------------------------------------------------

# Incorporation des sexes dans le tableau de suivi.

library(tidyverse)
library(readODS)

sex <- read_ods("datas/sexe-patients.ods") |> 
  janitor::clean_names() |> 
  mutate_if(is.character, as.factor) |> 
  drop_na(sexe) |> 
mutate(sexe = fct_recode(sexe,
  "F" = "Femme",
  "H" = "Homme"
))


suivi <- read_ods("datas/suivi.ods", na = "ND") |> 
  janitor::clean_names() |> 
  mutate_if(is.character, as.factor) 

zscore <- left_join(suivi,sex, by = "subjid") |> 
  drop_na(pds)

save(zscore, file = "datas/zscorex.RData")

#  ------------------------------------------------------------------------
# Calcul des zscores - poids
  


for (i in 1:nrow(zscore)){
# aa <- which(pd$sexe == zscore$sexe[i] & pd$mois == zscore$mois[i])
# pdtm <- pd$pdm[aa]
# pdtsd <- pd$pdsd[aa]
# zscore$zscorepds[i]   <-  (zscore$pds[i] - pdtm) / pdtsd
  zscore$zscorepds[i] <- NA
}

# Calcul des zscores - taille

for (i in 1:nrow(zscore)){
aa <- which(tail$sexe == zscore$sexe[i] & tail$mois == zscore$mois[i])
tdtm <- tail$tm[aa]
tdtsd <- tail$tsd[aa] 
zscore$zscoretaill[i]   <- (zscore$taille[i] - tdtm) / tdtsd
}

# Calcul des zscores - périmètre crânien

for (i in 1:nrow(zscore)){
aa <- which(pc$sexe == zscore$sexe[i] & pc$mois == zscore$mois[i])
pcdtm <- pc$pcm[aa]
pcdtsd <- pc$pcsd[aa]
zscore$zscorepc[i] <- (zscore$pc[i] - pcdtm) / pcdtsd
}

save(zscore, file = "datas/zscore.RData")


