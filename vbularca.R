# Function that counts the unique species per BIN: 

count_unique_species_per_bin <- function(df) {
  df %>%
    filter(!is.na(bin_uri) & !is.na(species_name)) %>% 
    group_by(bin_uri) %>%
    summarise(num_species = n_distinct(species_name))
}

# Using this on the data sets provided:
result_df_Mice <- count_unique_species_per_bin(dfMice)
result_df_Whale <- count_unique_species_per_bin(dfWhales)

