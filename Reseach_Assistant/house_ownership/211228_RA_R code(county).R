#Edited: 12/28/2021 RA
#Task: combine county level excels
#Export file: G:\�@�ζ��ݵw��\RA 2021\���v�F���p�e\Analysis\Data\211228_RA_2020_county_all.xlsx

#Data Using
#G:\�@�ζ��ݵw��\RA 2021\���v�F���p�e\Analysis\Data\211223��X\2020_county
#------------------------------------------------------------------------------
library("readxl")
library("tidyverse")
install.packages("writexl")
library("writexl")

setwd("C:/....../2020_county")
countycode<-c(10002,10004,10005,10007,10008,10009,10010,10013,
              10014,10015,10016,10017,10018,10020,63000,64000,
              65000,66000,67000,68000,90070,90200 )
countyname<-c("�y����","�s�˿�","�]�߿�","���ƿ�","�n�뿤","���L��",
              "�Ÿq��","�̪F��","�O�F��","�Ὤ��","���","�򶩥�",
              "�s�˥�","�Ÿq��","�O�_��","������","�s�_��","�O����",
              "�O�n��","��饫","�s����","������")
sheet<-c("�Ш|","�B��","�a��զ�","�~�ֲէO")

#------------------------------------------------------------------------------
#�Ш|
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


#�B��
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


#�a��զ�
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


#�~�ֲզ�
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
#�X�֥|��2020_data
data_2020<-bind_rows(data_edu,data_marriage,data_house,data_age)
write_xlsx(data_2020,"211228_RA_2020_county_all.xlsx")
