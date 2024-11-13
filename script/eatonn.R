#### FUNCTION CHALLENGES! ----

# Given a dataframe of BOLD data, create a function that returns a dataframe with two columns: "bin_uri" and a new column with the number of unique species per BIN "num_species". The resulting dataframe should only have one row per BIN. Remember to remove NA values. Use the following dataframes as input for your function:

# How I obtained the mice data on November 3rd, 2021:
#dfMice <- read_tsv("http://www.boldsystems.org/index.php/API_Public/combined?taxon=Mus&geo=all&format=tsv")[, c("bin_uri",  "species_name")]
#write_tsv(dfMice, "mice.tsv")
# Read in the data.
dfMice <- read_tsv("data/mice.tsv")

# How I obtained the whale data on November 3rd, 2021:
#dfWhales <- read_tsv("http://www.boldsystems.org/index.php/API_Public/combined?taxon=Delphinidae&geo=all&format=tsv")[, c("bin_uri", "species_name")]
#write_tsv(dfWhales, "whales.tsv")
# Read in the data.
dfWhales <- read_tsv("data/whales.tsv")

make_new_df<-function(df) {
  
  new_df<-df%>%
    filter(!is.na(bin_uri))%>%
    filter(!is.na(species_name))%>%
    group_by(bin_uri)%>%
    count(species_name)%>%
    select(c(bin_uri,n))%>%
    rename(num_species=n)
  
  return(new_df)
}

new_df_whales<-make_new_df(dfWhales)
new_df_whales
new_df_mice<-make_new_df(dfMice)
new_df_mice