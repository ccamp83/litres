# https://www.r-bloggers.com/2015/08/yet-another-post-on-google-scholar-data-analysis/

# get summary of all publications of an author (from their google scholar id)
library(scholar)
my_id = "cQm68jUAAAAJ"
all_publications = get_all_publications(my_id)
dim(all_publications)
table(all_publications$year)
summary(all_publications$cites)

# find all co-authors
main_authors = all_authors[all_authors$name %in% names(which(table(all_authors$name)>1)),]
library(ggplot2)
p = ggplot(main_authors, aes(x=name)) + geom_bar(fill=brewer.pal(3, "Set2")[2]) +
             xlab("co-author") + theme_bw() + theme(axis.text.x = element_text(angle=90, hjust=1))
print(p)
all_authors = get_all_coauthors(my_id, me="Campa")

# abstract word analysis

author_id <- my_id
pub_id <- all_publications[1,]$pubid
paper_url = paste0("http://scholar.google.com/citations?view_op=view_citation&hl=fr&user=",
                   author_id, "&citation_for_view=", author_id,":", pub_id)
paper_page = htmlTreeParse(paper_url, useInternalNodes=TRUE, encoding="utf-8")
paper_abstract = xpathSApply(paper_page, "//div[@id='gsc_descr']", xmlValue)





get_all_abstracts = function(author_id) {
  all_publications = get_all_publications(author_id)
  all_abstracts = sapply(all_publications$pubid, get_abstract)
  return(all_abstracts)
}

library("XML")
all_abstracts = get_all_abstracts(my_id)
library("tm")
# transform the abstracts into "plain text documents"
all_abstracts = lapply(all_abstracts, PlainTextDocument)
# find term frequencies within each abstract
terms_freq = lapply(all_abstracts, termFreq, 
                    control=list(removePunctuation=TRUE, stopwords=TRUE, removeNumbers=TRUE))
# finally obtain the abstract/term frequency matrix
all_words = unique(unlist(lapply(terms_freq, names)))
matrix_terms_freq = lapply(terms_freq, function(astring) {
  res = rep(0, length(all_words))
  res[match(names(astring), all_words)] = astring
  return(res)
})
matrix_terms_freq = Reduce("rbind", matrix_terms_freq)
colnames(matrix_terms_freq) = all_words
# deduce the term frequencies
words_freq = apply(matrix_terms_freq, 2, sum)
# keep only the most frequent and after a bit of cleaning up (not shown) make the word cloud
important = words_freq[words_freq > 10]
library(wordcloud)
wordcloud(names(important), important, random.color=TRUE, random.order=TRUE,
          color=brewer.pal(12, "Set3"), min.freq=1, max.words=length(important), scale=c(3, 0.3))
