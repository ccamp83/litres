# https://cran.r-project.org/web/packages/pubmedR/vignettes/A_Brief_Example.html
install.packages("devtools")
devtools::install_github("massimoaria/pubmedR")

install.packages("pubmedR")
###

library(pubmedR)

api_key <- "af507337d86f1d0a0bdbdf1a22e80a417608"

query <- "sensorimotor adaptation"

res <- pmQueryTotalCount(query = query, api_key = api_key)

res$total_count

res$query_translation

D <- pmApiRequest(query = query, limit = res$total_count, api_key = NULL)

M <- pmApi2df(D)

str(M)

library(bibliometrix)

M <- convert2df(D, dbsource = "pubmed", format = "api")

results <- biblioAnalysis(M)
summary(results)
