#Edited: 06/15/2022 RA
#Task: 
#   一、匯入檔案
#   二、將縣市升格前舊地名改成新的
#   三、加入level欄位判別全國、縣市、鄉鎮市區層級
#Export file: population\獨居老人\modified\220615_列冊需關懷獨居老人人數按鄉鎮市區別.rds

#Data Using
#population\獨居老人\source2.4.2列冊需關懷獨居老人人數按鄉鎮市區別_110年.xls

library("readxl")
library("tidyverse")
library("stringr")
library("writexl")
setwd("C:/芳益/NTPU碩班/研究助理/population/source")
#------------------------------------------------------------------------------------
#   一、匯入檔案
#104年之後
temp104<-read_xls("列冊需關懷獨居老人人數按鄉鎮市區別.xls",sheet=1,skip=3)
year104c<-c("county","county_eng",
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
year_104_long<-pivot_longer(temp104,"110年12月底_計":"104年12月底_女",names_to="time",
                            values_to="count")%>%
  mutate(year=str_sub(time,1,3),
         month=str_sub(time,5,6),
         type=str_sub(time,10))%>%
  select(county,county_eng,year,month,type,count)%>%
  filter(!is.na(count))
year_104_long$year<-as.numeric(year_104_long$year)
year_104_long$month<-as.numeric(year_104_long$month)

#100到103年
temp100_103<-read_xls("列冊需關懷獨居老人人數按鄉鎮市區別.xls",sheet=2,skip=3)
year100_103c<-c("county","county_eng",
                "103年底_計","103年底_男","103年底_女",
                "102年底_計","102年底_男","102年底_女",
                "101年底_計","101年底_男","101年底_女",
                "100年底_計","100年底_男","100年底_女")
colnames(temp100_103)<-year100_103c
year100_103_long<-pivot_longer(temp100_103,"103年底_計":"100年底_女",
                               names_to="time",values_to="count")%>%
  mutate(year=str_sub(time,1,3),
         month=12,
         type=str_sub(time,7))%>%
  select(county,county_eng,year,month,type,count)%>%
  filter(!is.na(count))
year100_103_long$year<-as.numeric(year100_103_long$year)

#99年之前
temp99_<-read_xls("列冊需關懷獨居老人人數按鄉鎮市區別.xls",sheet=3,skip=3)
year99c<-c("county","county_eng",
           "99年底_計","99年底_男","99年底_女",
           "98年底_計","98年底_男","98年底_女",
           "97年底_計","97年底_男","97年底_女",
           "96年底_計","96年底_男","96年底_女",
           "95年底_計","95年底_男","95年底_女")
colnames(temp99_)<-year99c
year99_long<-pivot_longer(temp99_,"99年底_計":"95年底_女",
                          names_to="time",values_to="count")%>%
  mutate(year=str_sub(time,1,2),
         month=12,
         type=str_sub(time,6))%>%
  select(county,county_eng,year,month,type,count)%>%
  filter(!is.na(count))
year99_long$year<-as.numeric(year99_long$year)

#------------------------------------------------------------------------------------
#   二、將縣市升格前舊地名改成新的
#概念:step1、filter抓出要改地名的，形成新的地名後與三年份檔案貼一起
#     step2、三年份和已修改檔案依「總計、縣市名、鄉鎮市區名」filter，mutate出層級後再bind_row(list)
########
#處理資料
year99_long$county<-gsub("\\s","",year99_long$county) #刪除county空格
year99_long$count<-as.numeric(year99_long$count)
anyNA(year99_long$count) #因原檔高雄市無資料，所以轉換時會產生NA

#step1、要改名: 臺北縣、桃園縣、台中縣、台南縣、高雄縣 的縣市和鄉鎮市區
#(1)鄉鎮市區改名，加上沒有縣市合併問題的縣市(99新北市、桃園市、103桃園市)
#要改名的區
county_old99<-c("桃園市","中壢市","平鎮市","八德市","楊梅鎮","大溪鎮","蘆竹鄉",                      #桃園縣
"大園鄉","龜山鄉","龍潭鄉","新屋鄉","觀音鄉","復興鄉",
"板橋市","三重市","中和市","永和市","新莊市","新店市","樹林市","鶯歌鎮","三峽鎮",                     #臺北縣
"淡水鎮","汐止市","瑞芳鎮","土城市","蘆洲市","五股鄉","泰山鄉","林口鄉","深坑鄉",
"石碇鄉","坪林鄉","三芝鄉","石門鄉","八里鄉","平溪鄉","雙溪鄉","貢寮鄉","金山鄉","萬里鄉","烏來鄉",   
"豐原市","東勢鎮","大甲鎮","清水鎮","沙鹿鎮","梧棲鎮","后里鄉","神岡鄉","潭子鄉","大雅鄉",            #臺中縣
"新社鄉","石岡鄉","外埔鄉","大安鄉","烏日鄉","大肚鄉","龍井鄉","霧峰鄉","太平市","大里市","和平鄉",
"新營市","鹽水鎮","白河鎮","柳營鄉","後壁鄉","東山鄉","麻豆鎮","下營鄉","六甲鄉","官田鄉",            #臺南縣
"大內鄉","佳里鎮","學甲鎮","西港鄉","七股鄉","將軍鄉","北門鄉","新化鎮","善化鎮","新市鄉","安定鄉",
"山上鄉","玉井鄉","楠西鄉","南化鄉","左鎮鄉","仁德鄉","歸仁鄉","關廟鄉","龍崎鄉","永康市",
"鳳山市","林園鄉","大寮鄉","大樹鄉","大社鄉","仁武鄉","鳥松鄉","岡山鎮","橋頭鄉",                     #高雄縣
"燕巢鄉","田寮鄉","阿蓮鄉","路竹鄉","湖內鄉","茄萣鄉","永安鄉","彌陀鄉","梓官鄉",
"旗山鎮","美濃鎮","六龜鄉","甲仙鄉","杉林鄉","內門鄉","茂林鄉","桃源鄉")

county_old103<-c("桃園市","中壢市","平鎮市","八德市","楊梅市","大溪鎮","蘆竹鄉",                       #桃園縣
                "大園鄉","龜山鄉","龍潭鄉","新屋鄉","觀音鄉","復興鄉")

list_1<-list()
for(j in 1:5){
  list_1[[j]]<-list()
}
for(j in 1:1){
  list_1[[j+3]]<-filter(year99_long,county=="臺北縣")%>%                #99新北市 改縣市名稱
    mutate(county2="新北市")%>%
    select(county2,year,month,type,count)
  list_1[[j+4]][[1]]<-filter(year99_long,county=="桃園縣")%>%           #99桃園縣 改縣市名稱
    mutate(county2="桃園市")%>%
    select(county2,year,month,type,count)
  list_1[[j+4]][[2]]<-filter(year100_103_long,county=="桃園縣")%>%      #103桃園縣 改縣市名稱
    mutate(county2="桃園市")%>%
    select(county2,year,month,type,count)
  for(i in 1:120){
    list_1[[j]][[i]]<-filter(year99_long,county==county_old99[i])%>%  #99臺北縣、桃園縣、台中縣、台南縣、高雄縣的區
    mutate(county2=str_c(str_sub(county,1,2),"區"))%>%                       
    select(county2,year,month,type,count)

    list_1[[j+1]]<-filter(year99_long,county=="那瑪夏鄉")%>%        #99高雄縣那瑪夏鄉
      mutate(county2=str_c(str_sub(county,1,3),"區"))%>%
      select(county2,year,month,type,count)

    list_1[[j+2]][[i]]<-filter(year100_103_long,county==county_old103[i])%>%  #103桃園縣的區
      mutate(county2=str_c(str_sub(county,1,2),"區"))%>%                       
      select(county2,year,month,type,count)
}
}
temp_1<-bind_rows(list_1)
temp_1$year<-as.numeric(temp_1$year)
temp_1<-rename(temp_1,county=county2)

#(2)有縣市合併問題的縣市改名，再加總
#改名
county_rename<-c("高雄縣","臺南縣","臺中縣")
county_original<-c("高雄市","臺南市","臺中市")

list_1.5<-list()
for(j in 1:2){
  list_1.5[[j]]<-list()
}
for(j in 1:1){
  for(i in 1:3){
    list_1.5[[j]][[i]]<-filter(year99_long,county==county_rename[i])%>%  #改縣市名稱
    mutate(county2=str_c(str_sub(county,1,2),"市"))%>%
    select(county2,year,month,type,count)%>%
    rename(county=county2)
    list_1.5[[j+1]][[i]]<-filter(year99_long,county==county_original[i])%>%  #匯入縣市名稱
    select(!county_eng)
}
}
temp_0<-bind_rows(list_1.5)
temp_0<-arrange(temp_0,county,year,type)

#縣&市加總
ty<-c("男","女","計")
list_2<-list()
for(i in 1:3){
  list_2[[i]]<-list()
}
for(i in 1:3){
for(j in 1:5){
  list_2[[i]][[j]]<-list()
}
}
for(i in 1:3){
 for(j in 1:5){
 for(k in 1:3){
   list_2[[i]][[j]][[k]]<-filter(temp_0,county==county_original[i],year==j+94,type==ty[k])%>%
     summarise(sum(count))%>%
     mutate(county=county_original[i],year=j+94,type=ty[k],month=12)%>%
     rename(count="sum(count)")%>%
   select(county,year,month,type,count)
} 
}
}
temp_2<-bind_rows(list_2[[1]])
temp_22<-bind_rows(list_2[[2]])
temp_222<-bind_rows(list_2[[3]])

adjust<-bind_rows(temp_1,temp_2,temp_22,temp_222)



#step 2、不用改名:list[縣市][22縣市]，mutate(level=縣市)；
#list[鄉鎮市區][3xx個]，mutate(level=鄉鎮市區)
#巢狀for:filter(combine_99_110,county=縣市c[i])%>% mutate(level="縣市")
#巢狀for:filter(combine_99_110,county=鄉鎮市區c[i])%>% mutate(level="鄉鎮市區")

#(1)扣除100_103_已修改且與現存地名撞名部分
temp100_103_long<-filter(year100_103_long,county!="桃園市")

#(2)扣除99_已修改部分且與現存地名撞名、舊有地名部分
temp99_long<-filter(year99_long,county!="臺中市")%>%filter(county!="臺南市")%>%
  filter(county!="高雄市")%>%filter(county!="桃園市")

#(3)把99~110年檔案和已修改並在一起
combine<-bind_rows(year_104_long,temp100_103_long,temp99_long,adjust)


#------------------------------------------------------------------------------------
#   三、加入level欄位判別全國、縣市、鄉鎮市區層級
#(1)依現有地名，篩選出名稱正確之縣市
#全國
#"總計"
#縣市
county_name<-c("新北市","臺北市","桃園市","臺中市","臺南市","高雄市","宜蘭縣","新竹縣","苗栗縣",
               "彰化縣","南投縣","雲林縣","嘉義縣","屏東縣","臺東縣","花蓮縣","澎湖縣","基隆市",
               "新竹市","嘉義市","金門縣","連江縣")

#鄉鎮市層級
district1_<-c("板橋區","三重區","中和區","永和區","新莊區","新店區","樹林區","鶯歌區","三峽區","淡水區","汐止區",
"瑞芳區","土城區","蘆洲區","五股區","泰山區","林口區","深坑區","石碇區","坪林區","三芝區","石門區",
"八里區","平溪區","雙溪區","貢寮區","金山區","萬里區","烏來區")
district2_<-c("松山區","信義區","大安區","中山區","中正區","大同區","萬華區","文山區","南港區","內湖區","士林區","北投區")
district3_<-c("桃園區","中壢區","大溪區","楊梅區","蘆竹區","大園區","龜山區","八德區","龍潭區","平鎮區","新屋區","觀音區","復興區")
district4_<-c("中區","東區","南區","西區","北區","西屯區","南屯區","大安區","北屯區","豐原區","東勢區","大甲區","清水區",      
"沙鹿區","梧棲區","后里區","神岡區","潭子區","大雅區","新社區","石岡區","外埔區","烏日區","大肚區","龍井區","霧峰區","太平區","大里區","和平區")
district5_<-c("東區","南區","北區","新營區","鹽水區","白河區","柳營區","後壁區","東山區","麻豆區","下營區","六甲區","官田區","大內區",      
"佳里區","學甲區","西港區","七股區","將軍區","北門區","新化區","善化區","新市區","安定區","山上區",      
"玉井區","楠西區","南化區","左鎮區","仁德區","歸仁區","關廟區","龍崎區","永康區","安南區","安平區","中西區")
district6_<-c("鹽埕區","鼓山區","左營區","楠梓區","三民區","新興區","前金區","苓雅區","前鎮區","旗津區","小港區",                       #高雄市
"鳳山區","林園區","大寮區","大樹區","大社區","仁武區","鳥松區","岡山區","橋頭區","燕巢區","田寮區",
"阿蓮區","路竹區","湖內區","茄萣區","永安區","彌陀區","梓官區","旗山區","美濃區","六龜區","甲仙區",
"杉林區","內門區","茂林區","桃源區","那瑪夏區")
district7_<-c("宜蘭市","羅東鎮","蘇澳鎮","頭城鎮","礁溪鄉","壯圍鄉","員山鄉","冬山鄉","五結鄉","三星鄉","大同鄉","南澳鄉")
district8_<-c("竹北市","關西鎮","新埔鎮","竹東鎮","湖口鄉","橫山鄉","新豐鄉","芎林鄉","寶山鄉","北埔鄉","峨眉鄉","尖石鄉","五峰鄉")
district9_<-c("苗栗市","苑裡鎮","通霄鎮","竹南鎮","頭份鎮","後龍鎮","卓蘭鎮","大湖鄉","公館鄉","銅鑼鄉","南庄鄉",
"頭屋鄉","三義鄉","西湖鄉","造橋鄉","三灣鄉","獅潭鄉","泰安鄉")
district10_<-c("彰化市","鹿港鎮","和美鎮","北斗鎮","員林鎮","溪湖鎮","田中鎮","二林鎮","線西鄉","伸港鄉","福興鄉",    
"秀水鄉","花壇鄉","芬園鄉","大村鄉","埔鹽鄉","埔心鄉","永靖鄉","社頭鄉","二水鄉","田尾鄉","埤頭鄉","芳苑鄉","大城鄉","竹塘鄉","溪州鄉")
district11_<-c("南投市","埔里鎮","草屯鎮","竹山鎮","集集鎮","名間鄉","鹿谷鄉","中寮鄉","魚池鄉","國姓鄉","水里鄉","信義鄉","仁愛鄉")
district12_<-c("斗六市","斗南鎮","虎尾鎮","西螺鎮","土庫鎮","北港鎮","古坑鄉","大埤鄉","莿桐鄉","林內鄉","二崙鄉",                     #雲林縣
"崙背鄉","麥寮鄉","東勢鄉","褒忠鄉","臺西鄉","元長鄉","四湖鄉","口湖鄉","水林鄉")
district13_<-c("太保市","朴子市","布袋鎮","大林鎮","民雄鄉","溪口鄉","新港鄉","六腳鄉","東石鄉","義竹鄉","鹿草鄉",                     #嘉義縣
"水上鄉","中埔鄉","竹崎鄉","梅山鄉","番路鄉","大埔鄉","阿里山鄉")
district14_<-c("屏東市","潮州鎮","東港鎮","恆春鎮","萬丹鄉","長治鄉","麟洛鄉","九如鄉","里港鄉","鹽埔鄉","高樹鄉",                     #屏東縣
"萬巒鄉","內埔鄉","竹田鄉","新埤鄉","枋寮鄉","新園鄉","崁頂鄉","林邊鄉","南州鄉","佳冬鄉","琉球鄉",
"車城鄉","滿州鄉","枋山鄉","三地門鄉","霧臺鄉","瑪家鄉","泰武鄉","來義鄉","春日鄉","獅子鄉","牡丹鄉")
district15_<-c("臺東市","成功鎮","關山鎮","卑南鄉","大武鄉","太麻里鄉","東河鄉","長濱鄉","鹿野鄉","池上鄉","綠島鄉",   #臺東縣
"延平鄉","海端鄉","達仁鄉","金峰鄉","蘭嶼鄉")
district16_<-c("花蓮市","鳳林鎮","玉里鎮","新城鄉","吉安鄉","壽豐鄉","光復鄉","豐濱鄉","瑞穗鄉","富里鄉","秀林鄉","萬榮鄉","卓溪鄉")#花蓮縣
district17_<-c("馬公市","湖西鄉","白沙鄉","西嶼鄉","望安鄉","七美鄉")                                                  #澎湖縣
district18_<-c("七堵區","暖暖區","仁愛區","安樂區","中山區","中正區","信義區")                                         #基隆市
district19_<-c("香山區","東區","北區")                                                                                 #新竹市 
district20_<-c("東區","西區")                                                                                          #嘉義市 
district21_<-c("金城鎮","金湖鎮","金沙鎮","金寧鄉","烈嶼鄉","烏坵鄉")                                                  #金門縣
district22_<-c("南竿鄉","北竿鄉","莒光鄉","東引鄉")                                                                    #連江縣

#(2)mutate出層級
list_level<-list()
for(j in 1:3){
  list_level[[j]]<-list()
}
for(j in 1:1){
  for(k in 1:22){
    list_level[[j]][[k]]<-list()
  }
}
for(j in 1:1){
  list_level[[j+2]]<-filter(combine,county=="總計")%>%
    mutate(level="全國")
  for(k in 1:22){
    list_level[[j+1]][[k]]<-filter(combine,county==county_name[k])%>%
      mutate(level="縣市",county2=county_name[k])
    for(i in 1:38){
    list_level[[j]][[k]][[i]]<-filter(combine,county==str_c("district",k,"_")[i])%>%
    mutate(level="鄉鎮市區",county2=county_name[k])
}
}
}

#合併三年
old_people_99_110<-bind_rows(list_level)
old_people_99_110<-select(old_people_99_110,!county_eng)%>%
  rename(district=county,county=couny2)
#雖原來三個sheet的觀察值總和應為22,332才對(11,730+4,692+5,910)，但縣市合併後99年有三個縣併入市，3x15=45，因此少45個觀察值變22,287合理

saveRDS(old_people_99_110,file = "列冊需關懷獨居老人人數按鄉鎮市區別.rds")

