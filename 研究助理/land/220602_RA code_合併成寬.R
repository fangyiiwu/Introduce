library("readxl")
library("tidyverse")

#形成value_107~value_110
#若想嘗試少一點，可加上head(個數)

list<-list()
for (i in 1:4){
  list[[i]]<-tw_107_to_110%>%
    filter(year==106+i)%>%
    select(-land)%>%
    mutate(year=str_c("value_",106+i,""))%>%
    pivot_wider(names_from = year,values_from=value)
}
list_value<-left_join(list[[1]],list[[2]],by=c("county"="county","district"="district","duan_siau_duan"="duan_siau_duan",
                                               "land_num"="land_num"))

#形成land_107~land_110
list<-list()
for (i in 1:4){
  list[[i]]<-tw_107_to_110%>%
    select(-value)%>%
    filter(year==106+i)%>%
    mutate(year=str_c("land_",106+i,""))%>%
    pivot_wider(names_from = year,values_from = land)
}
list_land<-bind_rows(list)
