

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
tt <- read_ods(fich, sheet = 1) |>   
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
inclus <- import1("INCLUSION")
med <- import1("medecins")
question <- import1("QUESTIONNAIRE")
suivi <- import1("suivi")
}