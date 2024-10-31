# Coding Challenge 
library(dbplyr)
Species_in_each_BIN <- function(df) {
  df %>%
    filter(!is.na(bin_uri) & !is.na(species_name)) %>% # Remove NA values in bin_uri and species_name
    group_by(bin_uri) %>%
    summarise(num_species = n_distinct(species_name))
}

results_Mice <- Species_in_each_BIN(dfMice)
results_Whale <- Species_in_each_BIN(dfWhale)


