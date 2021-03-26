get_abstract = function(pub_id, author_id) {
  print(pub_id)
  paper_url = paste0("http://scholar.google.com/citations?view_op=view_citation&hl=fr&user=",
                     author_id, "&citation_for_view=", author_id,":", pub_id)
  paper_page = htmlTreeParse(paper_url, useInternalNodes=TRUE, encoding="utf-8")
  paper_abstract = xpathSApply(paper_page, "//div[@id='gsc_descr']", xmlValue)
  return(paper_abstract)
}