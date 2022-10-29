library("readxl")
library("tidyverse")
install.packages("writexl")
library("writexl")
library("scales")

setwd("C:/Users/philip/Desktop/table0118")

countycode<-c(10002,10004,10005,10007,10008,10009,10010,10013,
              10014,10015,10016,10017,10018,10020,63000,64000,
              65000,66000,67000,68000,9007,9020 )
countyname<-c("宜蘭縣","新竹縣","苗栗縣","彰化縣","南投縣","雲林縣",
              "嘉義縣","屏東縣","臺東縣","花蓮縣","澎湖縣","基隆市",
              "新竹市","嘉義市","臺北市","高雄市","新北市","臺中市",
              "臺南市","桃園市","連江縣","金門縣")


years<-c(2018,2019,2020)
#--------------------------------------------------
#擁屋原因x年齡組別
#####【county】
#檔案載入
county_all<-read_excel(str_c("220116_RA_擁屋_county_all.xlsx"))
#轉數字
county_all$category<-as.numeric(county_all$category)
county_all$A<-as.numeric(county_all$A)
county_all$B<-as.numeric(county_all$B)
county_all$C<-as.numeric(county_all$C)
county_all$D<-as.numeric(county_all$D)
county_all$E<-as.numeric(county_all$E)
county_all$FF<-as.numeric(county_all$FF)


#category改名，屋主age_group改成1~16
county_all_rename<-mutate(county_all,adj_category=if_else(category==0,1,
     if_else(category==1,1,
     if_else(category==2,1,
     if_else(category==3,1,
     if_else(category==4,2,
     if_else(category==5,3,
     if_else(category==6,4,
     if_else(category==7,5,
     if_else(category==8,6,
     if_else(category==9,7, 
     if_else(category==10,8,
     if_else(category==11,9,
     if_else(category==12,10,
     if_else(category==13,11,
     if_else(category==14,12,
     if_else(category==15,13,
     if_else(category==16,14,
     if_else(category==17,15,
     if_else(category==18,16,
     if_else(category==19,16,16)))))))))))))))))))))


##使用adj_category、county、code和year 的因子組合對cbind(A,B,C,D,E,FF) 數據進行加總。
#adj_category改名成中文

county_all_rename_sum<-aggregate(cbind(A,B,C,D,E,FF) ~ adj_category + county+code+year,
                                 data = county_all_rename, sum)%>%
  mutate(name_category=if_else(adj_category=="1","0  -19 ",
         if_else(adj_category=="2","20 - 24 ",
         if_else(adj_category=="3","25 - 29 ",
         if_else(adj_category=="4","30 - 34 ",
         if_else(adj_category=="5","35 - 39",
         if_else(adj_category=="6","40 - 44 ",
         if_else(adj_category=="7","45 - 49 ",
         if_else(adj_category=="8","50 - 54 ",
         if_else(adj_category=="9","55 - 59 ",
         if_else(adj_category=="10","60 - 64 ", 
         if_else(adj_category=="11","65 - 69 ",
         if_else(adj_category=="12","70 - 74",
         if_else(adj_category=="13","75 - 79 ",
         if_else(adj_category=="14","80 - 84 ",
         if_else(adj_category=="15","85 - 89 ","90+"))))))))))))))))


