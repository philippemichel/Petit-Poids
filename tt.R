suivi |> 
  drop_na(zscorepds) |> 
  group_by(mois) |> 
 count(mois)

quest |> 
  drop_na(q11_rgo_on) |> 
  group_by(parent) |> 
  count(q11_rgo_on)