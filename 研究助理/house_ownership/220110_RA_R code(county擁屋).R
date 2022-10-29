#------------------------------------------------------------------------------
library("readxl")
library("tidyverse")
install.packages("writexl")
library("writexl")

setwd("C:/Users/philip/Desktop/table0118/擁屋重作")

year<-c(2018,2019,2020 )

countycode<-c(10002,10004,10005,10007,10008,10009,10010,10013,
              10014,10015,10016,10017,10018,10020,63000,64000,
              65000,66000,67000,68000,9007,9020 )
countyname<-c("宜蘭縣","新竹縣","苗栗縣","彰化縣","南投縣","雲林縣",
              "嘉義縣","屏東縣","臺東縣","花蓮縣","澎湖縣","基隆市",
              "新竹市","嘉義市","臺北市","高雄市","新北市","臺中市",
              "臺南市","桃園市","連江縣","金門縣")
#------------------------------------------------------------------------------
#擁屋原因2018
list<-list()
for (i in 1:22){
  list[[i]]<-read_excel(str_c("2018_county_mask_擁屋_",countycode[i],".xlsx"),col_names = F)%>%
    mutate(county=countyname[i],
           code=countycode[i],
           year=2018)%>%
    rename("category"="...1",
           "A"="...2",
           "B"="...3",
           "C"="...4",
           "D"="...5",
           "E"="...6",
           "F"="...7")%>%
    filter(!A=="A")
}
data_reason18<-bind_rows(list)

#擁屋原因2019
list<-list()
for (i in 1:22){
  list[[i]]<-read_excel(str_c("2019_county_mask_擁屋_",countycode[i],".xlsx"),col_names = F)%>%
    mutate(county=countyname[i],
           code=countycode[i],
           year=2019)%>%
    rename("category"="...1",
           "A"="...2",
           "B"="...3",
           "C"="...4",
           "D"="...5",
           "E"="...6",
           "F"="...7")%>%
    filter(!A=="A")
}
data_reason19<-bind_rows(list)

#擁屋原因2020
list<-list()
for (i in 1:22){
  list[[i]]<-read_excel(str_c("2020_county_mask_擁屋_",countycode[i],".xlsx"),col_names = F)%>%
    mutate(county=countyname[i],
           code=countycode[i],
           year=2020)%>%
    rename("category"="...1",
           "A"="...2",
           "B"="...3",
           "C"="...4",
           "D"="...5",
           "E"="...6",
           "F"="...7")%>%
    filter(!A=="A")
}
data_reason20<-bind_rows(list)


data_reason_all<-bind_rows(data_reason18,data_reason19,data_reason20)
write_xlsx(data_reason_all,"220116_RA擁屋_county_all.xlsx")