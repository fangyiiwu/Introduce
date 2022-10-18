#-----220617   Task：將獨居老人資料進行敘述性統計-----
#   作法參考咸安的code
#----------------------
library("tidyverse")
library("ggplot2")
setwd("C:/芳益/NTPU碩班/研究助理/population/modified")

old_people <- readRDS("220617_列冊需關懷獨居老人人數按鄉鎮市區別.rds")

#-----進行敘述性統計分析 - 以縣市層級資料做區分-----
county_name<-c("新北市","臺北市","桃園市","臺中市","臺南市","高雄市","宜蘭縣","新竹縣","苗栗縣",
               "彰化縣","南投縣","雲林縣","嘉義縣","屏東縣","臺東縣","花蓮縣","澎湖縣","基隆市",
               "新竹市","嘉義市","金門縣","連江縣")

list <- list()
for(j in 1:3){
  list[[j]]<-list()
}
for(j in 1:1){
for(i in 1:22){
    list[[j]][[1]]<-old_people %>%                     #全國層級
      filter(level=="全國") %>%
      group_by(type)%>%
      summarise(n=n(),mean= mean(count, na.rm=TRUE),   # 筆數n看出幾筆觀察值，無法看出count是否有NA
                median = median(count, na.rm=TRUE),    # 計算中位數與標準差
                sd= sd(count, na.rm=TRUE),               
                max = max(count, na.rm=TRUE),          # 計算最大值與最小值
                min= min(count, na.rm=TRUE))%>%
      mutate(level="全國",county="總計",district="總計")%>%
      select(county,district,everything())
    
    list[[j+1]][[i]]<- old_people %>%                   #縣市層級
      filter(level=="縣市",county==county_name[i]) %>%
      group_by(type)%>%
      summarise(n=n(),mean= mean(count, na.rm=TRUE),   # 筆數n看出幾筆觀察值，無法看出count是否有NA
                median = median(count, na.rm=TRUE),    # 計算中位數與標準差
                sd= sd(count, na.rm=TRUE),               
                max = max(count, na.rm=TRUE),          # 計算最大值與最小值
                min= min(count, na.rm=TRUE))%>%
      mutate(level="縣市",county=county_name[i],district=county)%>%
      select(county,district,everything())
    
    list[[j+2]][[i]]<-  old_people %>%                 #鄉鎮市區層級
      filter(level=="鄉鎮市區",county==county_name[i]) %>%
      group_by(district,type)%>%
      summarise(n=n(),mean= mean(count, na.rm=TRUE),   # 筆數n看出幾筆觀察值，無法看出count是否有NA
                median = median(count, na.rm=TRUE),    # 計算中位數與標準差
                sd= sd(count, na.rm=TRUE),               
                max = max(count, na.rm=TRUE),          # 計算最大值與最小值
                min= min(count, na.rm=TRUE))%>%
      mutate(level="鄉鎮市區",county=county_name[i])%>%
      select(county,district,everything())
}
}

old_people_stat <- bind_rows(list)
saveRDS(old_people_stat, "220617_old_people_stat.rds")

#----檢查----
#(1)計算鄉鎮市區個數
#將每年各縣市出現的鄉鎮市區個數相加，若無遺漏鄉鎮市，應為368(鄉鎮市區)x16(年)
list<-list()
for(i in 1:16){                                       #95到110年共16年
  list[[i]]<-old_people%>%                       
    filter(level=="鄉鎮市區",year==94+i)%>%           #選取鄉鎮市層級的觀察值
    group_by(county)%>%                               #依縣分組
    summarise(district_num=n_distinct(district))%>%   #計算各縣市該年district欄位下有多少鄉鎮市區
    mutate(level="鄉鎮市區",year=94+i)
}
district_check<-bind_rows(list)
sum(district_check$district_num)/16    #除以16年

#368代表沒有任何一年的鄉鎮市區有缺漏

#(2)計算count(人)個數
#summarise()中無法檢查count是否有缺漏值，因此用count(is.na())檢查
old_people%>%
  count("人數為NA"=is.na(count))
#發現有165個NA，也就是高雄縣十一個鄉鎮市區在95~99五個年度、三種類的NA值造成(11x5x3=165)



