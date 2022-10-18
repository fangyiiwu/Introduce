#Edited: 01/12/2022 RA
#Task: 產生有算率表格的初步excel
#Export file: G:\共用雲端硬碟\RA 2021\住宅政策計畫\Tables\raw_尚未貼至excel
#Data Using:  G:\共用雲端硬碟\RA 2021\住宅政策計畫\Tables\Data\RA_export
#----------------------------------------------------------------------------------------
library("readxl")
library("tidyverse")
install.packages("writexl")
library("writexl")
install.packages("scales")
library("scales")
install.packages("Rcpp")
library("Rcpp")

setwd("C:/Users/hsien/Desktop/table220113")

countycode<-c(10002,10004,10005,10007,10008,10009,10010,10013,
              10014,10015,10016,10017,10018,10020,63000,64000,
              65000,66000,67000,68000,90070,90200 )
countyname<-c("宜蘭縣","新竹縣","苗栗縣","彰化縣","南投縣","雲林縣",
              "嘉義縣","屏東縣","臺東縣","花蓮縣","澎湖縣","基隆市",
              "新竹市","嘉義市","臺北市","高雄市","新北市","臺中市",
              "臺南市","桃園市","連江縣","金門縣","宜蘭縣")
sheet<-c("教育","婚姻","家戶組成","年齡組別")
years<-c(2018,2019,2020)

#------------------------------------------------------------------------------
#####【county】
#檔案載入
county_all<-read_excel(str_c("220113_RA_人房地_county_all_revise.xlsx"))
#轉數字
county_all$A<-as.numeric(county_all$A)
county_all$B<-as.numeric(county_all$B)
county_all$C1<-as.numeric(county_all$C1)
county_all$C2<-as.numeric(county_all$C2)
county_all$D1<-as.numeric(county_all$D1)
county_all$D2<-as.numeric(county_all$D2)
county_all$E<-as.numeric(county_all$E)
county_all$FF<-as.numeric(county_all$FF)
county_all$NU<-as.numeric(county_all$NU)
#------------------------------------------------------------------------------
#category名稱，要數字轉特定中文   
adj_edu<-filter(county_all,type=="教育")%>%
  mutate(adj_category=if_else(category=="1","國小與國小以下",
                              if_else(category=="2","大學以上",
                                      if_else(category=="3","大學",
                                              if_else(category=="4","高中",
                                                      if_else(category=="5","國中","未知"))))))

adj_marriage<-filter(county_all,type=="婚姻")%>%
  mutate(adj_category=if_else(category=="1","未婚",
                              if_else(category=="2","有偶",
                                      if_else(category=="3","離婚","喪偶"))))

adj_house<-filter(county_all,type=="家戶組成")%>%
  mutate(adj_category=if_else(category=="1","單人",
                              if_else(category=="2","夫婦",
                                      if_else(category=="3","三代",
                                              if_else(category=="4","祖孫",
                                                      if_else(category=="5","核心",
                                                              if_else(category=="6","單親","其他")))))))



adj_age<-filter(county_all,type=="年齡組別")%>%
  mutate(adj_category=if_else(category=="1","0  -19 歲",
                              if_else(category=="2","20 - 24 歲",
                                      if_else(category=="3","25 - 29 歲",
                                              if_else(category=="4","30 - 34 歲",
                                                      if_else(category=="5","35 - 39 歲",
                                                              if_else(category=="6","40 - 44 歲",
                                                                      if_else(category=="7","45 - 49 歲",
                                                                              if_else(category=="8","50 - 54 歲",
                                                                                      if_else(category=="9","55 - 59 歲",
                                                                                              if_else(category=="10","60 - 64 歲",
                                                                                                      if_else(category=="11","65 - 69 歲",
                                                                                                              if_else(category=="12","70 - 74 歲",
                                                                                                                      if_else(category=="13","75 - 79 歲",
                                                                                                                              if_else(category=="14","80 - 84 歲",
                                                                                                                                      if_else(category=="15","85 - 89 歲","90 歲以上"))))))))))))))))
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
##解法---改R:
#1、橫:    rbind算好位置，加入名字，形成表頭:  done
#2、直:   category用if type=="", the rename(1=...,2=...)，打好四種
#把 橫＋直＋內容，併成一個表格。有這種函數嗎？　形成表格



