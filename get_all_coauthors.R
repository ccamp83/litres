get_all_coauthors = function(my_id, me=NULL) {
  all_publications = get_all_publications(my_id)
  if (is.null(me))
    me = strsplit(get_profile(my_id)$name, " ")[[1]][2]
  # make the author list a character vector
  all_authors = sapply(all_publications$author, as.character)
  # split it over ", "
  all_authors = unlist(sapply(all_authors, strsplit, ", "))
  names(all_authors) = NULL
  # remove "..." and yourself
  all_authors = all_authors[!(all_authors %in% c("..."))]
  all_authors = all_authors[-grep(me, all_authors)]
  # make a data frame with authors by decreasing number of appearance
  all_authors = data.frame(name=factor(all_authors, 
                                       levels=names(sort(table(main_authors),decreasing=TRUE))))
}