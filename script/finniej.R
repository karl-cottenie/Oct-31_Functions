#### FUNCTION CHALLENGES! ----
# Jessica Finnie!

library(tidyverse)
conflicted::conflicts_prefer(dplyr::filter())
library(viridis)
# + scale_color/fill_viridis_c/d()
theme_set(theme_light())
#install.packages("rfishbase")

dfMice <- read_tsv("./data/mice.tsv")

dfWhales <- read_tsv("./data/whales.tsv")

NumberOfBins <- function(dfinput){
  result <- dfinput %>%
    filter(!is.na(dfinput$bin_uri))
  
  result <- result %>% 
    group_by(bin_uri) %>%
    count(bin_uri) %>% 
    mutate(num_species = n) %>% 
    mutate(n = NULL)
  
  return(result)
}

dfWhalesFinal <- NumberOfBins(dfWhales)
dfMiceFinal <- NumberOfBins(dfMice)

