#-----20220508 RA-----
#Task：1.觀察county和district層級的各項敘述性統計
#      2.108到110年公告現值與公告地價敘述性統計繪圖

library("readxl")
library("tidyverse")
library("writexl")
library("ggplot2")
options(digits = 2)

#-----Task 1 - 檔案觀察-----
#觀察方式：
#1、county
#a.各年公告現值與公告地價之     中央趨勢：平均值(mean)與中位數(median)、離散程度：標準差(sd)、最大值(max)與最小值(min)
#b.三年總和公告現值與公告地價之 中央趨勢：平均值(mean)與中位數(median)、離散程度：標準差(sd)、最大值(max)與最小值(min)

#2、district
#a.各年公告現值與公告地價之     中央趨勢：平均值(mean)與中位數(median)、離散程度：標準差(sd)、最大值(max)與最小值(min)
#b.三年總和公告現值與公告地價之 中央趨勢：平均值(mean)與中位數(median)、離散程度：標準差(sd)、最大值(max)與最小值(min)

#-----county-----
combine_108 <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/108年_公告現值/全國/tw_combine_108.rds")
combine_109 <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/109年_公告現值_公告地價/全國/tw_combine_109.rds")
combine_110 <- readRDS("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/110年_公告現值/全國/tw_combine_110.rds")

#-----各年(Problem Existing)-----
#Still unable for using
#Reason：Error in UseMethod("group_by") : no applicable method for 'group_by' applied to an object of class "character"

cyear <- c("108", "109")
list_each <- list()

for (i in 1:2){
  str_c("stat_county_",cyear[i]) <- str_c("combine_",cyear[i]) %>%
    group_by(county) %>%
    summarise(value_mean = mean(value, na=T), value_sd = sd(value, na=T),         # 計算公告現值的平均值與標準差
              value_max = max(value, na=F), value_min = min(value, na=F),         # 計算公告現值的最大與最小值
              land_mean = mean(land, na=T), land_sd = sd(land, na=T),             # 計算公告地價的平均值與標準差
              land_max = max(land, na=F), land_min = min(land, na=F))%>%          # 計算公告地價的最大與最小值
    mutate(year=cyear[i])%>%
    select(year,everything())
}

#-----108年(Exported)-----
stat_county_108 <- group_by(combine_108, county) %>%
  summarise(n = n(), value_mean = mean(value, na.rm=TRUE),                                # 計算比數與公告現值的平均值
            value_median = median(value, na.rm=TRUE), value_sd = sd(value, na.rm=TRUE),   # 計算公告現值的中位數與標準差
            value_max = max(value, na.rm=TRUE), value_min = min(value, na.rm=TRUE),       # 計算公告現值的最大與最小值
            land_mean = mean(land, na.rm=TRUE), land_median = median(land, na.rm=TRUE),  # 計算公告地價的平均值與中位數
            land_sd = sd(land, na.rm=TRUE),                                               # 計算公告地價的標準差
            land_max = max(land, na.rm=TRUE), land_min = min(land, na.rm=TRUE)) %>%       # 計算公告地價的最大與最小值
  mutate(year = 108) %>%
  select(year, everything())

