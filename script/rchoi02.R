# Load necessary libraries
library(dplyr)
library(readr)

setwd("./script")

# Created a function where we removed the rows with NA values in bin_uri and species_name and counted unique species per bin_uri
count_species_per_bin <- function(df) {
  df %>%
    filter(!is.na(bin_uri) & !is.na(species_name)) %>%
    group_by(bin_uri) %>%
    summarize(num_species = n_distinct(species_name)) %>%
    ungroup()
}

# Read in the mice and and whale datasets
dfMice <- read_tsv("./data/mice.tsv")
dfWhales <- read_tsv("./data/whales.tsv")

# Applied function to dataframes
resultMice <- count_species_per_bin(dfMice)
resultWhales <- count_species_per_bin(dfWhales)

# Checked results
print(resultMice)
print(resultWhales)

# Combined the two dataframes and grouped by bin_uri (in case of overlapping)
micewhales_combined <- bind_rows(resultMice, resultWhales) %>%
  group_by(bin_uri) %>%
  summarize(num_species = sum(num_species)) %>%
  ungroup()

# Checked the final combined result
print(micewhales_combined)
