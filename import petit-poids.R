#  ------------------------------------------------------------------------
#
# Title : Import Petit poids
#    By : PhM
#  Date : 2026-06-18
#
#  ------------------------------------------------------------------------

library(baseph)
library(janitor)
library(readODS)
library(lubridate)
library(tidyverse)
library(labelled)


nn <- c("", " ", "NA", "K", "D", "Non disponible")

# Naissance

naiss <- read_ods("datas/NAISSANCE.ods", sheet = 1, na = nn) |>
  clean_names() |>
  mutate(across(ends_with("dte"), dmy)) |>
  mutate(across(is.character, as.factor))

bn <- read_ods("datas/NAISSANCE.ods", sheet = 2, na = nn)
var_label(naiss) <- bn$nom

# Sortie

sortie <- read_ods("datas/SORTIE.ods", sheet = 1, na = nn) |>
  clean_names() |>
  mutate(across(ends_with("dte"), dmy)) |>
  mutate(across(is.character, as.factor))

bn <- read_ods("datas/SORTIE.ods", sheet = 2, na = nn)
var_label(sortie) <- bn$nom

# Parents

p1 <- read_ods("datas/PARENT_1.ods", sheet = 1, na = nn) |>
  clean_names() |>
  mutate(across(ends_with("dte"), dmy)) |>
  mutate(across(is.character, as.factor)) |>
  mutate(subjid2 = paste(subjid, str_sub(visit, -4), sep = "_"))

bn <- read_ods("datas/PARENT_1.ods", sheet = 2, na = nn)
var_label(p1) <- c(bn$nom, "id")

p2 <- read_ods("datas/PARENT_2.ods", sheet = 1, na = nn) |>
  clean_names() |>
  mutate(across(is.character, as.factor)) |>
  mutate(subjid2 = paste(subjid, str_sub(visit, -4), sep = "_")) |>
  dplyr::select(-visit)

bn <- read_ods("datas/PARENT_2.ods", sheet = 2, na = nn)
var_label(p2) <- c(bn$nom, "id")

p3 <- read_ods("datas/PARENT_3.ods", sheet = 1, na = nn) |>
  clean_names() |>
  mutate(across(ends_with("dte"), dmy)) |>
  mutate(across(is.character, as.factor)) |>
  mutate(subjid2 = paste(subjid, str_sub(visit, -4), sep = "_")) |>
  dplyr::select(-visit)

bn <- read_ods("datas/PARENT_3.ods", sheet = 2, na = nn)
var_label(p3) <- c(bn$nom, "id")

parents <- left_join(p1, p2, by = "subjid2") |>
  left_join(p3, by = "subjid2") |>
  janitor::remove_empty(c("rows", "cols"))

# Visites

v2m <- read_ods("datas/2MOIS.ods", sheet = 1, na = c("", " ", "NA", "K", "D", "Non disponible")) |>
  clean_names() |>
  mutate(across(ends_with("dte"), dmy)) |>
  mutate(across(is.character, as.factor)) |>
  mutate(visite = "2 mois")

v4m <- read_ods("datas/4MOIS.ods", sheet = 1, na = c("", " ", "NA", "K", "D", "Non disponible")) |>
  clean_names() |>
  mutate(across(ends_with("dte"), dmy)) |>
  mutate(across(is.character, as.factor)) |>
  mutate(visite = "4 mois")

v11m <- read_ods("datas/11MOIS.ods", sheet = 1, na = c("", " ", "NA", "K", "D", "Non disponible")) |>
  clean_names() |>
  mutate(across(ends_with("dte"), dmy)) |>
  mutate(across(is.character, as.factor)) |>
  mutate(visite = "11 mois")


visites <- bind_rows(v2m, v4m, v11m) |>
  janitor::remove_empty(c("rows", "cols")) |>
  mutate(subjid = paste(subjid, str_sub(visite, -4), sep = "_"))

bn <- read_ods("datas/2MOIS.ods", sheet = 2, na = nn)
var_label(visites) <- c(bn$nom, "visite")

# Médecins

medecins <- read_ods("datas/Medecins.ods", sheet = 1, na = nn) |>
  clean_names()


risques <- str_split(medecins$risques, ";", simplify = TRUE)

rr <- c(
  risques[, 1], risques[, 2], risques[, 3], risques[, 4], risques[, 5], risques[, 6], risques[, 7],
  risques[, 8]
) |>
  tibble()
names(rr) <- "risques"
rr <- rr |>
  filter(risques != "") |>
  mutate(risques = as.factor(risques))

# Final

save(naiss, sortie, parents, visites, medecins, rr, file = "datas/petitpoids.RData")
load("datas/petitpoids.RData")