#-----一、進行全國層級資料繪圖-----
#-----人數-----
#(1)Total
old_people %>%
  filter(level=="全國") %>%
  ggplot(aes(x = year,y = count)) +
  facet_wrap(~type) +
  geom_line()+
  labs(x = "年分", y = "人數", title = "95至110年全國列冊需關懷獨居老人人數變化")

ggsave("95至110年全國列冊需關懷獨居老人人數變化統計.png",
       width = 30, height = 15, units = "cm")


#-----二、進行縣市層級資料繪圖-----
#-----人數-----
#(1)Total
old_people %>%
  filter(type=="計",level=="縣市") %>%
  ggplot(aes(x = year,y = count)) +
  facet_wrap(~county) +
  geom_line() +
  labs(x = "年分", y = "人數", title = "95至110年各縣市總計列冊需關懷獨居老人人數")

ggsave("95至110年各縣市總計列冊需關懷獨居老人人數統計.png",
       width = 30, height = 15, units = "cm")

old_people_stat%>%
  filter(type=="計",level=="縣市") %>%
  arrange(mean)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = mean,y =county)) +
  geom_point()+
  labs(x = "總計人數平均", y = "",
       title="95至110年各縣市總計列冊需關懷總計獨居老人平均")
ggsave("95至110年各縣市總計列冊需關懷總計獨居老人人數平均.png",width = 15, height = 10, units = "cm")

old_people_stat%>%
  filter(type=="計",level=="縣市") %>%
  arrange(sd)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = sd,y =county)) +
  geom_point()+
  labs(x = "總計人數標準差", y = "",
       title="95至110年各縣市總計列冊需關懷總計獨居老人標準差")
ggsave("95至110年各縣市總計列冊需關懷總計獨居老人人數標準差.png",width = 15, height = 10, units = "cm")

#(2)Male
old_people %>%
  filter(type=="男",level=="縣市") %>%
  ggplot(aes(x = year,y = count)) +
  facet_wrap(~county) +
  geom_line() +
  labs(x = "年分", y = "人數", title = "95至110年各縣市男性列冊需關懷獨居老人人數統計")
ggsave("95至110年各縣市男性列冊需關懷獨居老人人數統計.png",
       width = 30, height = 15, units = "cm")

old_people_stat%>%
  filter(type=="男",level=="縣市") %>%
  arrange(mean)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = mean,y =county)) +
  geom_point()+
  labs(x = "男性人數平均", y = "",
       title="95至110年各縣市男性列冊需關懷總計獨居老人平均")
ggsave("95至110年各縣市男性列冊需關懷總計獨居老人人數平均.png",width = 15, height = 10, units = "cm")

old_people_stat%>%
  filter(type=="男",level=="縣市") %>%
  arrange(sd)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = sd,y =county)) +
  geom_point()+
  labs(x = "男性人數標準差", y = "",
       title="95至110年各縣市男性列冊需關懷總計獨居老人標準差")
ggsave("95至110年各縣市男性列冊需關懷總計獨居老人人數標準差.png",width = 15, height = 10, units = "cm")

#(3)Female
old_people %>%
  filter(type=="女",level=="縣市") %>%
  ggplot(aes(x = year,y = count)) +
  facet_wrap(~county) +
  geom_line() +
  labs(x = "年分", y = "人數", title = "95至110年各縣市女性列冊需關懷獨居老人人數統計")

ggsave("95至110年各縣市女性列冊需關懷獨居老人人數統計.png",
       width = 30, height = 15, units = "cm")

old_people_stat%>%
  filter(type=="女",level=="縣市") %>%
  arrange(mean)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = mean,y =county)) +
  geom_point()+
  labs(x = "女性人數平均", y = "",
       title="95至110年各縣市女性列冊需關懷總計獨居老人平均")
ggsave("95至110年各縣市女性列冊需關懷總計獨居老人人數平均.png",width = 15, height = 10, units = "cm")

old_people_stat%>%
  filter(type=="女",level=="縣市") %>%
  arrange(sd)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x = sd,y =county)) +
  geom_point()+
  labs(x = "女性人數標準差", y = "",
       title="95至110年各縣市女性列冊需關懷總計獨居老人標準差")
ggsave("95至110年各縣市女性列冊需關懷總計獨居老人人數標準差.png",width = 15, height = 10, units = "cm")

