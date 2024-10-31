dfMice <- read_tsv("../data/mice.tsv")
dfWhales <- read_tsv("../data/whales.tsv")


count_unique_species_per_bin <- function(bold_data) {
  
  result <- bold_data %>%
    filter(!is.na(bin_uri)) %>% 
    filter(!is.na(species_name)) %>%
    group_by(bin_uri) %>%
    summarize(num_species = n_distinct(species_name))  
  return(result)
}

Results_mice = count_unique_species_per_bin(dfMice)
Results_whale = count_unique_species_per_bin(dfWhales)
