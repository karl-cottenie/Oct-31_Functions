
#### FUNCTION CHALLENGES! ----

# Given a dataframe of BOLD data, create a function that returns a dataframe with two columns: "bin_uri" and a new column with the number of unique species per BIN "num_species". The resulting dataframe should only have one row per BIN. Remember to remove NA values. Use the following dataframes as input for your function:

Unique_SpecBins <- function(dataframe){
  newDf <- dataframe %>%
    filter(!is.na(bin_uri))
  newDf <- data.frame(table(bin_uri))
  
  names(newDf) <- c("bin_uri", "num_species")
  
  return(newDf)
}

# How I obtained the mice data on November 3rd, 2021:
dfMice <- read_tsv("http://www.boldsystems.org/index.php/API_Public/combined?taxon=Mus&geo=all&format=tsv")[, c("bin_uri",  "species_name")]
write_tsv(dfMice, "mice.tsv")
# Read in the data.
dfMice <- read_tsv("../data/mice.tsv")

# How I obtained the whale data on November 3rd, 2021:
#dfWhales <- read_tsv("http://www.boldsystems.org/index.php/API_Public/combined?taxon=Delphinidae&geo=all&format=tsv")[, c("bin_uri", "species_name")]
#write_tsv(dfWhales, "whales.tsv")
# Read in the data.
dfWhales <- read_tsv("../data/whales.tsv")

Unique_SpecBins(dfMice)
Unique_SpecBins(dfWhales)

