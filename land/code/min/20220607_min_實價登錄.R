library("tidyverse")
library("ggmap")
library("readxl")
library("writexl")



county<-c("臺北市","臺中市","基隆市","臺南市",
          "高雄市","新北市","宜蘭縣","桃園市",
          "嘉義市","新竹縣","苗栗縣","南投縣",
          "彰化縣","新竹市","雲林縣","嘉義縣",
          "屏東縣","花蓮縣","臺東縣","金門縣",
          "澎湖縣","連江縣")
alphabet<-c("a","b","c","d",
            "e","f","g","h",
            "i","j","k","m",
            "n","o","p","q",
            "t","u","v","w",
            "x","z")
year<-109:105
qua<-c("q1","q2","q3","q4")
wd<-"C:/Users/MinKu/OneDrive/桌面/實價登錄/data/source"

##不動產買賣
##創造儲存list
list<-list()
for (y in 1:5){
  list[[y]]<-list()
}

for (y in 1:5){
  for (i in 1:4){
    list[[y]][[i]]<-list()
  }
}

for (y in 1:5){
  for (i in 1:4){
    for (j in 1:22){
      list[[y]][[i]][[j]]<-list()
    }
  }
}


##讀取檔案
##加入縣市,年份,季度變數
##排序合併

for (y in 1:5){
  for (i in 1:4){
    setwd(str_c("",wd,"/",year[[y]],"/",qua[[i]],""))
    for (j in 1:22){
      list[[y]][[i]][[j]]<-read_excel(str_c("",alphabet[j],"_lvr_land_a.xls"),sheet="不動產買賣")%>%
        mutate(縣市=county[j],year=year[y],quarter=qua[i])%>%
        select(year,quarter,縣市,everything())
    }
    list[[y]][[i]]<-bind_rows(list[[y]][[i]])
    list[[y]][[i]]<-list[[y]][[i]]%>%
      mutate(主建物面積=as.character(主建物面積),
                  附屬建物面積=as.character(附屬建物面積),
                  陽台面積=as.character(陽台面積),
                  電梯=as.character(電梯),
                  移轉編號=as.character(移轉編號))
  }
  list[[y]]<-bind_rows(list[[y]])
}  

##刪除重複英文變數名稱,計算屋齡,儲存檔案
property_trade109_105<-bind_rows(list)%>%
  filter(!鄉鎮市區=="The villages and towns urban district")
property_trade109_105<-property_trade109_105%>%
  mutate(建築完成年月=str_sub(enc2utf8(property_trade109_105$建築完成年月), start = 1, end=3))%>%
  mutate(year=as.numeric(year),建築完成年月=as.numeric(建築完成年月),
         交易年=str_sub(enc2utf8(property_trade109_105$交易年月日), start = 1, end=3),
         交易月=str_sub(enc2utf8(property_trade109_105$交易年月日), start = 4, end=5),
         交易年=as.numeric(交易年),
         交易月=as.numeric(交易月),
         屋齡=交易年-建築完成年月)

##更改地址
for (i in 1:22){
  property_trade109_105<-property_trade109_105%>%
    mutate(土地位置建物門牌=gsub(county[[i]],"",土地位置建物門牌),
                   土地位置建物門牌=if_else(縣市==county[[i]],
                                      str_c(enc2utf8(county[[i]]),str_sub(enc2utf8(土地位置建物門牌), start = 1, end=-1)),土地位置建物門牌))
  
}




##台北109資料
register_google(key="AIzaSyDiJlt5pkcvFRDbqAdQS7T8oGCw-zNc-VU")
taipei_property_trade109<-property_trade109_105%>%
  filter(year==109)%>%
  filter(縣市=="臺北市")%>%
  mutate_geocode(土地位置建物門牌)


##修改單位、更改鄉鎮市區不同名稱
property_trade109_105<-property_trade109_105%>%
  mutate(單價元平方公尺=as.numeric(單價元平方公尺),
                總價元=as.numeric(總價元),
                土地移轉總面積平方公尺=as.numeric(土地移轉總面積平方公尺),
                單價=單價元平方公尺/10000,
                總價=總價元/10000)%>%
  mutate(建築完成年月=if_else(土地位置建物門牌=="臺中市北區健行路４４３號８樓之２３",84,建築完成年月),
         屋齡=交易年-建築完成年月)%>%
  mutate(鄉鎮市區=if_else(鄉鎮市區=="台西鄉","臺西鄉",鄉鎮市區),
         鄉鎮市區=if_else(鄉鎮市區=="台東市","臺東市",鄉鎮市區))

