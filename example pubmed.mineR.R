library(pubmed.mineR)

example_abstracts <- "./Data/abstract-sensorimot-set.txt"

myabs=readabs(example_abstracts)

gtest <- Genewise(myabs)
cstest <- contextSearch(myabs, "implicit")
