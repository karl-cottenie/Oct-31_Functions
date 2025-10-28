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
#install.packages("usethis")

##_ Fork and Clone ------

# this will create a new project in RStudio in a new window

usethis::create_from_github(
  "https://github.com/karl-cottenie/Oct-31_Functions.git",
  destdir = "./binf6210/", # or whatever directory location you want
  fork = FALSE
)

# you will copy-paste the next set of commands in the console of the new RStudio window created by the previous command, which is its own R Project now!
# see https://usethis.r-lib.org/articles/pr-functions.html
# for full instructions

# check your set-up

usethis::git_remotes()
# you should see an origin (in your github account) and upstream (my github account)

usethis::git_sitrep()

# _ Code your own solution -----

# CREATE A NEW BRANCH - do this after every pull request has been merged!

usethis::pr_init(branch = "formidable") # change formidable w/ more informative branch name!

usethis::git_sitrep()
# check that Git local (project) Current local branch is formidable
# and this is differet from the git_sitrep output from line38!

# now do your R work
# for this assignment, create a script file named
# <your-university-user-name-from-your-uog-email-address>.R
# for me, that would be cottenie.R
# put it in the correct folder!
# code your solution for the assignment

# commit your new file with the changes

# _ Submit pull request -----

usethis::pr_push()

# in the launched browser window, click "Create pull request"
# in the description, add - "This is my solution to coding challenge :-)"
# click "Create pull request"

# then you wait for me to review and accept - this is your "quiz" for this week

# after I have merged the pull request

usethis::pr_pull() # make sure your branch is up-to-date

usethis::pr_finish() # cleaning everything up, deleting local 

usethis::git_sitrep()