taipei_property_trade109<-taipei_property_trade109%>%
  mutate(單價元平方公尺=as.numeric(單價元平方公尺),
         總價元=as.numeric(總價元),
         單價=單價元平方公尺/10000,
         總價=總價元/100000000,
         土地移轉總面積平方公尺=as.numeric(土地移轉總面積平方公尺),
         建物移轉總面積平方公尺=as.numeric(建物移轉總面積平方公尺),
         交易年=str_sub(enc2utf8(taipei_property_trade109$交易年月日), start = 1, end=3),
         交易月=str_sub(enc2utf8(taipei_property_trade109$交易年月日), start = 4, end=5),
         交易年=as.numeric(交易年),
         交易月=as.numeric(交易月),
         屋齡=交易年-建築完成年月)


setwd(wd)

write_rds(property_trade109_105,"property_trade109_105.rds")
write_rds(taipei_property_trade109,"taipei_property_trade109.rds")
writexl::write_xlsx(taipei_property_trade109,path="taipei_property_trade109.xlsx")
writexl::write_xlsx(property_trade109_105,path="property_trade109_105.xlsx")


##計算縣市中位數及平均數-單價-房地(土地+建物)
tem<-property_trade109_105%>%
  filter(交易標的=="房地(土地+建物)")

list<-list()
for (y in 1:5){
  list[[y]]<-list()
}

for (y in 1:5){
  for (i in 1:12){
    list[[y]][[i]]<-list()
  }
}

for (y in 1:5){
  for (i in 1:12){
    for (j in 1:22){
      list[[y]][[i]][[j]]<-list()
    }
  }
}

for (y in 1:5){
  for (i in 1:12){
    for (j in 1:22){
      list[[y]][[i]][[j]]<-tem%>%
        filter(縣市==county[j],
               交易年==109-y,交易月==i)%>%
        summarise(number=n(),
                  max=max(單價元平方公尺,na.rm = T),
                  min=min(單價元平方公尺,na.rm = T),
                  mean=mean(單價元平方公尺,na.rm = T),
                  median=median(單價元平方公尺,na.rm = T))%>%
        mutate(縣市=county[j],交易年=109-y,交易月=i,
               交易標的="房地(土地+建物)",
               變數="單價元平方公尺")
    }
  }
} 

for (y in 1:5){
  for (i in 1:12){
      list[[y]][[i]]<-bind_rows(list[[y]][[i]])
  }
  list[[y]]<-bind_rows(list[[y]])
}

county_summarize_price_m2_hl<-bind_rows(list)
setwd(wd)
write_rds(county_summarize_price_m2_hl,"20220518_county_summarize_price_m2_hl.rds")

##計算縣市中位數及平均數-單價-房地(土地+建物)+車位
tem<-property_trade109_105%>%
  filter(交易標的=="房地(土地+建物)+車位")

list<-list()
for (y in 1:5){
  list[[y]]<-list()
}

for (y in 1:5){
  for (i in 1:12){
    list[[y]][[i]]<-list()
  }
}

for (y in 1:5){
  for (i in 1:12){
    for (j in 1:22){
      list[[y]][[i]][[j]]<-list()
    }
  }
}

for (y in 1:5){
  for (i in 1:12){
    for (j in 1:22){
      list[[y]][[i]][[j]]<-tem%>%
        filter(縣市==county[j],
               交易年==109-y,交易月==i)%>%
        summarise(number=n(),
                  max=max(單價元平方公尺,na.rm = T),
                  min=min(單價元平方公尺,na.rm = T),
                  mean=mean(單價元平方公尺,na.rm = T),
                  median=median(單價元平方公尺,na.rm = T))%>%
        mutate(縣市=county[j],交易年=109-y,交易月=i,
                 交易標的="房地(土地+建物)+車位",
                 變數="單價元平方公尺")
    }
  }
} 

for (y in 1:5){
  for (i in 1:12){
    list[[y]][[i]]<-bind_rows(list[[y]][[i]])
  }
  list[[y]]<-bind_rows(list[[y]])
}
county_summarize_price_m2_hlc<-bind_rows(list)
setwd(wd)
write_rds(county_summarize_price_m2_hlc,"20220518_county_summarize_price_m2_hlc.rds")