saveRDS(stat_county_108, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/108年_公告現值/全國/敘述性統計/stat_county_108.rds")

#-----109年(Exported)-----
stat_county_109<-group_by(combine_109, county)%>%
  summarise(n = n(), value_mean = mean(value, na.rm=TRUE),                                # 計算比數與公告現值的平均值
            value_median = median(value, na.rm=TRUE), value_sd = sd(value, na.rm=TRUE),   # 計算公告現值的中位數與標準差
            value_max = max(value, na.rm=TRUE), value_min = min(value, na.rm=TRUE),       # 計算公告現值的最大與最小值
            land_mean = mean(land, na.rm=TRUE), land_median = median(land, na.rm=TRUE),   # 計算公告地價的平均值與中位數
            land_sd = sd(land, na.rm=TRUE),                                               # 計算公告地價的標準差
            land_max = max(land, na.rm=TRUE), land_min = min(land, na.rm=TRUE)) %>%       # 計算公告地價的最大與最小值
  mutate(year = 109) %>%
  select(year, everything())

saveRDS(stat_county_109, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/109年_公告現值_公告地價/全國/敘述性統計/stat_county_109.rds")

#-----110年(Exported)-----
stat_county_110<-group_by(combine_110, county)%>%
  summarise(n = n(), value_mean = mean(value, na.rm=TRUE),                                # 計算比數與公告現值的平均值
            value_median = median(value, na.rm=TRUE), value_sd = sd(value, na.rm=TRUE),   # 計算公告現值的中位數與標準差
            value_max = max(value, na.rm=TRUE), value_min = min(value, na.rm=TRUE),       # 計算公告現值的最大與最小值
            land_mean = mean(land, na.rm=TRUE), land_median = median(land, na.rm=TRUE),   # 計算公告地價的平均值與中位數
            land_sd = sd(land, na.rm=TRUE),                                               # 計算公告地價的標準差
            land_max = max(land, na.rm=TRUE), land_min = min(land, na.rm=TRUE)) %>%       # 計算公告地價的最大與最小值
  mutate(year = 110) %>%
  select(year, everything()) %>%
  filter(county != "縣市")

saveRDS(stat_county_110, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/110年_公告現值/全國/敘述性統計/stat_county_110.rds")

#-----三年合併(Exported)-----
stat_county <- bind_rows(stat_county_108, stat_county_109, stat_county_110)
saveRDS(stat_county, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/110年_公告現值/全國/敘述性統計/stat_county.rds")

#====================================
#-----district-----
c108<-c("金門縣","基隆市","嘉義縣","澎湖縣","宜蘭縣","苗栗縣","桃園市","高雄市","新北市","新竹縣","臺中市","臺北市","臺南市")
c109<-c("花蓮縣","金門縣","屏東縣","基隆市","連江縣","雲林縣","嘉義縣","臺東縣","澎湖縣","宜蘭縣","南投縣","苗栗縣","桃園市","高雄市","新北市","新竹縣","臺中市","臺北市","臺南市")
c110<-c("花蓮縣","金門縣","屏東縣","基隆市","連江縣","雲林縣","嘉義縣","臺東縣","澎湖縣","宜蘭縣","南投縣","苗栗縣","桃園市","高雄市","新北市","新竹縣","臺中市","臺北市","臺南市")
list_108<-list()
list_109<-list()
list_110<-list()

#-----108年(Exported)-----
for(i in 1:13){
  list_108[[i]] <- filter(combine_108, county==c108[i]) %>%
    group_by(district) %>%
    summarise(n = n(), value_mean = mean(value, na=T),                              # 計算比數與公告現值的平均值
              value_median = median(value, na=T), value_sd = sd(value, na=T),       # 計算公告現值的中位數與標準差
              value_max = max(value, na=F), value_min = min(value, na=F),           # 計算公告現值的最大與最小值
              land_mean = mean(land, na=T), land_median = median(land, na=T),      # 計算公告地價的平均值與中位數
              land_sd = sd(land, na=T),                                             # 計算公告地價的標準差
              land_max = max(land, na=F), land_min = min(land, na=F)) %>%           # 計算公告地價的最大與最小值
    mutate(year = 108, county_2 = c108[i]) %>%
    select(year, county_2, everything())
}

stat_district_108 <- bind_rows(list_108) %>%                                        # 匯入成資料庫
  rename(county=county_2)
saveRDS(stat_district_108, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/108年_公告現值/全國/敘述性統計/stat_district_108.rds")

#-----109年(Exported)-----
for(i in 1:19){
  list_109[[i]] <- filter(combine_109, county==c109[i]) %>%
    group_by(district) %>%
    summarise(n = n(), value_mean = mean(value, na=T),                              # 計算比數與公告現值的平均值
              value_median = median(value, na=T), value_sd = sd(value, na=T),       # 計算公告現值的中位數與標準差
              value_max = max(value, na=F), value_min = min(value, na=F),           # 計算公告現值的最大與最小值
              land_mean = mean(land, na=T), land_median = median(land, na=T),      # 計算公告地價的平均值與中位數
              land_sd = sd(land, na=T),                                             # 計算公告地價的標準差
              land_max = max(land, na=F), land_min = min(land, na=F)) %>%           # 計算公告地價的最大與最小值
    mutate(year = 109, county_2 = c109[i]) %>%
    select(year, county_2, everything())
}

stat_district_109 <- bind_rows(list_109) %>%                                        # 匯入成資料庫
  rename(county=county_2)
saveRDS(stat_district_109, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/109年_公告現值_公告地價/全國/敘述性統計/stat_district_109.rds")

#-----110年(Exported)-----
for(i in 1:19){
  list_110[[i]] <- filter(combine_110, county==c110[i]) %>%
    group_by(district) %>%
    summarise(n = n(), value_mean = mean(value, na=T),                              # 計算比數與公告現值的平均值
              value_median = median(value, na=T), value_sd = sd(value, na=T),       # 計算公告現值的中位數與標準差
              value_max = max(value, na=F), value_min = min(value, na=F),           # 計算公告現值的最大與最小值
              land_mean = mean(land, na=T), land_median = median(land, na=T),      # 計算公告地價的平均值與中位數
              land_sd = sd(land, na=T),                                             # 計算公告地價的標準差
              land_max = max(land, na=F), land_min = min(land, na=F)) %>%           # 計算公告地價的最大與最小值
    mutate(year = 110, county_2 = c110[i]) %>%
    select(year, county_2, everything())
}

stat_district_110 <- bind_rows(list_110) %>%                                        # 匯入成資料庫
  rename(county=county_2)
saveRDS(stat_district_110, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/110年_公告現值/全國/敘述性統計/stat_district_110.rds")

#-----三年合併(Exported)-----
stat_district <- bind_rows(stat_district_108, stat_district_109, stat_district_110)
saveRDS(stat_district, "C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/110年_公告現值/全國/敘述性統計/stat_district.rds")

#====================================
#-----Task 2 - 資料繪圖-----
#-----county-----
#-----點圖-----
#-----108年公告現值(Exported)-----
#mean
stat_county_108%>%
  arrange(value_mean,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=value_mean,y=county)) +                                                   # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "平均值", y = "",
       title="108年全國各縣市公告現值")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108年/108年全國各縣市公告現值點圖_mean.png",
       width = 30, height = 15, units = "cm")

#median
stat_county_108%>%
  arrange(value_median,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=value_median,y=county)) +                                                 # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "中位數", y = "",
       title="108年全國各縣市公告現值")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108年/108年全國各縣市公告現值點圖_median.png",
       width = 30, height = 15, units = "cm")

#sd
stat_county_108%>%
  arrange(value_sd,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=value_sd,y=county)) +                                                     # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "標準差", y = "",
       title="108年全國各縣市公告現值")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108年/108年全國各縣市公告現值點圖_sd.png",
       width = 30, height = 15, units = "cm")

