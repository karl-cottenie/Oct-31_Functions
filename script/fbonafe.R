#FUNCTION CHALLENGES

GetSpecNum <- function(df) {
  result <- df %>% 
    na.omit() %>% 
    group_by(bin_uri) %>% 
    summarise(num_species = n_distinct(species_name))
  return(result)
}