##計算鄉鎮市區中位數及平均數-單價-房地(土地+建物)
town<-c("中正區","大同區","中山區","松山區","大安區","萬華區","信義區","士林區","北投區","內湖區","南港區","文山區",
  "中區","東區","南區","西區","北區","北屯區","西屯區","南屯區","太平區","大里區","霧峰區","烏日區","豐原區","后里區","石岡區","東勢區","新社區","潭子區","大雅區","神岡區","大肚區","沙鹿區","龍井區","梧棲區","清水區","大甲區","外埔區","大安區","和平區",
  "仁愛區","中正區","信義區","中山區","安樂區","暖暖區","七堵區",
  "中西區","東區","南區","北區","安平區","安南區","永康區","歸仁區","新化區","左鎮區","玉井區","楠西區","南化區","仁德區","關廟區","龍崎區","官田區","麻豆區","佳里區","西港區","七股區","將軍區","學甲區","北門區","新營區","後壁區","白河區","東山區","六甲區","下營區","柳營區","鹽水區","善化區","大內區","山上區","新市區","安定區",
  "楠梓區","左營區","鼓山區","三民區","鹽埕區","前金區","新興區","苓雅區","前鎮區","旗津區","小港區","鳳山區","大寮區","鳥松區","林園區","仁武區","大樹區","大社區","岡山區","路竹區","橋頭區","梓官區","彌陀區","永安區","燕巢區","田寮區","阿蓮區","茄萣區","湖內區","旗山區","美濃區","內門區","杉林區","甲仙區","六龜區","茂林區","桃源區","那瑪夏區",
  "板橋區","新莊區","中和區","永和區","土城區","樹林區","三峽區","鶯歌區","三重區","蘆洲區","五股區","泰山區","林口區","八里區","淡水區","三芝區","石門區","金山區","萬里區","汐止區","瑞芳區","貢寮區","平溪區","雙溪區","新店區","深坑區","石碇區","坪林區","烏來區",
  "宜蘭市","頭城鎮","羅東鎮","蘇澳鎮","礁溪鄉","壯圍鄉","員山鄉","冬山鄉","五結鄉","三星鄉","大同鄉","南澳鄉",
  "桃園區","中壢區","平鎮區","八德區","楊梅區","蘆竹區","大溪區","龍潭區","龜山區","大園區","觀音區","新屋區","復興區",
  "東區","西區",
  "竹北市","竹東鎮","新埔鎮","關西鎮","湖口鄉","新豐鄉","峨眉鄉","寶山鄉","北埔鄉","芎林鄉","橫山鄉","尖石鄉","五峰鄉",
  "苗栗市","頭份市","竹南鎮","後龍鎮","通霄鎮","苑裡鎮","卓蘭鎮","造橋鄉","西湖鄉","頭屋鄉","公館鄉","銅鑼鄉","三義鄉","大湖鄉","獅潭鄉","三灣鄉","南庄鄉","泰安鄉",
  "南投市","埔里鎮","草屯鎮","竹山鎮","集集鎮","名間鄉","鹿谷鄉","中寮鄉","魚池鄉","國姓鄉","水里鄉","信義鄉","仁愛鄉",
  "彰化市","員林市","和美鎮","鹿港鎮","溪湖鎮","二林鎮","田中鎮","北斗鎮","花壇鄉","芬園鄉","大村鄉","永靖鄉","伸港鄉","線西鄉","福興鄉","秀水鄉","埔心鄉","埔鹽鄉","大城鄉","芳苑鄉","竹塘鄉","社頭鄉","二水鄉","田尾鄉","埤頭鄉","溪州鄉",
  "東區","北區","香山區",
  "斗六市","斗南鎮","虎尾鎮","西螺鎮","土庫鎮","北港鎮","林內鄉","古坑鄉","大埤鄉","莿桐鄉","褒忠鄉","二崙鄉","崙背鄉","麥寮鄉","臺西鄉","東勢鄉","元長鄉","四湖鄉","口湖鄉","水林鄉",
  "太保市","朴子市","布袋鎮","大林鎮","民雄鄉","溪口鄉","新港鄉","六腳鄉","東石鄉","義竹鄉","鹿草鄉","水上鄉","中埔鄉","竹崎鄉","梅山鄉","番路鄉","大埔鄉","阿里山鄉",
  "屏東市","潮州鎮","東港鎮","恆春鎮","萬丹鄉","長治鄉","麟洛鄉","九如鄉","里港鄉","鹽埔鄉","高樹鄉","萬巒鄉","內埔鄉","竹田鄉","新埤鄉","枋寮鄉","新園鄉","崁頂鄉","林邊鄉","南州鄉","佳冬鄉","琉球鄉","車城鄉","滿州鄉","枋山鄉","霧臺鄉","瑪家鄉","泰武鄉","來義鄉","春日鄉","獅子鄉","牡丹鄉","三地門鄉",
  "花蓮市","鳳林鎮","玉里鎮","新城鄉","吉安鄉","壽豐鄉","光復鄉","豐濱鄉","瑞穗鄉","富里鄉","秀林鄉","萬榮鄉","卓溪鄉",
  "臺東市","成功鎮","關山鎮","長濱鄉","池上鄉","東河鄉","鹿野鄉","卑南鄉","大武鄉","綠島鄉","太麻里鄉","海端鄉","延平鄉","金峰鄉","達仁鄉","蘭嶼鄉",
  "金城鎮","金湖鎮","金沙鎮","金寧鄉","烈嶼鄉","烏坵鄉",
  "馬公市","湖西鄉","白沙鄉","西嶼鄉","望安鄉","七美鄉",
  "南竿鄉","北竿鄉","莒光鄉","東引鄉")
