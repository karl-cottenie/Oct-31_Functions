library(tidyverse)
conflicted::conflicts_prefer(dplyr::filter())
library(viridis)
# + scale_color/fill_viridis_c/d()
theme_set(theme_light())
#install.packages("rfishbase")
library(rfishbase)

dfMice <- read_tsv("https://v3.boldsystems.org/index.php/API_Public/combined?taxon=Mus&geo=all&format=tsv")[, c("bin_uri",  "species_name")]
write_tsv(dfMice, "mice.tsv")
# Read in the data.
dfMice <- read_tsv("../data/mice.tsv")

dfWhales <- read_tsv("https://v3.boldsystems.org/index.php/API_Public/combined?taxon=Delphinidae&geo=all&format=tsv")[, c("bin_uri", "species_name")]
write_tsv(dfWhales, "whales.tsv")
# Read in the data.
dfWhales <- read_tsv("../whales.tsv")

# Function to count unique species per bin_uri
count_species_per_bin <- function(df) {
  df <- na.omit(df)
  
  result <- df %>%
    group_by(bin_uri) %>%
    summarise(num_species = n_distinct(species_name)) %>%
    ungroup()
  
  return(result)
}

# Example usage:
mice_summary <- count_species_per_bin(dfMice)
whale_summary <- count_species_per_bin(dfWhales)

class(whale_summary)
#