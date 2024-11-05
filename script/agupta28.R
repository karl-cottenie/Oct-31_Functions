#### FUNCTION CHALLENGES! ----

# Given a dataframe of BOLD data, create a function that returns a dataframe with two columns: "bin_uri" and a new column with the number of unique species per BIN "num_species". The resulting dataframe should only have one row per BIN. Remember to remove NA values. Use the following dataframes as input for your function:

# How I obtained the mice data on November 3rd, 2021:
#dfMice <- read_tsv("http://www.boldsystems.org/index.php/API_Public/combined?taxon=Mus&geo=all&format=tsv")[, c("bin_uri",  "species_name")]
#write_tsv(dfMice, "mice.tsv")
# Read in the data.
dfMice <- read_tsv("../data/mice.tsv")

# How I obtained the whale data on November 3rd, 2021:
#dfWhales <- read_tsv("http://www.boldsystems.org/index.php/API_Public/combined?taxon=Delphinidae&geo=all&format=tsv")[, c("bin_uri", "species_name")]
#write_tsv(dfWhales, "whales.tsv")
# Read in the data.
dfWhales <- read_tsv("../data/whales.tsv")


# Define the function
count_species_per_bin <- function(df) {
  df %>%
    filter(!is.na(bin_uri) & !is.na(species_name)) %>%
    group_by(bin_uri) %>%
    summarize(num_species = n_distinct(species_name)) %>%
    ungroup()
}

# Apply the function to the mice and whale data
dfMice_result <- count_species_per_bin(dfMice)
dfWhales_result <- count_species_per_bin(dfWhales)

# Display results
dfMice_result
dfWhales_result