#-----108年公告地價(Exported)-----
#mean
stat_county_108%>%
  arrange(land_mean,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=land_mean,y=county)) +                                                    # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "平均值", y = "",
       title="108年全國各縣市公告地價")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108年/108年全國各縣市公告地價點圖_mean.png",
       width = 30, height = 15, units = "cm")

#median
stat_county_108%>%
  arrange(land_median,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=land_median,y=county)) +                                                  # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "中位數", y = "",
       title="108年全國各縣市公告地價")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108年/108年全國各縣市公告地價點圖_median.png",
       width = 30, height = 15, units = "cm")

#sd
stat_county_108%>%
  arrange(land_sd,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=land_sd,y=county)) +                                                      # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "標準差", y = "",
       title="108年全國各縣市公告地價")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108年/108年全國各縣市公告地價點圖_sd.png",
       width = 30, height = 15, units = "cm")

#-----109年公告現值(Exported)-----
#mean
stat_county_109%>%
  arrange(value_mean,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=value_mean,y=county)) +                                                   # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "平均值", y = "",
       title="109年全國各縣市公告現值")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/109年/109年全國各縣市公告現值點圖_mean.png",
       width = 30, height = 15, units = "cm")

#median
stat_county_109%>%
  arrange(value_median,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=value_median,y=county)) +                                                 # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "中位數", y = "",
       title="109年全國各縣市公告現值")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/109年/109年全國各縣市公告現值點圖_median.png",
       width = 30, height = 15, units = "cm")

