species_per_bin <- function(df) {
  library(tidyverse)
  filtered_df <- df %>% 
    filter(!is.na(bin_uri)) %>% 
    filter(!is.na(species_name)) %>% 
    group_by(bin_uri) %>% 
    summarise(num_species = n_distinct(species_name))
  View(filtered_df)
}

species_per_bin(dfMice)
species_per_bin(dfWhales)