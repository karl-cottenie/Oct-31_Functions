#*****************************************
#              Quiz #7
#
#             Yasmine Hezema
#
#*****************************************

## -1-Packages used ---------
library(tidyverse)
conflicted::conflicts_prefer(dplyr::filter())
library(viridis)
library(dplyr)


# 2- Challenge -----
# Given a dataframe of BOLD data, create a function that returns a dataframe with two columns: "bin_uri" and a new column with the number of unique species per BIN "num_species". The resulting dataframe should only have one row per BIN. Remember to remove NA values. Use the following dataframes as input for your function:

# How I obtained the mice data on November 3rd, 2021:
# dfMice <- read_tsv("http://www.boldsystems.org/index.php/API_Public/combined?taxon=Mus&geo=all&format=tsv")[, c("bin_uri",  "species_name")]
# write_tsv(dfMice, "mice.tsv")
# Read in the data.
#dfMice <- read_tsv("../data/mice.tsv")

# How I obtained the whale data on November 3rd, 2021:
# dfWhales <- read_tsv("http://www.boldsystems.org/index.php/API_Public/combined?taxon=Delphinidae&geo=all&format=tsv")[, c("bin_uri", "species_name")]
# write_tsv(dfWhales, "whales.tsv")
# Read in the data.
#dfWhales <- read_tsv("../data/whales.tsv")


# 3- Solution ----

# The function
count_unique_species <- function(data) {
  data %>%
    filter(!is.na(bin_uri)) %>% # Remove NA values in 'bin_uri'
    group_by(bin_uri) %>% # Group by 'bin_uri'
    summarize(num_species = n_distinct(species_name)) %>% # Count unique species
    ungroup() # Ungroup the data frame
}

# Read in the data
dfMice <- read_tsv("../data/mice.tsv")
dfWhales <- read_tsv("../data/whales.tsv")

# Apply the function to each data frame
result_mice <- count_unique_species(dfMice)
result_whales <- count_unique_species(dfWhales)

# Display the results
print(result_mice)
# print(result_whales)

#4- Create a branch -----
usethis::pr_init(branch = "Yasmine_code")

# Check that Git local (project) Current local branch is Yasmine_code
usethis::git_sitrep()

# Submit pull request

usethis::pr_push()