#######county
#j=年分3年，i=縣市22縣市
#開始loop
list<-list()
for (j in 1:3){
  list[[j]]<-list()
}
for (j in 1:3) {
  for (i in 1:22) {
    list[[j]][[i]]<-filter(county_all_rename_sum,code==countycode[i],year==years[j])%>%
      mutate(a= A,
             aa= percent(A/(A+B+C+D+E+FF)),
             b= B,
             bb= percent(B/(A+B+C+D+E+FF)),
             c= C,
             cc= percent(C/(A+B+C+D+E+FF)),
             d= D,
             dd= percent(D/(A+B+C+D+E+FF)),
             e= E,
             ee= percent(E/(A+B+C+D+E+FF)),
             f= FF,
             ff= percent(FF/(A+B+C+D+E+FF)),
             blank=c(" "),
             county2=county,
             code2=code,
             year2=year)%>%
      subset(select = c(-adj_category,-A, -B, -C,-D,-E,-FF,-year,-county,-code))%>%
      rbind(Newrow=c(" "),c(" "),c(" "),c(" "),c(" "),c(" "))%>%
      rbind(Newrow=c(str_c("10789年度 屋主取得建物方式 按年齡組別分類[",countyname[i+1],"]"),
                     " "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c("年齡組別","(a)"," ","(b)"," ","(c)"," ","(d)"," ","(e)"," ","(f)"," ",
                     " "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","第一次登記"," ","買賣"," ","贈與"," ","繼承",
                     " ","拍賣"," ","其他"," ",""," "," "," "," "))%>%
      rbind(Newrow=c(" ","n","%","n","%","n","%","n","%","n","%","n","%"," "," "," "," "))
    
  }
}
#整合&輸出
county_109_table<-bind_rows(list)
write_xlsx(county_109_table,"220116_RA_擁屋_county_107to109_後兩位.xlsx")



#---------------------------------------------------------------------------------------------------------------
#擁屋原因x年齡組別
#####【TW】
#檔案載入
tw_all<-read_excel(c("220110_RA_擁屋_tw_all.xlsx"))
#轉數字
tw_all$category<-as.numeric(tw_all$category)
tw_all$A<-as.numeric(tw_all$A)
tw_all$B<-as.numeric(tw_all$B)
tw_all$C<-as.numeric(tw_all$C)
tw_all$D<-as.numeric(tw_all$D)
tw_all$E<-as.numeric(tw_all$E)
tw_all$FF<-as.numeric(tw_all$FF)

#category改名，屋主age_group改成1~16
tw_all_rename<-mutate(tw_all,adj_category=if_else(category==0,1,
        if_else(category==1,1,
        if_else(category==2,1,
        if_else(category==3,1,
        if_else(category==4,2,
        if_else(category==5,3,
        if_else(category==6,4,
        if_else(category==7,5,
        if_else(category==8,6,
        if_else(category==9,7, 
        if_else(category==10,8,
        if_else(category==11,9,
        if_else(category==12,10,
        if_else(category==13,11,
        if_else(category==14,12,
        if_else(category==15,13,
        if_else(category==16,14,
        if_else(category==17,15,
        if_else(category==18,16,
        if_else(category==19,16,16)))))))))))))))))))))


##使用adj_category、code和year 的因子組合對cbind(A,B,C,D,E,FF) 數據進行加總。
#adj_category改名成中文

tw_all_rename_sum<-aggregate(cbind(A,B,C,D,E,FF) ~ adj_category+year,
                                 data = tw_all_rename, sum)%>%
  mutate(name_category=if_else(adj_category=="1","0  -19 ",
            if_else(adj_category=="2","20 - 24 ",
            if_else(adj_category=="3","25 - 29 ",
            if_else(adj_category=="4","30 - 34 ",
            if_else(adj_category=="5","35 - 39",
            if_else(adj_category=="6","40 - 44 ",
            if_else(adj_category=="7","45 - 49 ",
            if_else(adj_category=="8","50 - 54 ",
            if_else(adj_category=="9","55 - 59 ",
            if_else(adj_category=="10","60 - 64 ", 
            if_else(adj_category=="11","65 - 69 ",
            if_else(adj_category=="12","70 - 74",
            if_else(adj_category=="13","75 - 79 ",
            if_else(adj_category=="14","80 - 84 ",
            if_else(adj_category=="15","85 - 89 ","90+"))))))))))))))))

#######tw
#i=年分3年
#開始loop
list<-list()
  for (i in 1:3) {
    list[[i]]<-filter(tw_all_rename_sum,year==years[i])%>%
      mutate(a= A,
             aa= percent(A/(A+B+C+D+E+FF)),
             b= B,
             bb= percent(B/(A+B+C+D+E+FF)),
             c= C,
             cc= percent(C/(A+B+C+D+E+FF)),
             d= D,
             dd= percent(D/(A+B+C+D+E+FF)),
             e= E,
             ee= percent(E/(A+B+C+D+E+FF)),
             f= FF,
             ff= percent(FF/(A+B+C+D+E+FF)),
             blank=c(" "),
             year2=year)%>%
      subset(select = c(-adj_category,-A, -B, -C,-D,-E,-FF,-year))%>%
      rbind(Newrow=c(" "),c(" "),c(" "),c(" "),c(" "),c(" "))%>%
      rbind(Newrow=c("10789年度 屋主取得建物方式 按年齡組別分類[臺灣]",
                     " "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c("年齡組別","(a)"," ","(b)"," ","(c)"," ","(d)"," ","(e)"," ","(f)"," ",
                     " "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","第一次登記"," ","買賣"," ","贈與"," ","繼承",
                     " ","拍賣"," ","其他"," ",""," "," "," "," "))%>%
      rbind(Newrow=c(" ","n","%","n","%","n","%","n","%","n","%","n","%"," "," "," "," "))
    
  }

#整合&輸出
tw_109_table<-bind_rows(list)
write_xlsx(tw_109_table,"220116_RA_擁屋_tw_107to109_後兩位.xlsx")
