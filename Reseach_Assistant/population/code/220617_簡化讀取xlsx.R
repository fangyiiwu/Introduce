#Edited: 06/17/2022 RA
#Task: 
#   一、匯入檔案
#   二、將縣市升格前舊地名改成新的
#   三、加入level欄位判別全國、縣市、鄉鎮市區層級
#Export file: population\獨居老人\modified\220617_列冊需關懷獨居老人人數按鄉鎮市區別.rds

#Data Using
#population\獨居老人\source2.4.2列冊需關懷獨居老人人數按鄉鎮市區別_110年.xls
#-------------------------------------
library("readxl")
library("tidyverse")
library("stringr")
library("writexl")
setwd("C:/芳益/NTPU碩班/研究助理/population/source")

#概念:
#step1、載入xls
#step2、創造county名稱，並把原county改成district
#step3、三個temp沒問題後，full_join一起後再piviot_longer

#------載入xls--------
#104年之後
temp104<-read_xls("列冊需關懷獨居老人人數按鄉鎮市區別.xls",sheet=1,skip=3)%>%
  filter(!is.na(...2))%>%
  select(!...2)
year104c<-c("district",
            "110年12月底_計","110年12月底_男","110年12月底_女",
            "110年09月底_計","110年09月底_男","110年09月底_女",
            "110年06月底_計","110年06月底_男","110年06月底_女",
            "110年03月底_計","110年03月底_男","110年03月底_女",
            "109年06月底_計","109年06月底_男","109年06月底_女",
            "108年06月底_計","108年06月底_男","108年06月底_女",
            "107年03月底_計","107年03月底_男","107年03月底_女",
            "106年12月底_計","106年12月底_男","106年12月底_女",
            "105年12月底_計","105年12月底_男","105年12月底_女",
            "104年12月底_計","104年12月底_男","104年12月底_女")
colnames(temp104)<-year104c
#100到103年
temp100_103<-read_xls("列冊需關懷獨居老人人數按鄉鎮市區別.xls",sheet=2,skip=3)%>%
  filter(!is.na(...2))
year100_103c<-c("district","eng",
                "103年12月底_計","103年12月底_男","103年12月底_女",
                "102年12月底_計","102年12月底_男","102年12月底_女",
                "101年12月底_計","101年12月底_男","101年12月底_女",
                "100年12月底_計","100年12月底_男","100年12月底_女")
colnames(temp100_103)<-year100_103c
#99年之前
temp99_<-read_xls("列冊需關懷獨居老人人數按鄉鎮市區別.xls",sheet=3,skip=3)%>%na_if("...")
c1<-c("district","eng",
      "col1","col2","col3",
      "col4","col5","col6",
      "col7","col8","col9",
      "col10","col11","col12",
      "col13","col14","col15")
colnames(temp99_)<-c1
cols.num<-c("col1","col2","col3","col4","col5","col6","col7","col8","col9",
            "col10","col11","col12","col13","col14","col15")
temp99_[cols.num] <- sapply(temp99_[cols.num],as.numeric)

#-------99年修改-------
#創新欄位
county_name<-c("總計","新北市","臺北市","桃園市","臺中市","臺南市","高雄市","宜蘭縣","新竹縣","苗栗縣",
               "彰化縣","南投縣","雲林縣","嘉義縣","屏東縣","臺東縣","花蓮縣","澎湖縣","基隆市",
               "新竹市","嘉義市","金門縣","連江縣")

county<-as.data.frame(county_name)%>%
  rename("county"="county_name")%>%
  mutate("district"=county)

#修正99年要改名_縣市
temp99_<-temp99_%>%
  mutate(district=gsub("\\s","",district))%>%
  mutate(district=if_else(district=="臺北縣","新北市",district),
         district=if_else(district=="桃園縣","桃園市",district),
         district=if_else(district=="臺中縣","臺中市",district),
         district=if_else(district=="臺南縣","臺南市",district),
         district=if_else(district=="高雄縣","高雄市",district))