#######county-109
#開始loop
list<-list()
for (j in 1:4){
  list[[j]]<-list()
}
for (j in 1:4) {
  for (i in 1:22) {
    list[[j]][[i]]<-filter(county_all,code==countycode[i],type==sheet[j],year==2020)%>%
      mutate(a= A,
             aa= percent(A/(A+C1+C2+D1+D2+E+FF)),
             b= C1+D1,
             bb= percent((C1+D1)/(A+C1+C2+D1+D2+E+FF)),
             c= C2+D2,
             cc= percent((C2+D2)/(A+C1+C2+D1+D2+E+FF)),
             d= E+FF,
             dd= percent((E+FF)/(A+C1+C2+D1+D2+E+FF)),
             e= A+C1+C2+D1+D2+E+FF,
             ee= percent(e/(e+B+NU)),
             f= B,
             ff= percent(B/(e+B+NU)),
             g= NU,
             gg= percent(NU/(e+B+NU)),
             blank=c(" "),
             county2=county,
             code2=code,
             type2=type,
             year2=year)%>%
      subset(select = c(-A, -B, -C1,-C2,-D1,-D2,-E,-FF,-NU,
                        -year,-county,-code,-type))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c("109年度擁屋型態 按",countyname[i+1]," "," "," "," "," "," "," "," ",
                     " "," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","擁屋者"," "," "," "," "," "," "," "," "," ",
                     "無屋者"," ","其他"," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","(a)"," ","(b)"," ","(c)"," ","(d)"," ","(e)"," ","(f)"," ","(g)"
                     ," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","本人持有"," ","同戶親屬持有"," ","非同戶親屬持有"," ","擁屋但住宅非本人或親屬持有",
                     " ","整體擁屋(a+b+c+d)"," ",""," ",""," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","n","%","n","%","n","%","n","%","n","%","n","%","n","%"," "," "," "," "))

  }
}
#整合&輸出
county_109_table<-bind_rows(list)
write_xlsx(county_109_table,"人房地_county_table_109.xlsx")


#------------------------------------------------------------------------------
#######county-108
#開始loop
list<-list()
for (j in 1:4){
  list[[j]]<-list()
}
for (j in 1:4) {
  for (i in 1:22) {
    list[[j]][[i]]<-filter(county_all,code==countycode[i],type==sheet[j],year==2019)%>%
      mutate(a= A,
             aa= percent(A/(A+C1+C2+D1+D2+E+FF)),
             b= C1+D1,
             bb= percent((C1+D1)/(A+C1+C2+D1+D2+E+FF)),
             c= C2+D2,
             cc= percent((C2+D2)/(A+C1+C2+D1+D2+E+FF)),
             d= E+FF,
             dd= percent((E+FF)/(A+C1+C2+D1+D2+E+FF)),
             e= A+C1+C2+D1+D2+E+FF,
             ee= percent(e/(e+B+NU)),
             f= B,
             ff= percent(B/(e+B+NU)),
             g= NU,
             gg= percent(NU/(e+B+NU)),
             blank=c(" "),
             county2=county,
             code2=code,
             type2=type,
             year2=year)%>%
      subset(select = c(-A, -B, -C1,-C2,-D1,-D2,-E,-FF,-NU,
                        -year,-county,-code,-type))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c("108年度擁屋型態 按",countyname[i+1]," "," "," "," "," "," "," "," ",
                     " "," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","擁屋者"," "," "," "," "," "," "," "," "," ",
                     "無屋者"," ","其他"," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","(a)"," ","(b)"," ","(c)"," ","(d)"," ","(e)"," ","(f)"," ","(g)"
                     ," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","本人持有"," ","同戶親屬持有"," ","非同戶親屬持有"," ","擁屋但住宅非本人或親屬持有",
                     " ","整體擁屋(a+b+c+d)"," ",""," ",""," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","n","%","n","%","n","%","n","%","n","%","n","%","n","%"," "," "," "," "))
    
  }
}
#整合&輸出
county_108_table<-bind_rows(list)
write_xlsx(county_108_table,"人房地_county_table_108.xlsx")


