## In Class Coding Challenge: Functions!

# Instructions
# Given a dataframe of BOLD data, create a function that returns a dataframe with two columns: "bin_uri" and a new column with the number of unique species per BIN "num_species". The resulting dataframe should only have one row per BIN. Remember to remove NA values.

#Libraries
library(tidyverse)
library(viridis)

# Data Files
dfMice <- read_tsv("../data/mice.tsv")
dfWhales <- read_tsv("../data/whales.tsv")

# Unique BIN Function
unique_bin <- function(df){
  filtered_data <- df[!is.na(df$bin_uri) & !is.na(df$species_name), ] #Filter data
  
  #Obtain bin and species number
  results <- filtered_data %>%
    group_by(bin_uri) %>%
    summarise(num_species = n_distinct(species_name)) %>%
    ungroup()
}

# Running Function
mice_unique_species_df <- unique_bin(dfMice)
whale_unique_species_df <- unique_bin(dfWhales)

# Print out to Console
print(mice_unique_species_df)
print(whale_unique_species_df)
