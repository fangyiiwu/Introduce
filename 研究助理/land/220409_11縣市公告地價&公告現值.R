#Edited: 03/24/2022 RA
#Task: combine 公告現值地價 excel
#Export file: 無。僅產生縣市的
#Data Using:C:\Users\philip\Dropbox\RA Workspace RA 2022\land\data\source\公告地價_土地現值
#檔案缺失請參照: 
#------------------------------------------------------------------------------
library("readxl")
library("tidyverse")

a<-c("A","B","C","D","E","F","G","H","I","J","K")
col<-c("county","district","duan_siau_duan","land_num","value","land")
options(max.print = 10000000)
#------------------------------------------------------------------------------
#花蓮縣各鄉鎮市區 
setwd("C:/Users/philip/Dropbox/RA Workspace RA 2022/land/data/source/公告現值_公告地價/花蓮縣/109")
a_hualien<-read.csv("109年花蓮縣公告土地現值及公告地價.csv",header = T)
colnames(a_hualien)<-col
#------------------------------------------------------------------------------
#金門縣
setwd("C:/Users/philip/Dropbox/RA Workspace RA 2022/land/data/source/公告現值_公告地價/金門縣/109")
kinmen_c<-c("金湖鎮","金沙鎮","金城鎮","金寧鄉","烈嶼鄉及烏坵鄉")
list_kinmen_value<-list()
list_kinmen_land<-list()
for (i in 1:5){
  list_kinmen_value[[i]]<-read.csv(str_c(kinmen_c[i],"109年公告土地現值.csv"),header = T)%>%
    mutate("行政區"=kinmen_c[i])%>%
    select("縣市","行政區","段名","地號","公告土地現值")
  list_kinmen_land[[i]]<-read.csv(str_c(kinmen_c[i],"109年公告地價.csv"),header = T)%>%
    mutate("行政區"=kinmen_c[i])%>%
    select("縣市","行政區","段名","地號","公告地價")
}
kinmen_value<-bind_rows(list_kinmen_value)
kinmen_land<-bind_rows(list_kinmen_land)
#全金門
a_kinmen<-merge(kinmen_value,kinmen_land,by=c("縣市","行政區","段名","地號"))
colnames(a_kinmen)<-col
a_kinmen$duan_siau_duan<-as.character(a_kinmen$duan_siau_duan)

#------------------------------------------------------------------------------
#屏東縣
setwd("C:/Users/philip/Dropbox/RA Workspace RA 2022/land/data/source/公告現值_公告地價/屏東縣/109")
pingtung_c<-c("屏東市","潮州鎮","東港鎮","恆春鎮","萬丹鄉","長治鄉","麟洛鄉","九如鄉","里港鄉","鹽埔鄉","高樹鄉","萬巒鄉","內埔鄉","竹田鄉","新埤鄉","枋寮鄉","新園鄉","崁頂鄉","林邊鄉","南州鄉","佳冬鄉","琉球鄉","車城鄉","滿州鄉","枋山鄉","三地門鄉","霧台鄉","瑪家鄉","泰武鄉","來義鄉","春日鄉","獅子鄉","牡丹鄉")
list_pingtung_land<-list()
list_pingtung_value<-list()
for (i in 1:33){
  list_pingtung_value[[i]]<-read.csv(str_c("屏東縣",pingtung_c[i],"109年度公告土地現值.csv"),header = T,
                                     sep = ",",fileEncoding = "UTF-8-BOM", stringsAsFactors=F)%>%
    mutate(district=pingtung_c[i])
  list_pingtung_land[[i]]<-read.csv(str_c("屏東縣",pingtung_c[i],"109年度公告地價.csv"),header = T,
                                    sep = ",",fileEncoding = "UTF-8-BOM",)%>%
    mutate(district=pingtung_c[i])
}  
#潮州鎮需先改成int，單獨處理
list_pingtung_value[[2]]$Year<-as.integer(list_pingtung_value[[2]]$Year)
list_pingtung_value[[2]]$Township<-as.integer(list_pingtung_value[[2]]$Township)
list_pingtung_value[[2]]$Section<-as.integer(list_pingtung_value[[2]]$Section)
list_pingtung_value[[2]]$Land.serial.no.<-as.integer(list_pingtung_value[[2]]$Land.serial.no.)
list_pingtung_value[[2]]$Current.land.value<-as.integer(list_pingtung_value[[2]]$Current.land.value)
#合併公告現值
pingtung_value<-bind_rows(list_pingtung_value)%>%
  select(Counties,district,Section,Land.serial.no.,Current.land.value)
#合併公告地價前，先解決公告地價(assessed)標題大小寫不同的問題
pingtung_land<-bind_rows(list_pingtung_land)
pingtung_land[is.na(pingtung_land)] <- 0
pingtung_land<-mutate(pingtung_land,land_value=Assessed.land.value+assessed.land.value)%>%
  select(Counties,district,Section,Land.serial.no.,land_value)

