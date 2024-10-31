
#Filter NAs from df, create a dataframe from unique bin values, rename columns
two_column_creation <- function(df) {
  resulting_df <- df %>%
    filter(!is.na(bin_uri))
  resulting_df <- data.frame(table(resulting_df$bin_uri))
  names(resulting_df) <- c("bin_uri", "num_species")
  return(resulting_df)
}

df_M <- two_column_creation(dfMice)
df_W <- two_column_creation(dfWhales)