temp99_<-full_join(temp99_,county,by=c("district"="district"))%>%
  fill(county,.direction="down")
#修正99年要改名_鄉鎮市區
temp99_<-temp99_%>%
  mutate(district=if_else(county=="新北市"&!district=="新北市",str_c(str_sub(enc2utf8(district), start = 1, end=-2), enc2utf8("區")),district),
         district=if_else(county=="桃園市"&!eng=="Taoyuan County",str_c(str_sub(enc2utf8(district), start = 1, end=-2), enc2utf8("區")),district),
         district=if_else(county=="臺中市"&!district=="臺中市",str_c(str_sub(enc2utf8(district), start = 1, end=-2), enc2utf8("區")),district),
         district=if_else(county=="臺南市"&!district=="臺南市",str_c(str_sub(enc2utf8(district), start = 1, end=-2), enc2utf8("區")),district),
         district=if_else(county=="高雄市"&!district=="高雄市",str_c(str_sub(enc2utf8(district), start = 1, end=-2), enc2utf8("區")),district))%>%
  select(!eng)

#將有合併的縣市相加
temp_991<-filter(temp99_,district=="臺中市"|district=="臺南市"|district=="高雄市")%>%
  group_by(district)%>%
  summarize( across( col1:col15, sum))%>%
  mutate(county=if_else(district=="臺中市","臺中市",
                        if_else(district=="臺南市","臺南市","高雄市")))

temp_990<-filter(temp99_,district!="臺中市")%>%
  filter(district!="臺南市")%>%filter(district!="高雄市")
  
temp99_<-bind_rows(temp_990,temp_991)

#改回名稱
year99c<-c("district",
           "099年12月底_計","099年12月底_男","099年12月底_女",
           "098年12月底_計","098年12月底_男","098年12月底_女",
           "097年12月底_計","097年12月底_男","097年12月底_女",
           "096年12月底_計","096年12月底_男","096年12月底_女",
           "095年12月底_計","095年12月底_男","095年12月底_女","county")
colnames(temp99_)<-year99c

#-------103、104年修改-------
#修正103年要改名_縣市、_鄉鎮市區
temp100_103<-temp100_103%>%
  mutate(district=if_else(district=="桃園縣","桃園市",district))

temp100_103<-full_join(temp100_103,county,by=c("district"="district"))%>%
  fill(county,.direction="down")
temp104<-full_join(temp104,county,by=c("district"="district"))%>%
  fill(county,.direction="down")

#修正103年要改名
temp100_103<-temp100_103%>%
  mutate(district=if_else(county=="桃園市"&!eng=="Taoyuan County",
        str_c(str_sub(enc2utf8(district), start = 1, end=-2), enc2utf8("區")),district))%>%
  select(!eng)


#-------full_join三年-------
old_people<-full_join(temp104,temp100_103,by=c("county"="county","district"="district"))
old_people<-full_join(old_people,temp99_,by=c("county"="county","district"="district"))%>%
  select(county,district,everything())


#-------一起pivot_longer-------
old_people_long<-pivot_longer(old_people,"110年12月底_計":"095年12月底_女",names_to="time",
                            values_to="count")%>%
  mutate(year=str_sub(time,1,3),
         month=str_sub(time,5,6),
         type=str_sub(time,10),)%>%
  mutate_at(c("year", "month"), as.numeric)%>%
  select(county,district,year,month,type,count)

#創造層級
level<-as.data.frame(county_name)%>%
  rename("district"=county_name)%>%
  mutate("level"=if_else(district=="總計","全國","縣市"))

old_people_long<-full_join(old_people_long,level,by=c("district"="district"))
old_people_long$level[is.na(old_people_long$level)] = "鄉鎮市區"


#完成!!
saveRDS(old_people_long,file = "220617_列冊需關懷獨居老人人數按鄉鎮市區別.rds")

