#-----20220521 RA-----
#Task：1.匯入84~111年county層級資料；觀察county層級的各項敘述性統計(筆數、總額 變化)

library("readxl")
library("tidyverse")
library("writexl")
library("ggplot2")
options(digits = 2)
setwd("C:\Users\philip\國立臺北大學\傅健豪 - RA Workspace\land\data\modified\84至111年_公告現值_公告地價_縣市層級資料")

#匯入已在excel處理完的資料
county<-read_xlsx("84到111年縣層級_現值地價_r版.xlsx")
col<-c("county","year","count","area_hectare","value_total_thousand","land_total_thousand")
colnames(county)<-col
#創造每公頃平均現值/地價(千元)
county_ave<-county%>%
  mutate(ave_value_per_hectare=value_total_thousand/area_hectare,
         ave_land_per_hectare=land_total_thousand/area_hectare)


#劃出不同年分，筆數、面積、現值、地價 變化圖，x軸年分，Y軸各種
#1、看個別(point)-----
#a.筆數
county_ave%>%filter(year>=107)%>%
  arrange(count,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = count,y =county,color=year,group=year)) +
  geom_point()+
  labs(x = "筆數", y = "",
       title="107~111年全國各縣市土地筆數變化") 
ggsave("county_count.png",width = 30, height = 15, units = "cm")

#b.現值/地價總額
county_ave%>%
  filter(year>=107)%>%
  arrange(value_total_thousand,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = value_total_thousand,y =county,color=year,group=year)) +
  geom_point()+
  labs(x = "公告現值總額(千元)", y = "",
       title="107~111年全國各縣市公告現值總額(千元)變化")   
ggsave("county_value_total.png",width = 30, height = 15, units = "cm")

county_ave%>%
  filter(year>=107)%>%
  arrange(land_total_thousand,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = land_total_thousand,y =county,color=year,group=year)) +
  geom_point()+
  labs(x = "公告地價總額(千元)", y = "",
       title="107~111年全國各縣市公告地價總額(千元)變化")   
ggsave("county_land_total.png",width = 30, height = 15, units = "cm")

#c.每公頃平均現值/地價(千元)
county_ave%>%
  filter(year>=107)%>%
  arrange(ave_value_per_hectare,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = ave_value_per_hectare,y =county,color=year,group=year)) +
  geom_point()+
  labs(x = "每公頃平均公告現值(千元)", y = "",
       title="107~111年全國各縣市每公頃平均公告現值(千元)變化")   
ggsave("county_value_average.png",width = 30, height = 15, units = "cm")

county_ave%>%
  filter(year>=107)%>%
  arrange(ave_land_per_hectare,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = ave_land_per_hectare,y =county,color=year,group=year)) +
  geom_point()+
  labs(x = "每公頃平均公告地價(千元)", y = "",
       title="107~111年全國各縣市每公頃平均公告地價(千元)變化")   
ggsave("county_land_average.png",width = 30, height = 15, units = "cm")


z<-filter(county_ave,county=="連江縣")

#2、看趨勢(line)-----
#a.筆數
#六都
county_ave%>%
  filter(county=="臺北市"|county=="新北市"|county=="桃園市"|
           county=="臺中市"|county=="臺南市"|county=="高雄市")%>%
  ggplot(aes(x = year,y =count)) +facet_wrap(~county)+
  geom_line()+  labs(x = "年度", y = "筆數",
       title="84~111年六都土地筆數變化")
ggsave("count_facet_wrap_six.png",width = 20, height = 20, units = "cm")
#台北單獨看: 看似沒動，其實也有變化
county_ave%>%
  filter(county=="臺北市")%>%
  ggplot(aes(x = year,y =count))+
  geom_line()+  labs(x = "年度", y = "筆數",
                     title="84~111年臺北市土地筆數變化")
ggsave("count_facet_wrap_taipei.png",width = 15, height = 15, units = "cm")

#六都以外
county_ave%>%
  filter(county!="臺北市",county!="新北市",county!="桃園市",
         county!="臺中市",county!="臺南市",county!="高雄市")%>%
  ggplot(aes(x = year,y =count)) +
  geom_line()+facet_wrap(~county)+  labs(x = "年度", y = "筆數",
       title="84~111年六都以外縣市土地筆數變化")
ggsave("count_facet_wrap_nosix.png",width = 20, height = 20, units = "cm")

#b.總額
  #現值
  #六都
county_ave%>%
  filter(county=="臺北市"|county=="新北市"|county=="桃園市"|
         county=="臺中市"|county=="臺南市"|county=="高雄市")%>%
  ggplot(aes(x = year,y =value_total_thousand)) +
  geom_line()+facet_wrap(~county)+  
  labs(x = "年度", y = "公告現值總額(千元)",
       title="84~111年六都公告現值總額(千元)變化")
ggsave("value_facet_wrap_six.png",width = 20, height = 20, units = "cm")
  #六都以外