#sd
stat_county_109%>%
  arrange(value_sd,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=value_sd,y=county)) +                                                     # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "標準差", y = "",
       title="109年全國各縣市公告現值")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/109年/109年全國各縣市公告現值點圖_sd.png",
       width = 30, height = 15, units = "cm")

#-----109年公告地價(Exported)-----
#mean
stat_county_109%>%
  arrange(land_mean,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=land_mean,y=county)) +                                                    # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "平均值", y = "",
       title="109年全國各縣市公告地價")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/109年/109年全國各縣市公告地價點圖_mean.png",
       width = 30, height = 15, units = "cm")

#median
stat_county_109%>%
  arrange(land_median,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=land_median,y=county)) +                                                  # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "中位數", y = "",
       title="109年全國各縣市公告地價")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/109年/109年全國各縣市公告地價點圖_median.png",
       width = 30, height = 15, units = "cm")

#sd
stat_county_109%>%
  arrange(land_sd,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=land_sd,y=county)) +                                                      # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "標準差", y = "",
       title="109年全國各縣市公告地價")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/109年/109年全國各縣市公告地價點圖_sd.png",
       width = 30, height = 15, units = "cm")

#-----110年公告現值(Exported)-----
#mean
stat_county_110%>%
  arrange(value_mean,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=value_mean,y=county)) +                                                   # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "平均值", y = "",
       title="110年全國各縣市公告現值")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/110年/110年全國各縣市公告現值點圖_mean.png",
       width = 30, height = 15, units = "cm")

#median
stat_county_110%>%
  arrange(value_median,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=value_median,y=county)) +                                                 # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "中位數", y = "",
       title="110年全國各縣市公告現值")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/110年/110年全國各縣市公告現值點圖_median.png",
       width = 30, height = 15, units = "cm")

#sd
stat_county_110%>%
  arrange(value_sd,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=value_sd,y=county)) +                                                     # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "標準差", y = "",
       title="110年全國各縣市公告現值")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/110年/110年全國各縣市公告現值點圖_sd.png",
       width = 30, height = 15, units = "cm")

#-----110年公告地價(Exported)-----
#mean
stat_county_110%>%
  arrange(land_mean,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=land_mean,y=county)) +                                                    # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "平均值", y = "",
       title="110年全國各縣市公告地價")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/110年/110年全國各縣市公告地價點圖_mean.png",
       width = 30, height = 15, units = "cm")

#median
stat_county_110%>%
  arrange(land_median,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=land_median,y=county)) +                                                  # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "中位數", y = "",
       title="110年全國各縣市公告地價")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/110年/110年全國各縣市公告地價點圖_median.png",
       width = 30, height = 15, units = "cm")

#sd
stat_county_110%>%
  arrange(land_sd,year)%>%
  mutate(county=fct_inorder(county))%>%
  ggplot(aes(x=land_sd,y=county)) +                                                      # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "標準差", y = "",
       title="110年全國各縣市公告地價")                                                  # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/110年/110年全國各縣市公告地價點圖_sd.png",
       width = 30, height = 15, units = "cm")

#-----三年合併之公告現值(Exported)-----
#mean
stat_county%>%
  arrange(value_mean,year)%>%
  mutate(county=fct_inorder(county), year = as.character(year))%>%
  ggplot(aes(x=value_mean,y=county, colour = year)) +                                    # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "平均值", y = "",
       title="108至110年全國各縣市公告現值")                                             # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108to110年/108至110年全國各縣市公告現值點圖_mean.png",
       width = 30, height = 15, units = "cm")