#------------------------------------------------------------------------------
########county-107
#開始loop
list<-list()
for (j in 1:4){
  list[[j]]<-list()
}
for (j in 1:4) {
  for (i in 1:22) {
    list[[j]][[i]]<-filter(county_all,code==countycode[i],type==sheet[j],year==2018)%>%
      mutate(a= A,
             aa= percent(A/(A+C1+C2+D1+D2+E+FF)),
             b= C1+D1,
             bb= percent((C1+D1)/(A+C1+C2+D1+D2+E+FF)),
             c= C2+D2,
             cc= percent((C2+D2)/(A+C1+C2+D1+D2+E+FF)),
             d= E+FF,
             dd= percent((E+FF)/(A+C1+C2+D1+D2+E+FF)),
             e= A+C1+C2+D1+D2+E+FF,
             ee= percent(e/(e+B+NU)),
             f= B,
             ff= percent(B/(e+B+NU)),
             g= NU,
             gg= percent(NU/(e+B+NU)),
             blank=c(" "),
             county2=county,
             code2=code,
             type2=type,
             year2=year)%>%
      subset(select = c(-A, -B, -C1,-C2,-D1,-D2,-E,-FF,-NU,
                        -year,-county,-code,-type))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c("107年度擁屋型態 按",countyname[i+1]," "," "," "," "," "," "," "," ",
                     " "," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","擁屋者"," "," "," "," "," "," "," "," "," ",
                     "無屋者"," ","其他"," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","(a)"," ","(b)"," ","(c)"," ","(d)"," ","(e)"," ","(f)"," ","(g)"
                     ," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","本人持有"," ","同戶親屬持有"," ","非同戶親屬持有"," ","擁屋但住宅非本人或親屬持有",
                     " ","整體擁屋(a+b+c+d)"," ",""," ",""," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","n","%","n","%","n","%","n","%","n","%","n","%","n","%"," "," "," "," "))
    
  }
}
#整合&輸出
county_107_table<-bind_rows(list)
write_xlsx(county_107_table,"人房地_county_table_107.xlsx")

#------------------------------------------------------------------------------
#####【TW】
#檔案載入
tw_all<-read_excel(str_c("220110_RA_人房地_tw_all.xlsx"))
#轉數字
tw_all$A<-as.numeric(tw_all$A)
tw_all$B<-as.numeric(tw_all$B)
tw_all$C1<-as.numeric(tw_all$C1)
tw_all$C2<-as.numeric(tw_all$C2)
tw_all$D1<-as.numeric(tw_all$D1)
tw_all$D2<-as.numeric(tw_all$D2)
tw_all$E<-as.numeric(tw_all$E)
tw_all$FF<-as.numeric(tw_all$FF)
tw_all$NU<-as.numeric(tw_all$NU)

###tw--107~109
#開始loop
list<-list()
for (j in 1:3){
  list[[j]]<-list()
}
for (j in 1:3) {
  for (i in 1:4) {
    list[[j]][[i]]<-filter(tw_all,type==sheet[i],year==years[j])%>%
      mutate(a= A,
             aa= percent(A/(A+C1+C2+D1+D2+E+FF)),
             b= C1+D1,
             bb= percent((C1+D1)/(A+C1+C2+D1+D2+E+FF)),
             c= C2+D2,
             cc= percent((C2+D2)/(A+C1+C2+D1+D2+E+FF)),
             d= E+FF,
             dd= percent((E+FF)/(A+C1+C2+D1+D2+E+FF)),
             e= A+C1+C2+D1+D2+E+FF,
             ee= percent(e/(e+B+NU)),
             f= B,
             ff= percent(B/(e+B+NU)),
             g= NU,
             gg= percent(NU/(e+B+NU)),
             blank=c(" "),
             county2=county,
             type2=type,
             year2=year)%>%
      subset(select = c(-A, -B, -C1,-C2,-D1,-D2,-E,-FF,-NU,
                        -year,-county,-type,-cate))%>%
      rbind(Newrow=c(" "))%>%
      rbind(Newrow=c(years[j]-1911,"年度擁屋型態 按"," "," "," "," "," "," "," "," ",
                     " "," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","擁屋者"," "," "," "," "," "," "," "," "," ",
                     "無屋者"," ","其他"," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","(a)"," ","(b)"," ","(c)"," ","(d)"," ","(e)"," ","(f)"," ","(g)"
                     ," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","本人持有"," ","同戶親屬持有"," ","非同戶親屬持有"," ","擁屋但住宅非本人或親屬持有",
                     " ","整體擁屋(a+b+c+d)"," ",""," ",""," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","n","%","n","%","n","%","n","%","n","%","n","%","n","%"," "," "," "," "))
    
  }
}
#整合&輸出
tw_107to109_table<-bind_rows(list)
write_xlsx(tw_107to109_table,"人房地_tw_107to109.xlsx")


