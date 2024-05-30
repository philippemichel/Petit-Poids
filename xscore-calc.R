

#  ------------------------------------------------------------------------
#
# Title : Normes xscore
#    By : PhM
#  Date : 2024-05-23
#    
#  ------------------------------------------------------------------------



mois <- rep(c(2,4,11),2)
sexe <- c(rep("F",3),rep("H",3))
# Périmètre crânien - filles
pcfm <- c(38.6,41,45.5)
pcfsd <- c(37.7,39.8,43.9)
pcfsd <- pcfm-pcfsd
# Périmètre crânien - Garçon
pcgm <- c(39.4,42,41.6)
pcgsd <- c(38.2,41,45.2)
pcgsd <- pcgm-pcgsd
# Périmètre crânien - total
pcm <- c(pcfm,pcgm)
pcsd <- c(pcfsd,pcgsd)
pc <- tibble(mois,sexe,pcm,pcsd)
#
# Poids - filles
pdfm <- c(5,6.6,9)
pdfsd <- c(4.6,5.9, 7.8)
pdfsd <- pdfm-pdfsd
# Poids - Garçon
pdgm <- c(5.3,6.8,9.6)
pdgsd <- c(4,6.4,9)
pdgsd <- pdgm-pdgsd
# Poids - total
pdm <- c(pdfm,pdgm)
pdsd <- c(pdfsd,pdgsd)
pd <- tibble(mois,sexe,pdm,pdsd)
#
# Taille - filles
tfm <- c(56.5,62,73)
tfsd <- c(54.5,60,70.5)
tfsd <- tfm-tfsd
# Taille - Garçon
tgm <- c(57.5,63.5,74.4)
tgsd <- c(55.5,61.3,72)
tgsd <- tgm-tgsd
# Taille - total
tm <- c(tfm,tgm)
tsd <- c(tfsd,tgsd)
tail <- tibble(mois,sexe,tm,tsd)

save(pc,pd,tail, file = "datas/xscore.RData")
