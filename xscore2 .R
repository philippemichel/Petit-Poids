

#  ------------------------------------------------------------------------
#
# Title : Z-Score - création du fichier patients
#    By :PhM
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
  mutate(sexe = fct_recode(sexe, "F" = "Femme", "H" = "Homme"))


suivi <- read_ods("datas/suivi.ods", na = "ND") |>
  janitor::clean_names() |>
  mutate_if(is.character, as.factor)

xscore <- left_join(suivi, sex, by = "subjid") |>
  drop_na(pds)

save(xscore, file = "datas/xscorex.RData")

#  ------------------------------------------------------------------------
# Calcul des zscores - poids



for (i in 1:nrow(xscore)) {
  aa <- which(pd$sexe == xscore$sexe[i] & pd$mois == xscore$mois[i])
  pdtm <- pd$pdm[aa]
  pdtsd <- pd$pdsd[aa]
  xscore$zscorepds[i]   <-  (xscore$pds[i] - pdtm) / pdtsd
}

# Calcul des zscores - taille

for (i in 1:nrow(xscore)) {
  aa <- which(tail$sexe == xscore$sexe[i] &
                tail$mois == xscore$mois[i])
  tdtm <- tail$tm[aa]
  tdtsd <- tail$tsd[aa]
  xscore$zscoretaill[i]   <- (xscore$taille[i] - tdtm) / tdtsd
}

# Calcul des zscores - périmètre crânien

for (i in 1:nrow(xscore)) {
  aa <- which(pc$sexe == xscore$sexe[i] & pc$mois == xscore$mois[i])
  pcdtm <- pc$pcm[aa]
  pcdtsd <- pc$pcsd[aa]
  xscore$zscorepc[i] <- (xscore$pc[i] - pcdtm) / pcdtsd
}