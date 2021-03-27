library(easyPubMed)

my_query <- 'sensorimotor adaptation'
my_entrez_id <- get_pubmed_ids(my_query)
my_abstracts_txt <- fetch_pubmed_data(my_entrez_id, format = "abstract")

my_abstracts_xml <- fetch_pubmed_data(pubmed_id_list = my_entrez_id)

my_PM_list <- articles_to_list(pubmed_data = my_abstracts_xml)
print(substr(my_PM_list[4], 1, 510))
