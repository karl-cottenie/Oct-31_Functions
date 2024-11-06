#read in files
dfMice <- read_tsv("data/mice.tsv")
dfWhales <- read_tsv("data/whales.tsv")

#create function
GenerateTable <- function(df) {
  #remove NAs from bin and species name (just to be safe)
  remove_excess <- df |>    
  filter(!is.na(bin_uri), !is.na(species_name))
  
  #group according to bin_uri and return counts based off species name with new column "num_species"
  final <- remove_excess |>
    group_by(bin_uri) |>
    summarise(num_species = n_distinct(species_name)) |>
    ungroup()
  
  return(final)
        
}

#test with sample dfs
GenerateTable(dfMice)
GenerateTable(dfWhales)

#yay :)