#全屏東
a_pingtung<-merge(pingtung_value,pingtung_land,by=c("Counties","district","Section","Land.serial.no."))
colnames(a_pingtung)<-col
a_pingtung$duan_siau_duan<-as.character(a_pingtung$duan_siau_duan)
#------------------------------------------------------------------------------
#基隆市各鄉鎮市區 
setwd("C:/Users/philip/Dropbox/RA Workspace RA 2022/land/data/source/公告現值_公告地價/基隆市/109")
a_keelung<-read.csv("109年公告土地現值及公告地價-基隆市.csv",header = T)
colnames(a_keelung)<-col
#------------------------------------------------------------------------------
#連江縣各鄉鎮市區 
setwd("C:/Users/philip/Dropbox/RA Workspace RA 2022/land/data/source/公告現值_公告地價/連江縣/109")
a_lienchiang<-read.csv("109年連江縣公告土地現值與公告地價.csv",header = F)%>%
  mutate("縣市別"="連江縣")%>%
  rename("行政區"=V2,"段小段"=V3,"地號"=V4,"公告現值"=V6,"公告地價"=V7)%>%
  select("縣市別","行政區","段小段","地號","公告現值","公告地價")
colnames(a_lienchiang)<-col
#------------------------------------------------------------------------------
#雲林縣各鄉鎮市區
setwd("C:/Users/philip/Dropbox/RA Workspace RA 2022/land/data/source/公告現值_公告地價/雲林縣/109")
yunlin_uc<-c("二崙鄉","土庫鎮","大埤鄉","元長鄉","斗六市","古坑鄉","四湖鄉","水林鄉")
yunlin_c<-c("東勢鄉","麥寮鄉","斗南鎮","虎尾鎮","西螺鎮","北港鎮","莿桐鄉","林內鄉","崙背鄉","褒忠鄉","台西鄉","口湖鄉")
list_yunlin_utf8<-list()
for (i in 1:8){
  list_yunlin_utf8[[i]]<-read.csv(str_c("109年公告土地現值暨公告地價-",yunlin_uc[i],".csv"),sep =",",
                                  fileEncoding="UTF-8-BOM")
}
list_yunlin<-list()
for (i in 1:12){
  list_yunlin[[i]]<-read.csv(str_c("109年公告土地現值暨公告地價-",yunlin_c[i],".csv"),sep =",")
} 
#東勢鄉、麥寮鄉"公告地價"是chr，所以先改成int
list_yunlin[[1]]$公告地價<-as.integer(list_yunlin[[1]]$公告地價)
list_yunlin[[2]]$公告地價<-as.integer(list_yunlin[[2]]$公告地價)
yunlin_1<-bind_rows(list_yunlin_utf8)
yunlin_2<-bind_rows(list_yunlin)
#欄位改名
colnames(yunlin_1)<-col
colnames(yunlin_2)<-col

#全雲林
a_yunlin<-bind_rows(yunlin_1,yunlin_2,yunlin_3,yunlin_4)
#------------------------------------------------------------------------------
#新竹市各鄉鎮市區
#無109，政府公開、市府公開、地政局都沒有

#------------------------------------------------------------------------------
#嘉義市各鄉鎮市區
#無109

#------------------------------------------------------------------------------
#嘉義縣各鄉鎮市區
setwd("C:/Users/philip/Dropbox/RA Workspace RA 2022/land/data/source/公告現值_公告地價/嘉義縣/109")
chiayi_value<-read.csv("嘉義縣109年公告土地現值資料.csv")%>%
  mutate("縣市別"="嘉義縣")%>%
  select("縣市別",everything())

chiayi_land<-read.csv("嘉義縣109年公告地價資料.csv")%>%
  mutate("縣市別"="嘉義縣")%>%
  select("縣市別",everything())

a_chiayi<-merge(chiayi_value,chiayi_land,by=c("縣市別","鄉鎮市區","段小段","地號"))

colnames(a_chiayi)<-col

#------------------------------------------------------------------------------
#臺東縣各鄉鎮市區
setwd("C:/Users/philip/Dropbox/RA Workspace RA 2022/land/data/source/公告現值_公告地價/臺東縣/109")
taitung_value<-read.csv("109年台東縣公告現值.csv")%>%
  mutate("縣市別"="臺東縣")%>%
  select("縣市別",everything())

taitung_land<-read.csv("109年台東縣公告地價.csv")%>%
  mutate("縣市別"="臺東縣")%>%
  select("縣市別",everything())

a_taitung<-merge(taitung_value,taitung_land,by=c("縣市別","鄉鎮市區","段小段","地號"))
colnames(a_taitung)<-col

#------------------------------------------------------------------------------
#澎湖縣各鄉鎮市區
setwd("C:/Users/philip/Dropbox/RA Workspace RA 2022/land/data/source/公告現值_公告地價/澎湖縣/109")
penghu_c<-c("馬公市","湖西鄉","白沙鄉","西嶼鄉","望安鄉","七美鄉")
list_penghu<-list()
for (i in 1:6){
  list_penghu[[i]]<-read.csv(str_c("澎湖縣",penghu_c[i],"109年公告地價暨公告土地現值批次資料.csv"), 
                             sep =",",fileEncoding="UTF-8-BOM")%>%
    mutate(district=penghu_c[i],county="澎湖縣")%>%
    select(county,district,"段別","地號","公告土地現值","公告地價")
}  

a_penghu<-bind_rows(list_penghu)
colnames(a_penghu)<-col
a_penghu$duan_siau_duan<-as.character(a_penghu$duan_siau_duan)

#------------------------------------------------------------------------------
#合併目前
combine<-bind_rows(a_chiayi,a_hualien,a_keelung,a_yunlin,a_kinmen,a_lienchiang,a_penghu,a_pingtung,a_taitung)
#把land_num改成character
combine$land_num<-as.character(combine$land_num)
is.na(combine)

#輸出combine
setwd("C:/Users/philip/Dropbox/RA Workspace RA 2022/land/data/modified")
save(combine, file = "220409_RA_花蓮縣到澎湖縣combine.RData")
