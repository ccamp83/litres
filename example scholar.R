# https://github.com/jkeirstead/scholar

library(scholar)

# Define the id for Richard Feynman
id <- 'B7vSqZsAAAAJ'

# Get his profile and print his name
l <- get_profile(id)
l$name 

# Get his citation history, i.e. citations to his work in a given year 
get_citation_history(id)

# Get his publications (a large data frame)
get_publications(id)
