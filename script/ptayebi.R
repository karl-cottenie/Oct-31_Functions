#Given a dataframe of BOLD data, create a function that returns a dataframe with two columns: "bin_uri" and a new column with the number of unique species per BIN "num_species". The resulting dataframe should only have one row per BIN. Remember to remove NA values. Use the following dataframes as input for your function:

library(dplyr)
library(usethis)
unique_species_per_bin <- function(df_mice) {
  
  df_mice <- read.csv("/Users/paniztayebi/Library/Mobile Documents/com~apple~CloudDocs/Documents/University of Guelph/BINF*6210/Oct-31_Functions/data/mice.tsv", sep = "\t", stringsAsFactors = FALSE)
  
  df_mice <- df_mice %>%
    filter(!is.na(bin_uri), !is.na(species_name))
  
  df_mice <- df_mice %>%
    group_by(bin_uri) %>%
    summarize(num_species = n_distinct(species_name)) %>%
    ungroup()
  
  return(df_mice)
}

df_mice <- unique_species_per_bin("/Users/paniztayebi/Library/Mobile Documents/com~apple~CloudDocs/Documents/University of Guelph/BINF*6210/Oct-31_Functions/data/mice.tsv")


