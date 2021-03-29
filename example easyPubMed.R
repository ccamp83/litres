library(easyPubMed)

my_query <- 'sensorimotor adaptation'
my_entrez_id <- get_pubmed_ids(my_query)
my_abstracts_txt <- fetch_pubmed_data(my_entrez_id, format = "abstract")

my_abstracts_xml <- fetch_pubmed_data(pubmed_id_list = my_entrez_id)

my_PM_list <- articles_to_list(pubmed_data = my_abstracts_xml)
print(substr(my_PM_list[4], 1, 510))

names(EPMsamples)

##
try({
  ## Display some contents
  data("EPMsamples")
  #display Query String used for collecting the data
  print(EPMsamples$NUBL_1618$qry_st)
  #Get records
  BL_list <- EPMsamples$NUBL_1618$rec_lst
  cat(BL_list[[1]])
  # cast PM recort to data.frame
  BL_df <- article_to_df(BL_list[[1]], max_chars = 0)
  print(BL_df)
}, silent = TRUE)

## Not run: 
## Query PubMed, retrieve a selected citation and format it as a data frame
dami_query <- "Damiano Fantini[AU] AND 2017[PDAT]"
dami_on_pubmed <- get_pubmed_ids(dami_query)
dami_abstracts_xml <- fetch_pubmed_data(dami_on_pubmed)
dami_abstracts_list <- articles_to_list(dami_abstracts_xml)
article_to_df(pubmedArticle = dami_abstracts_list[[1]], autofill = FALSE)
article_to_df(pubmedArticle = dami_abstracts_list[[2]], autofill = TRUE, max_chars = 300)[1:2,]
