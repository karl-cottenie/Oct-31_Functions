#creating my own code for the Functions class

## _ Packages used -------
library(tidyverse)
conflicted::conflicts_prefer(dplyr::filter())
library(viridis)
# + scale_color/fill_viridis_c/d()
theme_set(theme_light())

dfMice <- read_tsv("../data/mice.tsv")
dfNew <- function(dfMice) {
  dfMice %>%
    filter(!is.na(bin_uri) & !is.na(species_name)) %>%
    distinct(bin_uri, species_name) %>%                
    count(bin_uri, name = "num_species")
}
resultsMice <- dfNew(dfMice)
view(resultsMice)



dfWhales <- read_tsv("../data/whales.tsv")
dfNew2 <- function(dfWhales) {
  dfWhales %>%
    filter(!is.na(bin_uri) & !is.na(species_name)) %>%
    distinct(bin_uri, species_name) %>%                
    count(bin_uri, name = "num_species")
}
resultsWhales <- dfNew2(dfWhales)
view(resultsWhales)
