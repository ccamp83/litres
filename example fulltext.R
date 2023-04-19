# https://docs.ropensci.org/fulltext/
# https://books.ropensci.org/fulltext/
install.packages("fulltext")
library('fulltext')


# Microsoft academic search
key <- Sys.getenv("MICROSOFT_ACADEMIC_KEY")
(res <- ft_search("Y='19'...", from = "microsoft", maopts = list(key = key)))
res$ma$data$DOI