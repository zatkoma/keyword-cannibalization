
Sys.setlocale("LC_CTYPE", "en_US.UTF-8")

library(searchConsoleR)
library(tidyverse)
library(googleAuthR)

## Login to GSC:
scr_auth()

## View websites:
list_websites()

## Script settings:
sc_domain = "https://www.zatkovic.cz/"
sc_days_to_start = 90
sc_start = as.character(as.Date(Sys.Date()) - sc_days_to_start - 3)
sc_end = as.character(Sys.Date() - 3)
sc_limit = 10000 # For big websites could use 100000
sc_brand = "martin|žatkovič"
sc_duplicity_type = 1 # 1 = by clicks / 2 = by impression

## Get data from Google Search Console:
queries_all <- search_analytics(sc_domain, sc_start, sc_end, c("query", "page"), dimensionFilterExp = c("country==cze"), rowLimit = sc_limit)

## Basic filtration:
queries_filtered <- queries_all %>%
  filter(position<=30) %>%
  filter(clicks!=0) %>%
  filter(!str_detect(query, sc_brand))

## Find cannibalization type
if(sc_duplicity_type == 1){
  
  queries_computed <- queries_filtered %>%
    group_by(query) %>%
    mutate(clicksT= sum(clicks)) %>%
    group_by(page, add=TRUE) %>%
    mutate(per=round(100*clicks/clicksT,2))
  
  queries_final <- queries_computed %>%
    arrange(desc(clicksT))
}else{
  
  queries_computed <- queries_filtered %>%
    group_by(query) %>%
    mutate(impressionsT= sum(impressions)) %>%
    group_by(page, add=TRUE) %>%
    mutate(per=round(100*impressions/impressionsT,2))
  
  queries_final <- queries_computed %>%
    arrange(desc(impressionsT))
    
}

## Remove clicksTotal / impressionTotal
queries_final <- queries_final[,c(-7)]

## Remove nonDuplicites
queries_final <- queries_final[queries_final$per != 100,]

## Prepare backup of query
queries_final$query_bu <- queries_final$query

## Clear duplicate query for Open Refine
queries_final$query[duplicated(queries_final$query)] <- ""

## Round position
queries_final$position <- round(queries_final$position,2)

## Better CTR
queries_final$ctr <- round(queries_final$ctr * 100,2)

## Final
if(is.data.frame(queries_final) && nrow(queries_final)==0){
  cat("\014")
  print("---------------------------------------------------------------")
  print("Your website doesn't have problem with keyword cannibalization")
  print("---------------------------------------------------------------")
  
}else{
  ## View data
  View(queries_final)
  
  ## Export to CSV
  write.csv(queries_final, file = "keyword-cannibalization.csv")
}