town_num<-c(12,29,7,37,
            38,29,12,13,
            2,13,18,13,
            26,3,20,18,
            33,13,16,6,
            6,4)
num<-c(0,12,41,48,85,123,152,164,177,179,192,210,223,249,252,272,290,323,336,352,358,364,368)
tem<-property_trade109_105%>%
  filter(交易標的=="房地(土地+建物)")%>%
  select(縣市,鄉鎮市區,交易標的,交易年,交易月,單價元平方公尺)

list<-list()
for (y in 1:5){
  list[[y]]<-list()
}

for (y in 1:5){
  for (i in 1:12){
    list[[y]][[i]]<-list()
  }
}

for (y in 1:5){
  for (i in 1:12){
    for (j in 1:22){
      list[[y]][[i]][[j]]<-list()
    }
  }
}

for (y in 1:5){
  for (i in 1:12){
    for (j in 1:22){
      for (t in 1:town_num[j]){
        list[[y]][[i]][[j]][[t]]<-list()
      }
    }
  }
}


for (y in 1:2){
  for (i in 1:12){
    for (j in 1:22){
      for (t in 1:town_num[j]){
        list[[y]][[i]][[j]][[t]]<-tem%>%
          filter(縣市==county[j],鄉鎮市區==town[num[j]+t],
                 交易年==109-y,交易月==i)%>%
          summarise(number=n(),
                    max=max(單價元平方公尺,na.rm = T),
                    min=min(單價元平方公尺,na.rm = T),
                    mean=mean(單價元平方公尺,na.rm = T),
                    median=median(單價元平方公尺,na.rm = T))%>%
          mutate(縣市=county[j],鄉鎮市區=town[[num[j]+t]],
                 交易年=109-y,交易月=i,
                 交易標的="房地(土地+建物)",
                 變數="單價元平方公尺")
      }
    }
  }
} 

for (y in 1:5){
  for (i in 1:12){
    for (j in 1:22){
      list[[y]][[i]][[j]]<-bind_rows(list[[y]][[i]][[j]])
    }
    list[[y]][[i]]<-bind_rows(list[[y]][[i]])
  }
  list[[y]]<-bind_rows(list[[y]])
}
town_summarize_price_m2_hl<-bind_rows(list)
setwd(wd)
write_rds(town_summarize_price_m2_hl,"20220526_town_summarize_price_m2_hl.rds")


##hlc
tem<-property_trade109_105%>%
  filter(交易標的=="房地(土地+建物)+車位")%>%
  select(縣市,鄉鎮市區,交易標的,交易年,交易月,單價元平方公尺)

list<-list()
for (y in 1:5){
  list[[y]]<-list()
}

for (y in 1:5){
  for (i in 1:12){
    list[[y]][[i]]<-list()
  }
}

for (y in 1:5){
  for (i in 1:12){
    for (j in 1:22){
      list[[y]][[i]][[j]]<-list()
    }
  }
}

