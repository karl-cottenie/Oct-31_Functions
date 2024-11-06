##***************************
##  Software Tools - Functions
##
## Karl Cottenie
##
## 2024-10-30
##
##***************************

## _ Packages used -------
library(tidyverse)
conflicted::conflicts_prefer(dplyr::filter())
library(viridis)
# + scale_color/fill_viridis_c/d()
theme_set(theme_light())
#install.packages("rfishbase")
library(rfishbase)

# Startup ends here

# Author: Jacqueline May
#Revisions by Jessica Castellanos-Labarcena. October 31st, 2023
#Revisions by Karl Cottenie, October 30, 2024

# This is a tutorial for creating functions in R!

#### BASIC EXAMPLE FUNCTIONS ----

# Let's create a function called MultiplyNumbers1(). It takes two arguments (x and y) and multiplies them.

# Use the keyword function to define it.
MultiplyNumbers1 <- function(x, y) {  ## x and y are our formal arguments

  product <- x*y  ## We are assigning the result to a variable within the function.
  
  return(product)  ## Returns product variable to the global environment.
  
}

formals(MultiplyNumbers1)  ## Formal arguments for function
body(MultiplyNumbers1)  ## Code inside function

# Notice the function appeared in your environment. You can click on it to inspect its contents, or type MultiplyNumbers1.
MultiplyNumbers1

# Once you have defined your function, you can use it!
MultiplyNumbers1(5, 2)  ## Our formal arguments, x and y, are assigned 5 and 2 in this case
MultiplyNumbers1(154, 180506)

# When you specify the name of the argument, the order doesn't matter! For example:
MultiplyNumbers1(10, 7)  ## Names not specified.
MultiplyNumbers1(x = 10, y = 7)  ## Names specified.
MultiplyNumbers1(y = 7, x = 10)  ## Order changed.
MultiplyNumbers1(x = 10, 7)  ## You can just name one. Named arguments are matched first and then it is based on position.
MultiplyNumbers1(7, x = 10) 

# Assigning default arguments in your function.
# Here, we specify 100 as the default value for y. This means that entering a value for y is optional for the user.
MultiplyNumbers2 <- function(x, y = 100) {

  product <- x*y
  
  return(product)
  
}

MultiplyNumbers2(5)  ## 100 is our default value for y.
MultiplyNumbers2(5, y = 10)  ## We change the value for y here.

# Can we apply the function to a numeric vector?
x <- rnorm(10)
x
MultiplyNumbers2(x)  ## Yes! This function is vectorized, meaning you can apply it across a vector of values.

# What happens when we don't specify a return value?:
MultiplyNumbers3 <- function(x, y = 100) {
  
  product <- x*y  ## We assigned the result to a variable called product that is INSIDE the function.
  
}

MultiplyNumbers3(5, 10)  ## Nothing comes up!

# We can assign the result to a variable in the global environment and see what happens.
result <-  MultiplyNumbers3(5, 10) 
result  ## It saves the result.
print(product)  ## "product" only exists in the local environment of the function.

# Importance of using a return value when you have multiple things going on in your function:
MultiplyNumbers4 <- function(x, y = 100) {
  
  product <- x*y
  
  foo <- "Cotesia!"
  
}

result <- MultiplyNumbers4(5, 10)
result  ## Unless the return value is specified, the function will return the last expression!

# Using return will output the value we want to the global environment:
MultiplyNumbers5 <- function(x, y = 100) {
  
  product <- x*y
  
  foo <- "Cotesia!"
  
  return(product)
}

MultiplyNumbers5(5, 10)  ## It works!

# Remember you can also load functions from scripts into your current session using the source() command. E.g. 
#source("MultiplyFunction.R")! ## If we had saved MultiplyFunction.R into a different script.

#### EXAMPLE FUNCTION USING FISHBASE DATA ----

# FishBase data from: 
# Froese, R. and D. Pauly. Editors. 2021.FishBase. World Wide Web electronic publication. www.fishbase.org, ( 06/2021 )

# How I obtained the data from FishBase on November 3rd, 2021:
# Get a vector of species names that have data available on FishBase for the order "Salmoniformes".
#fish <- species_list(Order = "Salmoniformes")
# Check class.
#class(fish)
# Download data from the FishBase "Species table" using the species() function.
# "The Species table is the heart of FishBase. This function provides a convenient way to query, tidy, and assemble data from that table given an entire list of species. For details, see: http://www.fishbase.org/manual/english/fishbasethe_species_table.htm "
#dfSpecies <- data.frame(rfishbase::species(fish))
#write.csv(dfSpecies, "fishbase.csv")

# Read in the FishBase data.
dfSpecies <- read.csv("../data/fishbase.csv")
# Check column names.
names(dfSpecies)
# Take only the columns that we need. These are columns containing data about the length of the species, longevity, maximum depth, body shape, and the zone which they inhabit.
dfSpecies <- dfSpecies[, c("Species", "Length", "LongevityWild", "DepthRangeDeep", "BodyShapeI", "DemersPelag")]
# Check the classes of the columns.
sapply(dfSpecies, class) ## Using sapply to simplify output.

