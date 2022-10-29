#-----20220520 RA-----
#Task：1.統整107年公告現值與公告地價（新北市至南投縣）
#      2.以地號合併107至110年資料
#      3.完成全體107年
      
library("readxl")
library("tidyverse")
library("writexl")

#-----Task 1 - 合併107年鄉鎮市區公告現值與公告地價（新北市至南投縣）-----

chinese <- c("新北市", "臺北市", "桃園市", "臺中市", "臺南市", "高雄市", "苗栗縣")
name <- c("New_Taipei", "Taipei", "Taoyuan", "Taichung", "Tainan", "Kaoshung", "Miaoli")

list_107 <- list()

for (i in 1:7){
  list_107[[i]] <- list()
}

for (i in 1:7){
  list_107[[i]] <- readRDS(str_c("C:/Users/hsien/Desktop/研究計畫/land/data/modified/107年_公告現值_公告地價/", chinese[[i]], "/", name[i], "_107.rds")) %>%
    mutate("段小段" = as.character(段小段), "地號" = as.character(地號), "year" = 107) %>%
    select("year", "縣市別", "行政區", "段小段", "地號", "公告現值", "公告地價")
}

district_107 <- bind_rows(list_107)
saveRDS(district_107, file = "C:/Users/hsien/Desktop/研究計畫/land/data/modified/107年_公告現值_公告地價/全國/District_107.rds")

#====================================
#-----桃園市地號修改-----
#讀進桃園市各年度資料以製造新的地號
Taoyuan_107 <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/107年_公告現值_公告地價/桃園市/Taoyuan_107.rds")
x <- substr(Taoyuan_107$地號, 1, 4)
y <- substr(Taoyuan_107$地號, 6, 9)
z <- c(paste(x, y, sep = ""))

Taoyuan_108 <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/108年_公告現值/桃園市/Taoyuan_108.rds")
x <- substr(Taoyuan_108$地號, 1, 4)
y <- substr(Taoyuan_108$地號, 6, 9)
z <- c(paste(x, y, sep = ""))

Taoyuan_109 <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/109年_公告現值_公告地價/桃園市/Taoyuan_109.rds")
x <- substr(Taoyuan_109$地號, 1, 4)
y <- substr(Taoyuan_109$地號, 6, 9)
z <- c(paste(x, y, sep = ""))

Taoyuan_110 <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/110年_公告現值/桃園市/Taoyuan_110.rds")
x <- substr(Taoyuan_110$地號, 1, 4)
y <- substr(Taoyuan_110$地號, 6, 9)
z <- c(paste(x, y, sep = ""))

#開始修改各年度的地號
Taoyuan_107 <- bind_cols(Taoyuan_107, z) %>%
  mutate(year = 107) %>%
  rename("county" = "縣市別", "district" = "行政區", "duan_siau_duan" = "段小段", "value" = "公告現值", "land" = "公告地價", "land_num" = "...7") %>%
  select("year", "county", "district", "duan_siau_duan", "land_num", "value", "land")

Taoyuan_108 <- bind_cols(Taoyuan_108, z) %>%
  mutate(year = 108) %>%
  rename("county" = "縣市別", "district" = "行政區", "duan_siau_duan" = "段小段", "value" = "公告現值", "land" = "公告地價", "land_num" = "...7") %>%
  select("year", "county", "district", "duan_siau_duan", "land_num", "value", "land")

Taoyuan_109 <- bind_cols(Taoyuan_109, z) %>%
  mutate(year = 109, "段小段" = as.character(段小段)) %>%
  rename("county" = "縣市別", "district" = "行政區", "duan_siau_duan" = "段小段", "value" = "公告現值", "land" = "公告地價", "land_num" = "...7") %>%
  select("year", "county", "district", "duan_siau_duan", "land_num", "value", "land")

Taoyuan_110 <- bind_cols(Taoyuan_110, z) %>%
  mutate(year = 110) %>%
  rename("county" = "縣市別", "district" = "行政區", "duan_siau_duan" = "段小段", "value" = "公告現值", "land" = "公告地價", "land_num" = "...7") %>%
  select("year", "county", "district", "duan_siau_duan", "land_num", "value", "land")

#把全國各年度資料中的桃園市的地號修改完成
combine_107 <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/107年_公告現值_公告地價/全國/tw_combine_107.rds")
combine_108 <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/108年_公告現值/全國/tw_combine_108.rds")
combine_109 <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/109年_公告現值_公告地價/全國/tw_combine_109.rds")
combine_110 <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/110年_公告現值/全國/tw_combine_110.rds")

combine_107 <- combine_107 %>%
  filter(county != "桃園市")