for (y in 1:5){
  for (i in 1:12){
    for (j in 1:22){
      for (t in 1:town_num[j]){
        list[[y]][[i]][[j]][[t]]<-list()
      }
    }
  }
}


for (y in 1:2){
  for (i in 1:12){
    for (j in 1:22){
      for (t in 1:town_num[j]){
        list[[y]][[i]][[j]][[t]]<-tem%>%
          filter(縣市==county[j],鄉鎮市區==town[num[j]+t],
                   交易年==109-y,交易月==i)%>%
          summarise(number=n(),
                    max=max(單價元平方公尺,na.rm = T),
                    min=min(單價元平方公尺,na.rm = T),
                    mean=mean(單價元平方公尺,na.rm = T),
                    median=median(單價元平方公尺,na.rm = T))%>%
          mutate(縣市=county[j],鄉鎮市區=town[[num[j]+t]],
                   交易年=109-y,交易月=i,
                   交易標的="房地(土地+建物)+車位",
                   變數="單價元平方公尺")
      }
    }
  }
} 

for (y in 1:5){
  for (i in 1:12){
    for (j in 1:22){
      list[[y]][[i]][[j]]<-bind_rows(list[[y]][[i]][[j]])
    }
    list[[y]][[i]]<-bind_rows(list[[y]][[i]])
  }
  list[[y]]<-bind_rows(list[[y]])
}
town_summarize_price_m2_hlc<-bind_rows(list)
setwd(wd)
write_rds(town_summarize_price_m2_hlc,"20220526_town_summarize_price_m2_hlc.rds")


##檢查有無鄉鎮市區每月都無資料_hl
list<-list()
for (i in 1:368){
  list[[i]]<-town_summarize_price_m2_hl%>%
    filter(鄉鎮市區==town[[i]])%>%
    summarise(number=sum(number))%>%
    mutate(鄉鎮市區=town[[i]])
}

register_google(key="AIzaSyDiJlt5pkcvFRDbqAdQS7T8oGCw-zNc-VU")
town_data<-town_summarize_price_m2_hl%>%
  filter(交易年==108,交易月==1)%>%
  select(縣市,鄉鎮市區)
town_na_hl<-bind_rows(list)
town_na_hl<-left_join(town_na_hl,town_data,by=c("鄉鎮市區"="鄉鎮市區"))%>%
  mutate(type="房地(土地+建物)",變數="單價元平方公尺")

##檢查有無鄉鎮市區每月都無資料_hl
list<-list()
for (i in 1:368){
  list[[i]]<-town_summarize_price_m2_hlc%>%
    filter(鄉鎮市區==town[[i]])%>%
    summarise(number=sum(number))%>%
    mutate(鄉鎮市區=town[[i]])
}

town_na_hlc<-bind_rows(list)
town_na_hlc<-left_join(town_na_hlc,town_data,by=c("鄉鎮市區"="鄉鎮市區"))%>%
  filter(number==0)%>%
  mutate(type="房地(土地+建物)+車位",變數="單價元平方公尺")



##交易標的長條圖
ggplot(taipei_property_trade109,aes(x=交易標的))+
  geom_bar()+
  theme(axis.text.x=element_text(vjust=-0.5,size=6,angle=-15,color="black"))
setwd(wd)
ggsave("109taipei_tradetarget_bar.png",height = 20,width = 20,unit="cm")


##房地地圖分析-point
register_google(key="AIzaSyDiJlt5pkcvFRDbqAdQS7T8oGCw-zNc-VU")
qmap("Taipei",zoom=12,maptype = "roadmap")+
  geom_point(data=filter(taipei_property_trade109,!單價=="",!交易標的=="車位"),
             aes(x=lon,y=lat,color=單價),size=2,alpha=0.3)+
  scale_color_gradient(low="white",high="red",limits=c(0,120))
setwd(wd)
ggsave("109taipei_price_m2.png",height = 20,width = 20,unit="cm")

qmap("Taipei",zoom=12,maptype = "roadmap")+
  geom_point(data=filter(taipei_property_trade109,!總價=="",!交易標的=="車位"),
             aes(x=lon,y=lat,color=總價),size=2,alpha=0.3)+
  scale_color_gradient(low="white",high="red",limits=c(0,5))
setwd(wd)
ggsave("109taipei_totalprice.png",height = 20,width = 20,unit="cm")



