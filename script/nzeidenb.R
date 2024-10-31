# solution to function problem
library(tidyverse)
library(dplyr)

solveWorldHunger <- function(data_folder = "./Oct-31_Functions/Oct-31_Functions/data/") {
  dfMice <- read_tsv(paste0(data_folder, "/mice.tsv"), show_col_types = FALSE) %>% na.exclude() # remove NAs
  dfWhales <- read_tsv(paste0(data_folder, "/whales.tsv"), show_col_types = FALSE) %>% na.exclude() # ""
  
  # One row per bin URI, with species counts as second column
  dfAll <- rbind(dfMice, dfWhales)  %>% # bind rows (combine dfs)
              group_by(bin_uri) %>% # group by bin_uri
              tally(name = "num_species") # wrapper for summarise(n = n())
}

dfs_bins_nspecies <- solveWorldHunger("./Oct-31_Functions/Oct-31_Functions/data/")

# Proof
View(dfs_bins_nspecies)