combine_107 <- bind_rows(combine_107, Taoyuan_107)
saveRDS(combine_107, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/107年_公告現值_公告地價/全國/tw_combine_107.rds")

combine_108 <- combine_108 %>%
  filter(county != "桃園市")
combine_108 <- bind_rows(combine_108, Taoyuan_108)
saveRDS(combine_108, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/108年_公告現值/全國/tw_combine_108.rds")

combine_109 <- combine_109 %>%
  filter(county != "桃園市")
combine_109 <- bind_rows(combine_109, Taoyuan_109)
saveRDS(combine_109, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/109年_公告現值_公告地價/全國/tw_combine_109.rds")

combine_110 <- combine_110 %>%
  filter(county != "桃園市")
combine_110 <- bind_rows(combine_110, Taoyuan_110)
saveRDS(combine_110, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/110年_公告現值/全國/tw_combine_110.rds")

#-----Task 2 - 以地號合併107至110年資料-----
#公告現值（value）
combine_107_value <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/107年_公告現值_公告地價/全國/tw_combine_107.rds") %>%
  rename("107_value" = "value", "107_land" = "land")%>%
  select("county", "land_num", "107_value")

combine_108_value <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/108年_公告現值/全國/tw_combine_108.rds") %>%
  rename("108_value" = "value", "108_land" = "land") %>%
  select("county", "land_num", "108_value")
  
combine_109_value <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/109年_公告現值_公告地價/全國/tw_combine_109.rds") %>%
  rename("109_value" = "value", "109_land" = "land") %>%
  select("county", "land_num", "109_value")
  
combine_110_value <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/110年_公告現值/全國/tw_combine_110.rds") %>%
  rename("110_value" = "value", "110_land" = "land") %>%
  select("county", "land_num", "110_value")

combine_107_108_value <- bind_rows(combine_107_value, combine_108_value)
combine_107to109_value <- bind_rows(combine_109_value, combine_107_108_value)
combine_107to110_value <- bind_rows(combine_110_value, combine_107to109_value)
saveRDS(combine_107to110_value, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/107至110年_公告現值_公告地價/tw_combine_107to110_value.rds")

#試著先以新北市的資料進行合併
combine_107_value <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/107年_公告現值_公告地價/全國/tw_combine_107.rds") %>%
  rename("107_value" = "value", "107_land" = "land")%>%
  select("county", "land_num", "107_value") %>%
  filter(county == "新北市")

combine_108_value <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/107年_公告現值_公告地價/全國/tw_combine_108.rds") %>%
  rename("107_value" = "value", "107_land" = "land")%>%
  select("county", "land_num", "107_value") %>%
  filter(county == "新北市")

#試著先以苗栗縣的資料進行合併
combine_107_value <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/107年_公告現值_公告地價/全國/tw_combine_107.rds") %>%
  rename("107_value" = "value", "107_land" = "land") %>%
  select("county", "land_num", "107_value") %>%
  filter(county == "苗栗縣")

combine_108_value <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/108年_公告現值/全國/tw_combine_108.rds") %>%
  rename("108_value" = "value", "108_land" = "land") %>%
  select("county", "land_num", "108_value") %>%
  filter(county == "苗栗縣")
#Error: cannot allocate vector of size 607.3 Mb

memory.limit(size = 3500000)   #增加記憶體上限
gc()                          #空出記憶體

#公告地價（land）
combine_107_land <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/107年_公告現值_公告地價/全國/tw_combine_107.rds") %>%
  rename("107_value" = "value", "107_land" = "land")%>%
  select("county", "land_num", "107_land")

combine_108_land <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/108年_公告現值/全國/tw_combine_108.rds") %>%
  rename("108_value" = "value", "108_land" = "land") %>%
  select("county", "land_num", "108_land")

combine_109_land <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/109年_公告現值_公告地價/全國/tw_combine_109.rds") %>%
  rename("109_value" = "value", "109_land" = "land") %>%
  select("county", "land_num", "109_land")

combine_110_land <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/110年_公告現值/全國/tw_combine_110.rds") %>%
  rename("110_value" = "value", "110_land" = "land") %>%
  select("county", "land_num", "110_land")

combine_107_108_land <- bind_rows(combine_107_land, combine_108_land)
combine_107to109_land <- bind_rows(combine_109_land, combine_107_108_land)
combine_107to110_land <- bind_rows(combine_110_land, combine_107to109_land)
saveRDS(combine_107to110_land, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/107至110年_公告現值_公告地價/tw_combine_107to110_land.rds")

#====================================
#-----Task 3 - 完成全體107年-----
#讀取107年新竹市和基隆市.rds
combine<-bind_rows(hsinchu_vl,keelung_vl)%>%
  mutate(year=107)%>%
  select(year,everything())
combine$land_num<-as.character(combine$land_num)
#組合起來
col<-c("year","county","district","duan_siau_duan","land_num","value","land")
colnames(District_107)<-col
tw_combine_107<-bind_rows(District_107,combine)
saveRDS(tw_combine_107,file ="tw_combine_107.rds")

#組合107~110年
tw_107_to_110<-bind_rows(tw_combine_107,tw_108_to_110)
saveRDS(tw_107_to_110,file ="tw_107_to_110.rds")