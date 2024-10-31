# This is the beginning of Coleman Eagle Olenick's Solution to the attached script

# Desired Function Description:
# Given a dataframe of BOLD data, create a function that returns a dataframe with two columns: "bin_uri" and a new column with the number of unique species per BIN "num_species". The resulting dataframe should only have one row per BIN. Remember to remove NA values. Use the following dataframes as input for your function:

setwd("./script")
# Data Import:
dfMice <- read_tsv("../data/mice.tsv")
dfWhales <- read_tsv("../data/whales.tsv")
dfCombined <- rbind(dfMice,dfWhales)

Example_Function <- function(df) {
  # Check that dataframe is BOLD as expected
  if ((ncol(df) != 2) || !all(colnames(df) == c("bin_uri", "species_name"))) {
    stop("Please only use a BOLD dataframe with 2 columns: 'bin_uri' and 'species_name'")
  }
  
  df.ret = df %>% 
    drop_na() %>%
    distinct(bin_uri,species_name) %>%
    count(bin_uri)
  
  colnames(df.ret) = c("bin_uri","num_species")
  return(df.ret)
}

df.test.Mice = Example_Function(dfMice)
df.test.Whales = Example_Function(dfWhales)
df.test.Combined = Example_Function(dfCombined)
