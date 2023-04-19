# https://docs.ropensci.org/pdftools/
install.packages("pdftools")

library(pdftools)
download.file("http://arxiv.org/pdf/1403.2805.pdf", "1403.2805.pdf", mode = "wb")
txt <- pdf_text("1403.2805.pdf")

# first page text
cat(txt[1])

# second page text
cat(txt[2])
