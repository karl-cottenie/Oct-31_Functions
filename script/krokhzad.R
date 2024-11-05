
#### FUNCTION CHALLENGES! ----

## Packages used
library(tidyverse)
conflicted::conflicts_prefer(dplyr::filter())
library(viridis)
# + scale_color/fill_viridis_c/d()
theme_set(theme_light())
#install.packages("rfishbase")
library(rfishbase)
# Load necessary library
library(dplyr)


# Obtaining data 
dfMice <- read_tsv("https://v3.boldsystems.org/index.php/API_Public/combined?taxon=Mus&geo=all&format=tsv")[, c("bin_uri",  "species_name")]
write_tsv(dfMice, "mice.tsv")
#Read in the data.
dfMice <- read_tsv("../Data/mice.tsv")


# Define the function
count_species_per_bin <- function(data) {
  data %>%
    filter(!is.na(bin_uri) & !is.na(species_name)) %>% # Remove NA values
    group_by(bin_uri) %>% # Group by BIN
    summarise(num_species = n_distinct(species_name)) %>% # Count unique species
    ungroup()
}

# Apply the function to your data
dfMice <- read_tsv("../Data/mice.tsv")
result <- count_species_per_bin(dfMice)

# Display the result
print(result)
