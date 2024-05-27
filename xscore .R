

#  ------------------------------------------------------------------------
#
# Title : Xscore    
#    By : 
#  Date : 2024-05-27
#    
#  ------------------------------------------------------------------------

# Incorporation des sexes dns le tableau de suivi.

library(tidyverse)
library(readODS)

sex <- read_ods("datas/sexe-patients.ods") |> 
  janitor::clean_names() |> 
  mutate_if(is.character, as.factor) 

suivi <- read_ods("datas/suivi.ods", na = "ND") |> 
  janitor::clean_names() |> 
  mutate_if(is.character, as.factor) 

xscore <- left_join(suivi,sex, by = "subjid") |> 
  drop_na(pds)
