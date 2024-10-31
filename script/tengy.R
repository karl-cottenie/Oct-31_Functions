library(tidyverse)
conflicted::conflicts_prefer(dplyr::filter())
library(viridis)
library(dplyr)

dfMice <- read_tsv("../data/mice.tsv")
dfWhales <- read_tsv("../data/whales.tsv")
  
BIN_unique <- function(df) {
  df_BIN_count <- df %>% 
    drop_na() %>%
    group_by(bin_uri) %>%
    summarise(num_species = n()) %>%
    ungroup() 
  
  return(df_BIN_count)
   }
  
result_Mice <- BIN_unique(dfMice)
result_Whales <- BIN_unique(dfWhales)
