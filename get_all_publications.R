get_all_publications = function(authorid) {
  # initializing the publication list
  all_publications = NULL
  # initializing a counter for the citations
  cstart = 0
  # initializing a boolean that check if the loop should continue
  notstop = TRUE
  
  while (notstop) {
    new_publications = try(get_publications(my_id, cstart=cstart), silent=TRUE)
    if (class(new_publications)=="try-error") {
      notstop = FALSE
    } else {
      # append publication list
      all_publications = rbind(all_publications, new_publications)
      cstart=cstart+20
    }
  }
  return(all_publications)
}