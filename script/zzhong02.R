library(tidyverse)
library(viridis)
# Given a dataframe of BOLD data, create a function that returns a dataframe with two columns: "bin_uri" and a new column with the number of unique species per BIN "num_species". The resulting dataframe should only have one row per BIN. Remember to remove NA values. Use the following dataframes as input for your function:

dfMice <- read_tsv("../data/mice.tsv")
dfWhales <- read_tsv("../data/whales.tsv")

#Work the steps through on one data first
dfMice <- dfMice %>% 
  filter(!is.na(bin_uri)) %>% 
  group_by(species_name, bin_uri) %>% 
  count() %>% 
  mutate()

num_species <- dfMice$n
BIN <- dfMice$bin_uri

dfBOLD <- as.data.frame(cbind(num_species, BIN))

view(dfBOLD)



#Here is the function I created
GetdfInfo <- function(trait) {
  trait <- trait %>% 
    filter(!is.na(bin_uri)) %>% 
    group_by(species_name, bin_uri) %>% 
    count() %>% 
    mutate()
  
  num_species <- trait$n
  BIN <- trait$bin_uri
  
  dfBOLD <- as.data.frame(cbind(num_species, BIN))
  
  view(dfBOLD)
}

#Testing my function with another data 
GetdfInfo(dfWhales)

