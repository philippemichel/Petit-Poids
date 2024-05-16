

#  ------------------------------------------------------------------------
#
# Title : import petitpoids
#    By : PhM
#  Date : 2024-05-15
#    
#  ------------------------------------------------------------------------

rm(list = ls())
library(baseph)
library(janitor)
library(tidyverse)
library(readODS)
library(lubridate)
library(labelled)

import1 <- function(fich){
  fich <- paste0("datas/",fich,".ods")
tt <- read_ods(fich, sheet = 1, na = c("", " ","NA","D","ND","Non disponible")) |>   
    janitor::clean_names() |> 
    # janitor::remove_empty(c("rows", "cols")) |>
    mutate_if(is.character, as.factor) |> 
    mutate(across(ends_with("dte"), dmy)) 
  bn <- read_ods(fich, sheet = 2) 
  var_label(tt) <- bn$nom
tt <-  janitor::remove_empty(tt, c("rows", "cols")) 
return(tt)
}

importph <- function(){
inclus <- import1("inclusion")
med <- import1("medecin")
quest <- import1("questionnaire")
suivi <- import1("suivi") |> 
mutate(mois = as.character(mois)) |> 
mutate(mois = fct_recode(mois,
    "mois 2" = "2",
    "mois 4" = "4",
    "mois 11" = "11"
  )) |> 
  mutate(mois = fct_relevel(mois,
  "mois 2", "mois 4", "mois 11"
))
tt <- left_join(inclus, quest, by = "subjid") 
save(tt, med, suivi, file = "datas/petitpoids.RData")
}