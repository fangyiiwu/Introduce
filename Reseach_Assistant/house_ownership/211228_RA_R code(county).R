#Edited: 12/28/2021 RA
#Task: combine county level excels
#Export file: G:\共用雲端硬碟\RA 2021\住宅政策計畫\Analysis\Data\211228_RA_2020_county_all.xlsx

#Data Using
#G:\共用雲端硬碟\RA 2021\住宅政策計畫\Analysis\Data\211223攜出\2020_county
#------------------------------------------------------------------------------
library("readxl")
library("tidyverse")
install.packages("writexl")
library("writexl")

setwd("C:/....../2020_county")
countycode<-c(10002,10004,10005,10007,10008,10009,10010,10013,
              10014,10015,10016,10017,10018,10020,63000,64000,
              65000,66000,67000,68000,90070,90200 )
countyname<-c("宜蘭縣","新竹縣","苗栗縣","彰化縣","南投縣","雲林縣",
              "嘉義縣","屏東縣","臺東縣","花蓮縣","澎湖縣","基隆市",
              "新竹市","嘉義市","臺北市","高雄市","新北市","臺中市",
              "臺南市","桃園市","連江縣","金門縣")
sheet<-c("教育","婚姻","家戶組成","年齡組別")

#------------------------------------------------------------------------------
#教育
list<-list()
for (i in 1:22){
  list[[i]]<-read_excel(str_c("2019_county_mask_",countycode[i],".xlsx"),sheet=1,col_names = F)%>%
    mutate(county=countyname[i],
           code=countycode[i],
           type=sheet[1],
           year=2019)%>%
    rename("category"="...1",
           "A"="...2",
           "B"="...3",
           "C1"="...4",
           "C2"="...5",
           "D1"="...6",
           "D2"="...7",
           "E"="...8",
           "F"="...9",
           "NULL"="...10")%>%
    filter(!A=="A")
}
data_edu<-bind_rows(list)


#婚姻
list<-list()
for (i in 1:22){
  list[[i]]<-read_excel(str_c("2019_county_mask_",countycode[i],".xlsx"),sheet=2,col_names = F)%>%
    mutate(county=countyname[i],
           code=countycode[i],
           type=sheet[2],
           year=2019)%>%
    rename("category"="...1",
           "A"="...2",
           "B"="...3",
           "C1"="...4",
           "C2"="...5",
           "D1"="...6",
           "D2"="...7",
           "E"="...8",
           "F"="...9",
           "NULL"="...10")%>%
    filter(!A=="A")
}
data_marriage<-bind_rows(list)


#家戶組成
list<-list()
for (i in 1:22){
  list[[i]]<-read_excel(str_c("2019_county_mask_",countycode[i],".xlsx"),sheet=3,col_names = F)%>%
    mutate(county=countyname[i],
           code=countycode[i],
           type=sheet[3],
           year=2019)%>%
    rename("category"="...1",
           "A"="...2",
           "B"="...3",
           "C1"="...4",
           "C2"="...5",
           "D1"="...6",
           "D2"="...7",
           "E"="...8",
           "F"="...9",
           "NULL"="...10")%>%
    filter(!A=="A")
}
data_house<-bind_rows(list)


#年齡組成
list<-list()
for (i in 1:22){
  list[[i]]<-read_excel(str_c("2019_county_mask_",countycode[i],".xlsx"),sheet=4,col_names = F)%>%
    mutate(county=countyname[i],
           code=countycode[i],
           type=sheet[4],
           year=2019)%>%
    rename("category"="...1",
           "A"="...2",
           "B"="...3",
           "C1"="...4",
           "C2"="...5",
           "D1"="...6",
           "D2"="...7",
           "E"="...8",
           "F"="...9",
           "NULL"="...10")%>%
    filter(!A=="A")
}
data_age<-bind_rows(list)
view(list[[1]])

#------------------------------------------------------------------------------
#合併四個2020_data
data_2020<-bind_rows(data_edu,data_marriage,data_house,data_age)
write_xlsx(data_2020,"211228_RA_2020_county_all.xlsx")

