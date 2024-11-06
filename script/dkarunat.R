## PACKAGES USED ---
library(tidyverse)
conflicted::conflicts_prefer(dplyr::filter())
library(viridis)
# + scale_color/fill_viridis_c/d()
theme_set(theme_light())

## FUNCTION CHALLENGE ---

#Given a dataframe of BOLD data, create a function that returns a dataframe with two columns: "bin_uri" and a new column with the number of unique species per BIN "num_species". The resulting dataframe should only have one row per BIN. Remember to remove NA values. Use the following dataframes as input for your function:

#Reading in data files (after downloading them):
dfMice <- read_tsv("mice_bold_data.txt")

dfWhales <- read_tsv("whale_bold_data.txt")

#Defining the function:
unique_species_per_bin <- function(df) {
  df_cleaned <- df %>% 
    filter(!is.na(bin_uri) & !is.na(species_name)) 
  result <- df_cleaned %>%
    group_by(bin_uri) %>%
    summarize(num_species = n_distinct(species_name)) %>%
    ungroup()
  return(result)
}

#Using function on dfMice and dfWhales:
dfMice %>% unique_species_per_bin
dfWhales %>% unique_species_per_bin