#median
stat_county%>%
  arrange(value_median,year)%>%
  mutate(county=fct_inorder(county), year = as.character(year))%>%
  ggplot(aes(x=value_median,y=county, colour = year)) +                                  # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "中位數", y = "",
       title="108至110年全國各縣市公告現值")                                             # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108to110年/108至110年全國各縣市公告現值點圖_median.png",
       width = 30, height = 15, units = "cm")

#sd
stat_county%>%
  arrange(value_sd,year)%>%
  mutate(county=fct_inorder(county), year = as.character(year))%>%
  ggplot(aes(x=value_sd,y=county, colour = year)) +                                      # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "標準差", y = "",
       title="108至110年全國各縣市公告現值")                                             # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108to110年/108至110年全國各縣市公告現值點圖_sd.png",
       width = 30, height = 15, units = "cm")

#-----三年合併之公告地價(Exported)-----
#mean
stat_county%>%
  arrange(land_mean,year)%>%
  mutate(county=fct_inorder(county), year = as.character(year))%>%
  ggplot(aes(x=land_mean,y=county, colour = year)) +                                     # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "平均值", y = "",
       title="108至110年全國各縣市公告地價")                                             # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108to110年/108至110年全國各縣市公告地價點圖_mean.png",
       width = 30, height = 15, units = "cm")

#median
stat_county%>%
  arrange(land_median,year)%>%
  mutate(county=fct_inorder(county), year = as.character(year))%>%
  ggplot(aes(x=land_median,y=county, colour = year)) +                                   # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "中位數", y = "",
       title="108至110年全國各縣市公告地價")                                             # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108to110年/108至110年全國各縣市公告地價點圖_median.png",
       width = 30, height = 15, units = "cm")

#sd
stat_county%>%
  arrange(land_sd,year)%>%
  mutate(county=fct_inorder(county), year = as.character(year))%>%
  ggplot(aes(x=land_sd,y=county, colour = year)) +                                       # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "標準差", y = "",
       title="108至110年全國各縣市公告地價")                                             # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108to110年/108至110年全國各縣市公告地價點圖_sd.png",
       width = 30, height = 15, units = "cm")

#-----district-----
#-----散布圖-----
#-----三年合併之公告現值(Exported)-----
#mean
stat_district%>%
  arrange(value_mean,year)%>%
  mutate(district=fct_inorder(district), year = as.character(year))%>%
  filter(county == "臺北市") %>%
  ggplot(aes(x=value_mean,y=district, colour = year)) +                                  # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "平均值", y = "",
       title="108至110年臺北市市公告現值")                                               # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108to110年/108至110年臺北市公告現值點圖_mean.png",
       width = 30, height = 15, units = "cm")

#median
stat_district%>%
  arrange(value_median,year)%>%
  mutate(county=fct_inorder(county), year = as.character(year))%>%
  filter(county == "臺北市") %>%
  ggplot(aes(x=value_median,y=district, colour = year)) +                                # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "中位數", y = "",
       title="108至110年臺北市市公告現值")                                               # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108to110年/108至110年臺北市公告現值點圖_median.png",
       width = 30, height = 15, units = "cm")

#sd
stat_district%>%
  arrange(value_sd,year)%>%
  mutate(county=fct_inorder(county), year = as.character(year))%>%
  filter(county == "臺北市") %>%
  ggplot(aes(x=value_sd,y=district, colour = year)) +                                    # 設置 X 與 Y 軸採用變數
  geom_point() +                                                                         # 繪製點圖
  labs(x = "標準差", y = "",
       title="108至110年臺北市市公告現值")                                              # 加入 X 與 Y 軸名稱並加上標題
ggsave("C:/Users/hsien/Desktop/研究計畫/land/data/modified/公告現值_公告地價/圖形彙整/108to110年/108至110年臺北市公告現值點圖_sd.png",
       width = 30, height = 15, units = "cm")
