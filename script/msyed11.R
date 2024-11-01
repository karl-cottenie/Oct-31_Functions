#loading data
dfMice <- read_tsv("./data/mice.tsv")
dfWhales <- read_tsv("./data/whales.tsv")
#creating a funciton
Filter <- function(dat){
  filtered_data <- dat %>% 
    select(bin_uri, species_name) %>%                  
    filter(!is.na(bin_uri)) %>%                        
    group_by(bin_uri) %>%                               
    summarise(num_species = n_distinct(species_name)) %>%  
    ungroup() %>% 
    as.data.frame()
}

#Testing function on the 2 datasets (Mice first)
Filtered_dat_mice <- Filter(dfMice)
#checking class to ensure its a dataframe
class(Filtered_dat_mice)
#checking for whale
Filtered_dat_whale <- Filter(dfWhales)
#checking class
class(Filtered_dat_whale)