##房地地圖分析-heat
taipei_property_trade109<-readRDS("C:/Users/min25/Desktop/實價登錄/data/modified/taipei_property_trade109.rds")
taipei_property_trade109<-mutate(taipei_property_trade109,
                                 單價=factor(taipei_property_trade109$屋齡))%>%
  filter(!屋齡=="",!交易標的=="車位")%>%
  select(屋齡,lon,lat)

qmap("Taipei",zoom=12,maptype = "roadmap")+
  stat_density2d(data=taipei_property_trade109,
                 aes(x=lon,y=lat,fill=..level..,alpha=..level..),
                 size=2,bins=40,geom="polygon")+
  scale_alpha_continuous(guide = F)+
  scale_fill_gradient(low="white",high="red")
setwd(wd)
ggsave("109taipei_houseage_heat.png",height = 20,width = 20,unit="cm")




##房地地圖分析-heat
taipei_property_trade109<-readRDS("C:/Users/min25/Desktop/實價登錄/data/modified/taipei_property_trade109.rds")
taipei_property_trade109<-mutate(taipei_property_trade109,
                                 單價=factor(taipei_property_trade109$單價))%>%
  filter(!單價=="",!交易標的=="車位")%>%
  select(單價,lon,lat)

qmap("Taipei",zoom=12,maptype = "roadmap")+
  stat_density2d(data=taipei_property_trade109,
                 aes(x=lon,y=lat,fill=..level..,alpha=..level..),
                 size=2,bins=50,geom="polygon")+
  scale_alpha_continuous(guide = F)+
  scale_fill_gradient(low="white",high="red")
setwd(wd)
ggsave("109taipei_price_m2_heat.png",height = 20,width = 20,unit="cm")




taipei_property_trade109<-readRDS("C:/Users/min25/Desktop/實價登錄/data/modified/taipei_property_trade109.rds")
taipei_property_trade109<-mutate(taipei_property_trade109,
                                 總價=factor(taipei_property_trade109$總價))%>%
  filter(!總價=="",!交易標的=="車位")%>%
  select(總價,lon,lat)

qmap("Taipei",zoom=12,maptype = "roadmap")+
  stat_density2d(data=taipei_property_trade109,
             aes(x=lon,y=lat,fill=..level..,alpha=..level..),
             size=2,bins=50,geom="polygon")+
  scale_alpha_continuous(guide = F)+
  scale_fill_gradient(low="white",high="red")
setwd(wd)
ggsave("109taipei_totalprice_heat.png",height = 20,width = 20,unit="cm")










##不動產租賃
##創造儲存list
list<-list()
for (y in 1:2){
  list[[y]]<-list()
}

for (y in 1:2){
  for (i in 1:4){
    list[[y]][[i]]<-list()
  }
}

for (y in 1:2){
  for (i in 1:4){
    for (j in 1:22){
      list[[y]][[i]][[j]]<-list()
    }
  }
}


##離島縣市另外處裡
##109金門
for (i in 1:4){
  setwd(str_c("",wd,"/109/",qua[[i]],""))
  list[[1]][[i]][[20]]<-read_excel("w_lvr_land_c.xls",sheet="不動產租賃")%>%
    mutate(縣市=county[20],year=year[1],quarter=qua[i])%>%
    select(year,quarter,縣市,everything())
}

##109q1澎湖
setwd(str_c("",wd,"/109/q1"))
list[[1]][[1]][[21]]<-read_excel("x_lvr_land_c.xls",sheet="不動產租賃")%>%
  mutate(縣市=county[21],year=year[1],quarter=qua[1])%>%
  select(year,quarter,縣市,everything())

##108q4金門
setwd(str_c("",wd,"/108/q4"))
list[[2]][[4]][[20]]<-read_excel("w_lvr_land_c.xls",sheet="不動產租賃")%>%
  mutate(縣市=county[20],year=year[2],quarter=qua[4])%>%
  select(year,quarter,縣市,everything())

##108q1q2澎湖
for (i in 1:2){
  setwd(str_c("",wd,"/108/",qua[[i]],""))
  list[[2]][[i]][[21]]<-read_excel("x_lvr_land_c.xls",sheet="不動產租賃")%>%
    mutate(縣市=county[21],year=year[2],quarter=qua[i])%>%
    select(year,quarter,縣市,everything())
}
##108q4澎湖
setwd(str_c("",wd,"/108/q4"))
list[[2]][[4]][[21]]<-read_excel("x_lvr_land_c.xls",sheet="不動產租賃")%>%
  mutate(縣市=county[21],year=year[2],quarter=qua[4])%>%
  select(year,quarter,縣市,everything())

