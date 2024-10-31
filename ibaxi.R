
#### FUNCTION CHALLENGE 
# October 31, 2024

# Libraries
library(dplyr)

# Function to count unique species per BIN
count_unique_species_per_bin <- function(df) {
  df %>%
    filter(!is.na(bin_uri) & !is.na(species_name)) %>% 
    group_by(bin_uri) %>%
    summarise(num_species = n_distinct(species_name))
  }

# Example usage:
result_df_Mice <- count_unique_species_per_bin(dfMice)
result_df_Whale <- count_unique_species_per_bin(dfWhales)


         
           
           

  
