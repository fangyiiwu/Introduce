#Edited: 01/10/2021 RA
#Task: combine county level excels
#Export file: G:\共用雲端硬碟\RA 2021\住宅政策計畫\Analysis\Data\211228_RA_2020_county_all.xlsx

#------------------------------------------------------------------------------
library("readxl")
library("tidyverse")
install.packages("writexl")
library("writexl")

setwd("C:/Users/philip/Desktop/tw/屋主")

year<-c(2018,2019,2020 )

#------------------------------------------------------------------------------
#擁屋原因
list<-list()
for (i in 1:3){
  list[[i]]<-read_excel(str_c(year[i],"_tw擁屋.xlsx"),col_names = F)%>%
    mutate(county="台灣",
           year=year[i])%>%
    rename("category"="...1",
           "A"="...2",
           "B"="...3",
           "C"="...4",
           "D"="...5",
           "E"="...6",
           "F"="...7")%>%
    filter(!A=="A")
}
data_reason<-bind_rows(list)

write_xlsx(data_reason,"220110_RA擁屋_tw_all.xlsx")