county_ave%>%
  filter(county!="臺北市",county!="新北市",county!="桃園市",
         county!="臺中市",county!="臺南市",county!="高雄市")%>%
  ggplot(aes(x = year,y =value_total_thousand)) +
  geom_line()+facet_wrap(~county)+  
  labs(x = "年度", y = "公告現值總額(千元)",
       title="84~111年六都以外縣市公告現值總額(千元)變化")
ggsave("value_facet_wrap_nosix.png",width = 20, height = 20, units = "cm")
  #地價
  #六都
county_ave%>%
  filter(county=="臺北市"|county=="新北市"|county=="桃園市"|
           county=="臺中市"|county=="臺南市"|county=="高雄市")%>%
  ggplot(aes(x = year,y =land_total_thousand)) +
  geom_point()+facet_wrap(~county)+  
  labs(x = "年度", y = "公告地價總額(千元)",
       title="84~111年六都公告地價總額(千元)變化")
ggsave("land_facet_wrap_six.png",width = 20, height = 20, units = "cm")
  #六都以外
county_ave%>%
  filter(county!="臺北市",county!="新北市",county!="桃園市",
         county!="臺中市",county!="臺南市",county!="高雄市")%>%
  ggplot(aes(x = year,y =land_total_thousand)) +
  geom_point()+facet_wrap(~county)+  
  labs(x = "年度", y = "公告地價總額(千元)",
       title="84~111年全國六都外縣市公告地價總額(千元)變化")
ggsave("land_facet_wrap_nosix.png",width = 20, height = 20, units = "cm")

#c.每公頃平均現值/地價(千元)
#現值
#檢視整體分布，發現有破格的87、88年連江縣
county_ave%>%
  arrange(ave_value_per_hectare,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = ave_value_per_hectare,y =county,color=year,group=year)) +
  geom_point()+
  labs(x = "每公頃平均現值(千元)", y = "",
       title="84~111年各縣市每公頃平均現值(千元)")
ggsave("84~111年全國各縣市每公頃平均現值.png",width = 10, height = 10, units = "cm")

#刪除破格的87、88年連江縣
county_ave%>%
  filter(ave_value_per_hectare<=1296329.69)%>%
  arrange(ave_value_per_hectare,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = ave_value_per_hectare,y =county,color=year,group=year)) +
  geom_point()+
  labs(x = "每公頃平均現值(千元)", y = "",
       title="84~111年各縣市(排除連江縣outliner)")
ggsave("84~111年每公頃平均現值(排除連江縣outliner).png",width = 10, height = 10, units = "cm")

#前三名(臺北市、嘉義市、新竹市)
county_ave%>%
  filter(county=="臺北市"|county=="新竹市"|county=="嘉義市")%>%
  ggplot(aes(x = year,y =ave_value_per_hectare)) +
  geom_line()+facet_wrap(~county)+
  labs(x = "年度", y = "每公頃平均現值(千元)",
       title="84~111年平均現值變化前三名縣市")
ggsave("84~111年每公頃平均現值(千元)變化前三名縣市.png",width = 10, height = 10, units = "cm")

#其他快樂夥伴
county_ave_nolien<-filter(county_ave,ave_value_per_hectare<=1296329.69)
county_ave_nolien%>%
  filter(county!="臺北市"&county!="新竹市"&county!="嘉義市")%>%
  ggplot(aes(x = year,y =ave_value_per_hectare)) +
  geom_line()+facet_wrap(~county)+
  labs(x = "年度", y = "每公頃平均現值(千元)",
       title="84~111年其他縣市每公頃平均現值(千元)變化")
ggsave("其他快樂夥伴.png",width = 15, height = 10, units = "cm")

#地價
#檢視整體分布
county_ave%>%
  arrange(ave_land_per_hectare,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = ave_land_per_hectare,y =county,color=year,group=year)) +
  geom_point()+
  labs(x = "每公頃平均地價(千元)", y = "",
       title="84~111年各縣市每公頃平均地價(千元)")
ggsave("84~111年全國各縣市每公頃平均地價.png",width = 10, height = 10, units = "cm")

#前三名縣市
county_ave%>%
  filter(county=="臺北市"|county=="新竹市"|county=="嘉義市")%>%
  ggplot(aes(x = year,y =ave_land_per_hectare)) +
  geom_point()+facet_wrap(~county)+
  labs(x = "年度", y = "每公頃平均地價(千元)",
       title="84~111年每公頃平均地價變化前三名縣市")
ggsave("84~111年前三名縣市每公頃平均地價變化.png",width = 10, height = 10, units = "cm")

#其他快樂夥伴
county_ave%>%
  filter(county!="臺北市"&county!="新竹市"&county!="嘉義市")%>%
  ggplot(aes(x = year,y =ave_land_per_hectare)) +
  geom_point()+facet_wrap(~county)+
  labs(x = "年度", y = "每公頃平均地價(千元)",
       title="84~111年三縣市以外每公頃平均地價變化")
ggsave("其他快樂夥伴地價.png",width = 15, height = 15, units = "cm")