##讀取檔案
##加入縣市,年份,季度變數
##排序合併

for (y in 1:2){
  for (i in 1:4){
    setwd(str_c("",wd,"/",year[[y]],"/",qua[[i]],""))
    for (j in 1:19){
      list[[y]][[i]][[j]]<-read_excel(str_c("",alphabet[j],"_lvr_land_c.xls"),sheet="不動產租賃")%>%
        mutate(縣市=county[j],year=year[y],quarter=qua[i])%>%
        select(year,quarter,縣市,everything())
    }
    list[[y]][[i]]<-bind_rows(list[[y]][[i]])
  }
  list[[y]]<-bind_rows(list[[y]])
}


property_rent<-bind_rows(list)%>%
  filter(!鄉鎮市區=="The villages and towns urban district")
setwd(wd)
write_rds(property_rent,"property_rent109_108.rds")




##預售屋買賣
##創造儲存list
list<-list()
for (y in 1:2){
  list[[y]]<-list()
}

for (y in 1:2){
  for (i in 1:4){
    list[[y]][[i]]<-list()
  }
}

for (y in 1:2){
  for (i in 1:4){
    for (j in 1:22){
      list[[y]][[i]][[j]]<-list()
    }
  }
}

##台南市
for (i in 1:4){
  setwd(str_c("",wd,"/109/",qua[[i]],""))
  list[[1]][[i]][[4]]<-read_excel("d_lvr_land_b.xls",sheet="預售屋買賣")%>%
    mutate(縣市=county[4],year=year[1],quarter=qua[i])%>%
    select(year,quarter,縣市,everything())
}

setwd(str_c("",wd,"/108/q2"))
list[[2]][[2]][[4]]<-read_excel("d_lvr_land_b.xls",sheet="預售屋買賣")%>%
  mutate(縣市=county[4],year=year[2],quarter=qua[2])%>%
  select(year,quarter,縣市,everything())

setwd(str_c("",wd,"/108/q4"))
list[[2]][[4]][[4]]<-read_excel("d_lvr_land_b.xls",sheet="預售屋買賣")%>%
  mutate(縣市=county[4],year=year[2],quarter=qua[4])%>%
  select(year,quarter,縣市,everything())



##高雄市
for (i in 2:4){
  setwd(str_c("",wd,"/109/",qua[[i]],""))
  list[[1]][[i]][[5]]<-read_excel("e_lvr_land_b.xls",sheet="預售屋買賣")%>%
    mutate(縣市=county[5],year=year[1],quarter=qua[i])%>%
    select(year,quarter,縣市,everything())
}
for (i in 1:4){
  setwd(str_c("",wd,"/108/",qua[[i]],""))
  list[[2]][[i]][[5]]<-read_excel("e_lvr_land_b.xls",sheet="預售屋買賣")%>%
    mutate(縣市=county[5],year=year[2],quarter=qua[i])%>%
    select(year,quarter,縣市,everything())
}

##新北市
for (y in 1:2){
  for (i in 1:4){
    setwd(str_c("",wd,"/",year[[y]],"/",qua[[i]],""))
    list[[y]][[i]][[6]]<-read_excel("f_lvr_land_b.xls",sheet="預售屋買賣")%>%
      mutate(縣市=county[6],year=year[y],quarter=qua[i])%>%
      select(year,quarter,縣市,everything())
  }
}

##宜蘭縣
setwd(str_c("",wd,"/109/q2"))
list[[1]][[2]][[7]]<-read_excel("g_lvr_land_b.xls",sheet="預售屋買賣")%>%
  mutate(縣市=county[7],year=year[1],quarter=qua[2])%>%
  select(year,quarter,縣市,everything())
setwd(str_c("",wd,"/109/q4"))
list[[1]][[4]][[7]]<-read_excel("g_lvr_land_b.xls",sheet="預售屋買賣")%>%
  mutate(縣市=county[7],year=year[1],quarter=qua[4])%>%
  select(year,quarter,縣市,everything())
