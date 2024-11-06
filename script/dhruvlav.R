##SOLUTION

dfMice <- read_tsv("./data/mice.tsv")
dfWhales <- read_tsv("./data/whales.tsv")

fn_uniqueSpecies <- function(df) {
  df_unique <- df %>%
    filter(!is.na(bin_uri)) %>%  
    filter(!is.na(species_name)) %>%  
    group_by(bin_uri) %>%  
    summarize(num_species = n_distinct(species_name)) 
  
  return(df_unique)
}


dfMice_summary <- fn_uniqueSpecies(dfMice)
dfWhales_summary <- fn_uniqueSpecies(dfWhales)


head(dfMice_summary)
head(dfWhales_summary)
