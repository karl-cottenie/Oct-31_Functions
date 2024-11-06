## _ Packages used -------
library(tidyverse)
conflicted::conflicts_prefer(dplyr::filter())
library(viridis)
# + scale_color/fill_viridis_c/d()

# Writing the function
count_unique <- function(data) {
  data %>%
    filter(!is.na(bin_uri)) %>% # Remove NA values in 'bin_uri'
    group_by(bin_uri) %>% # Group by 'bin_uri'
    summarize(num_species = n_distinct(species_name)) %>% # Count unique species
    ungroup() # Ungroup the data frame
}

# Read in the data

dfMice <- read_tsv("data/mice.tsv")
dfWhales <- read_tsv("data/whales.tsv")

# Apply the function to each data frame
mice_count <- count_unique(dfMice)
whales_count <- count_unique(dfWhales)

# Display the results
print(mice_count)
print(whales_count)

#4- Create a branch -----
usethis::pr_init(branch = "Pavani")

# Check Current local branch 
usethis::git_sitrep()

# Submit pull request

usethis::pr_push()


