#creating my own code for the Functions class

## _ Packages used -------
library(tidyverse)
conflicted::conflicts_prefer(dplyr::filter())
library(viridis)
# + scale_color/fill_viridis_c/d()
theme_set(theme_light())

dfMice <- read_tsv("../data/mice.tsv")
dfNew1 <- dfMice %>%
  filter(!is.na(bin_uri) & !is.na(species_name)) %>%
  distinct(bin_uri, species_name) %>%
  count(bin_uri, name = "num_species")

dfWhales <- read_tsv("../data/whales.tsv")
dfNew2 <- dfWhales %>%
  filter(!is.na(bin_uri) & !is.na(species_name)) %>%
  distinct(bin_uri, species_name) %>%
  count(bin_uri, name = "num_species")