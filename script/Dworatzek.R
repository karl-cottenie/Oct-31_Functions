#making a function to get the Bin# and the number of species in that bin with each component defined so it can be applied to multiple data sets 

GetBoldData <- function(data, bin_column, species_column) {
  
  # Process the data to count species per bin
  result <- data %>%
    filter(!is.na(.data[[bin_column]])) %>%            # removing rows with NA in bin_uri
    group_by(.data[[bin_column]]) %>%                  # grouping by bin_uri
    summarize(Species_Count = n_distinct(.data[[species_column]]), .groups = 'drop') %>%  # Count distinct species in each bin
    distinct(.data[[bin_column]], .keep_all = TRUE)    # keeping only unique bin_uri rows
  
  return(result)
}

dfMice_final <- GetBoldData(dfMice, bin_column = "bin_uri", species_column = "species_name")