# Let's get some descriptive info for each trait.
# Body length.
sum(!is.na(dfSpecies$Length)) ## Number of species with information available for the trait (sample size or 'n').
range(dfSpecies$Length, na.rm = T)  ## Range of values for this trait. na.rm is set to TRUE so NA values are not considered. 
hist(dfSpecies$Length)  ## Plot a histogram of the values.

# We could run these lines multiple times for each of the traits:
# Longevity.
sum(!is.na(dfSpecies$LongevityWild))
range(dfSpecies$LongevityWild, na.rm = T)
hist(dfSpecies$LongevityWild)

# Maximum depth.
sum(!is.na(dfSpecies$DepthRangeDeep))
range(dfSpecies$DepthRangeDeep, na.rm = T)
hist(dfSpecies$DepthRangeDeep)

# For categorical traits:
# Body shape.
sum(!is.na(dfSpecies$BodyShapeI))
table(dfSpecies$BodyShapeI)  ## Number of observations in each category.
names(which.max(table(dfSpecies$BodyShapeI)))  ## Most frequent category.

# Zone.
sum(!is.na(dfSpecies$DemersPelag))
table(dfSpecies$DemersPelag)
names(which.max(table(dfSpecies$DemersPelag)))

# But it looks pretty repetitive doesn't it?! So, let's make our own customized summary function!

# Let's start with getting information for numerical traits.
GetInfo <- function(trait) {
  
  # trait = numeric vector
  
  # Assign the number of observations to a variable called traitNum.
  traitNum <- sum(!is.na(trait))
  print(traitNum) ## I will use print statements often when first creating a function so I know each step is doing what I want it to do.
  
  # Assign the range of observations to a variable called traitRange.
  traitRange <- range(trait, na.rm = T)
  print(traitRange) 
  
  # Assign the histogram to a variable called histPlot.
  histPlot <- hist(trait)
  print("Plotted!")
  
  # Combine these results into a list.
  result <- list(traitNum, traitRange, histPlot)
  # Name the elements of the list.
  names(result) <- c("n", "Range", "plot")
  
  return(result)
  
}

test1 <- GetInfo(dfSpecies$Length) ## See print statements in action!

# Looking closer at the results of our function. I always do this to make sure my function worked properly!
test1$n ## Should be a single number. Could have also typed test1[[1]].
test1$Range ## Should be two numbers (range).
test1$plot ## Should be a plot.
plot(test1$plot)

# But what if we wanted to generalize to both numerical and categorical traits?

# Naming it according to the action that it performs.
GetTraitInfo <- function(trait) {
  
  # First, get the class of the trait. Remember you can call functions within a function!
  traitClass <- class(trait)
  
  # If the trait is numeric...
  if(traitClass == "numeric") {
    
    # How many observations are there?
    traitNum <- sum(!is.na(trait))
    # What is the range of the data?
    traitRange <- range(trait, na.rm = T)
    # Assign the histogram to a variable called histPlot.
    histPlot <- hist(trait)
    # Combine these results.
    result <- list(traitNum, traitRange, histPlot)
    # Name the result.
    names(result) <- c("n", "Range", "plot")
    
    return(result)
    
    # If the trait is categorical (in this case we will consider character variables as categorical but we could also consider factor variables!)...
  } else if(traitClass == "character") {
    
    # How many observations are there?
    traitNum <- sum(!is.na(trait))
    # Table of categories.
    tabTrait <- table(dfSpecies$BodyShapeI)
    # Most frequent category.
    traitMaj <- names(which.max(table(trait)))
    # Combine these results.
    result <- list(traitNum, tabTrait, traitMaj)
    # Name the result.
    names(result) <- c("n", "table", "Mode")
    
    return(result)
    
    # If the class is neither numeric nor character..
  } else {
    
    "Error! Check class of data.."
    
  }
  
}

# Observe the function under Functions in the Environment tab.
# Reduced it from 15 lines to 5 lines!

# Numeric.
GetTraitInfo(dfSpecies$Length)
GetTraitInfo(dfSpecies$LongevityWild)
GetTraitInfo(dfSpecies$DepthRangeDeep)

# Character.
GetTraitInfo(dfSpecies$BodyShapeI)
GetTraitInfo(dfSpecies$DemersPelag)

# Some checks...
# What class is returned?
check <- GetTraitInfo(dfSpecies$DemersPelag)
class(check)
# Check that our error message works by converting one of the columns to "factor" type:
?as.factor
GetTraitInfo(as.factor(dfSpecies$DemersPelag))

# And even more ways to make it more concise... In one line using lapply!:
lapply(dfSpecies[, c(2:6)], GetTraitInfo)

# PS. If I wanted to change my character columns to "factor" type, I would do it this way!:
dfSpecies[, c("BodyShapeI", "DemersPelag")] <- lapply(dfSpecies[, c("BodyShapeI", "DemersPelag")], as.factor)
# Check that it worked:
sapply(dfSpecies, class)

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

# this is just from nov 5ths class
fn_uniqueSpecies <- function(df) {
  df.unique <- df %>%
    filter(!is.na(bin_uri)) %>%
    group_by(bin_uri) %>%
    summarize(num_species = length(unique(species_name))) %>%
    arrange(desc(num_species))
  return(df.unique)
}