setwd(str_c("",wd,"/108/q1"))
list[[2]][[1]][[7]]<-read_excel("g_lvr_land_b.xls",sheet="預售屋買賣")%>%
  mutate(縣市=county[7],year=year[2],quarter=qua[1])%>%
  select(year,quarter,縣市,everything())
setwd(str_c("",wd,"/108/q3"))
list[[2]][[3]][[7]]<-read_excel("g_lvr_land_b.xls",sheet="預售屋買賣")%>%
  mutate(縣市=county[7],year=year[2],quarter=qua[3])%>%
  select(year,quarter,縣市,everything())

##桃園市
for (y in 1:2){
  for (i in 1:4){
    setwd(str_c("",wd,"/",year[[y]],"/",qua[[i]],""))
    list[[y]][[i]][[8]]<-read_excel("h_lvr_land_b.xls",sheet="預售屋買賣")%>%
      mutate(縣市=county[8],year=year[y],quarter=qua[i])%>%
      select(year,quarter,縣市,everything())
  }
}

##新竹縣
setwd(str_c("",wd,"/109/q1"))
list[[1]][[1]][[10]]<-read_excel("j_lvr_land_b.xls",sheet="預售屋買賣")%>%
  mutate(縣市=county[10],year=year[1],quarter=qua[1])%>%
  select(year,quarter,縣市,everything())
for (i in 3:4){
  setwd(str_c("",wd,"/109/",qua[[i]],""))
  list[[1]][[i]][[10]]<-read_excel("j_lvr_land_b.xls",sheet="預售屋買賣")%>%
    mutate(縣市=county[10],year=year[1],quarter=qua[i])%>%
    select(year,quarter,縣市,everything())
}
for (i in 1:4){
  setwd(str_c("",wd,"/108/",qua[[i]],""))
  list[[2]][[i]][[10]]<-read_excel("j_lvr_land_b.xls",sheet="預售屋買賣")%>%
    mutate(縣市=county[10],year=year[2],quarter=qua[i])%>%
    select(year,quarter,縣市,everything())
}



##苗栗縣
for (y in 1:2){
  for (i in 3:4){
    setwd(str_c("",wd,"/",year[[y]],"/",qua[[i]],""))
    list[[y]][[i]][[11]]<-read_excel("k_lvr_land_b.xls",sheet="預售屋買賣")%>%
      mutate(縣市=county[11],year=year[y],quarter=qua[i])%>%
      select(year,quarter,縣市,everything())
  }
}

##南投縣
setwd(str_c("",wd,"/109/q2"))
list[[1]][[2]][[12]]<-read_excel("m_lvr_land_b.xls",sheet="預售屋買賣")%>%
  mutate(縣市=county[12],year=year[1],quarter=qua[2])%>%
  select(year,quarter,縣市,everything())


##新竹市
for (y in 1:2){
  for (i in 1:4){
    setwd(str_c("",wd,"/",year[[y]],"/",qua[[i]],""))
    list[[y]][[i]][[14]]<-read_excel("o_lvr_land_b.xls",sheet="預售屋買賣")%>%
      mutate(縣市=county[14],year=year[y],quarter=qua[i])%>%
      select(year,quarter,縣市,everything())
  }
}

##金門縣
setwd(str_c("",wd,"/109/q2"))
list[[1]][[2]][[20]]<-read_excel("w_lvr_land_b.xls",sheet="預售屋買賣")%>%
  mutate(縣市=county[20],year=year[1],quarter=qua[2])%>%
  select(year,quarter,縣市,everything())


##台北市,台中市,基隆市
##合併檔案
for (y in 1:2){
  for (i in 1:4){
    setwd(str_c("",wd,"/",year[[y]],"/",qua[[i]],""))
    for (j in 1:3){
      list[[y]][[i]][[j]]<-read_excel(str_c("",alphabet[j],"_lvr_land_b.xls"),sheet="預售屋買賣")%>%
        mutate(縣市=county[j],year=year[y],quarter=qua[i])%>%
        select(year,quarter,縣市,everything())
    }
    list[[y]][[i]]<-bind_rows(list[[y]][[i]])
  }
  list[[y]]<-bind_rows(list[[y]])
}


pre_sale_trade<-bind_rows(list)%>%
  filter(!鄉鎮市區=="The villages and towns urban district")
setwd(wd)
write_rds(pre_sale_trade,"pre_sale_trade109_108.rds")