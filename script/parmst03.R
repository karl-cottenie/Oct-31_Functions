### Quiz 7 - Challenge Solution
### Phoenix Armstrong

# load packages
library(tidyverse)
conflicted::conflicts_prefer(dplyr::filter())
library(viridis)

# load mice and whales data
dfMice <- read_tsv("../data/mice.tsv")
dfWhales <- read_tsv("../data/whales.tsv")

countspecies <- function(data = list(dfMice, dfWhales)) { # input = any number of dataframes as a list or dataframe

  if (sum(class(data) == "list")) {
    data <- do.call(rbind, data) 
  }
  
  combined <- data %>%
    filter(!is.na(bin_uri)) %>%
    distinct(bin_uri, species_name) %>%
    count(bin_uri)
  
  return(combined)
}