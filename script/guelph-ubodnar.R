## _ Packages used -------
library(tidyverse)
conflicted::conflicts_prefer(dplyr::filter())
library(viridis)
# + scale_color/fill_viridis_c/d()
theme_set(theme_light())
#install.packages("rfishbase")
library(rfishbase)
library(dplyr)


# Load dataframes ---------------------------------------------------------

dfMice <- read_tsv("../data/mice.tsv")
dfWhales <- read_tsv("../data/whales.tsv")

# Given a dataframe of BOLD data, create a function that returns a dataframe with two columns: "bin_uri" and a new column with the number of unique species per BIN "num_species". The resulting dataframe should only have one row per BIN. Remember to remove NA values. Use the following dataframes as input for your function:

getBins <- function(df) {
  newDF <- df |>
    na.omit()
  
  uniqueIDs <- unique(newDF$bin_uri)
  
  binCounts <- map_int(uniqueIDs, function(id) {
    newDF |>
      filter(bin_uri == id) |>
      nrow()
  })
  
  return(data.frame(bin_uri = uniqueIDs, num_species = binCounts))
}

w <- getBins(dfWhales)
m <- getBins(dfMice)
