#Edited: 01/10/2021 RA
#Task: combine county level excels
#Export file: G:\�@�ζ��ݵw��\RA 2021\���v�F���p�e\Analysis\Data\211228_RA_2020_county_all.xlsx

#Data Using
#G:\�@�ζ��ݵw��\RA 2021\���v�F���p�e\Analysis\Data\220106��X\tw
#------------------------------------------------------------------------------
library("readxl")
library("tidyverse")
install.packages("writexl")
library("writexl")

setwd("C:/Users/philip/Desktop/tw/�ΥD")

year<-c(2018,2019,2020 )

sheet<-c("�Ш|","�B��","�a��զ�","�~�ֲէO")

#------------------------------------------------------------------------------
#�Ш|
list<-list()
for (i in 1:3){
  list[[i]]<-read_excel(str_c(year[i],"_tw.xlsx"),sheet=1,col_names = F)%>%
    mutate(county="�x�W",
           type=sheet[1],
           year=year[i])%>%
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


#�B��
list<-list()
for (i in 1:22){
  list[[i]]<-read_excel(str_c(year[i],"_tw.xlsx"),sheet=2,col_names = F)%>%
    mutate(county="�x�W",
           type=sheet[2],
           year=year[i])%>%
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


#�a��զ�
list<-list()
for (i in 1:22){
  list[[i]]<-read_excel(str_c(year[i],"_tw.xlsx"),sheet=3,col_names = F)%>%
    mutate(county="�x�W",
           type=sheet[3],
           year=year[i])%>%
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


#�~�ֲզ�
list<-list()
for (i in 1:22){
  list[[i]]<-read_excel(str_c(year[i],"_tw.xlsx"),sheet=4,col_names = F)%>%
    mutate(county="�x�W",
           type=sheet[4],
           year=year[i])%>%
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
#�X�֥|��2020_data
data_2020<-bind_rows(data_edu,data_marriage,data_house,data_age)
write_xlsx(data_2020,"220110_RA�H�Цa_tw_all.xlsx")
