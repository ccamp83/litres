# retrieve a query

library(easyPubMed)

my_query <- 'sensorimotor adaptation'
# query
dami_on_pubmed <- get_pubmed_ids(my_query)
# extract abstracts from query
dami_abstracts_txt <- fetch_pubmed_data(dami_on_pubmed, format = "abstract")
dami_abstracts_xml <- fetch_pubmed_data(dami_on_pubmed)

dami_abstracts_list <- articles_to_list(dami_abstracts_xml)
length(dami_abstracts_list)
article_to_df(pubmedArticle = dami_abstracts_list[[100]], autofill = FALSE)
article_to_df(pubmedArticle = dami_abstracts_list[[1]], autofill = FALSE)$keywords[1:10]
article_to_df(pubmedArticle = dami_abstracts_list[[2]], autofill = TRUE, max_chars = 300)[1:2,]

papers_list <- article_to_df(pubmedArticle = dami_abstracts_list[[1]], autofill = FALSE)
str(papers_list)
library(mu)
library(plyr)
keywordsData <- ddply(papers_list, .(pmid), summarise,
                      N = lengthunique(keywords))
head(keywordsData)

keywordsData <- list()
for(i in 1:length(dami_abstracts_list))
{
  keywordsData[[i]] <- unique(article_to_df(pubmedArticle = dami_abstracts_list[[i]], autofill = FALSE)$keywords)
}

keywordsData[[100]]

# highlight the keywords for each paper

# select one paper

# list all papers cited by the paper

# list all papers citing the paper

# show all papers connected as in a network
