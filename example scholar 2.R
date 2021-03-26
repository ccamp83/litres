# https://www.andreashandel.com/post/publications-analysis-1/

library(scholar)
library(dplyr)
library(tidyr)
library(knitr)
library(ggplot2)

#Define the person to analyze
scholar_id="cQm68jUAAAAJ" 
#either load existing file of publications
#or get a new one from Google Scholar
#delete the file to force an update
if (file.exists('citations.Rds'))
{
  cites <- readRDS('citations.Rds')
} else {
  #get citations
  cites <- scholar::get_citation_history(scholar_id) 
  saveRDS(cites,'citations.Rds')
}

fit1=lm(cites ~ year, data = cites)
inc1 = fit1$coefficients["year"]
print(sprintf('Annual increase is %f',inc1))

xlabel = cites$year[seq(1,nrow(cites),by=2)]
#make the plot and show linear fit lines
p1 <- ggplot(data = cites, aes(year, cites)) + 
  geom_point(size = I(4)) + 
  geom_smooth(method="lm", se = F, size=1.5) + 
  scale_x_continuous(name = "Year", breaks = xlabel, labels = xlabel) +     scale_y_continuous("Citations according to Google Scholar") +
  theme_bw(base_size=14) + theme(legend.position="none") + 
  geom_text(aes(NULL,NULL),x=2010.8,y=150,label="Average annual \n increase 22%",color="black",size=5.5) +
  geom_text(aes(NULL,NULL),x=2017,y=150,label="Average annual \n increase 43%",color="black",size=5.5) 

#open a new graphics window
#note that this is Windows specific. Use quartz() for MacOS
ww=5; wh=5; 
windows(width=ww, height=wh)					
print(p1)

dev.print(device=png,width=ww,height=wh,units="in",res=600,file="my citations.png")

#get all pubs for an author (or multiple)
if (file.exists('publications.Rds'))
{
  publications <- readRDS('publications.Rds')
} else {
  #get citations
  publications <- scholar::get_publications(scholar_id) 
  saveRDS(publications,'publications.Rds')
}

glimpse(publications)

#here I only want publications since 2015
# pub_reduced <- publications %>% dplyr::filter(year>2014)
ifdata <- scholar::get_impactfactor(publications$journal) 
#Google SCholar collects all kinds of 'publications'
#including items other than standard peer-reviewed papers
#this sorts and removes some non-journal entries  
iftable <- ifdata %>% dplyr::arrange(desc(ImpactFactor) ) %>% tidyr::drop_na()
knitr::kable(iftable)

allauthors = list()
if (file.exists('allauthors.Rds'))
{
  allauthors <- readRDS('allauthors.Rds')
} else {
  for (n in 1:nrow(publications)) 
  {
    allauthors[[n]] = get_complete_authors(id = scholar_id, pubid = publications[n,]$pubid)
  }
  saveRDS(allauthors,'allauthors.Rds')
}

allauthors
