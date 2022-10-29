install.packages("writexl")
library("readxl")
library("tidyverse")
library("writexl")
library("scales")

setwd("C:/Users/philip/Desktop")

countycode<-c(10002,10004,10005,10007,10008,10009,10010,10013,
              10014,10015,10016,10017,10018,10020,63000,64000,
              65000,66000,67000,68000,90070,90200 )
countyname<-c("宜蘭縣","新竹縣","苗栗縣","彰化縣","南投縣","雲林縣",
              "嘉義縣","屏東縣","臺東縣","花蓮縣","澎湖縣","基隆市",
              "新竹市","嘉義市","臺北市","高雄市","新北市","臺中市",
              "臺南市","桃園市","連江縣","金門縣")

years<-c(2018,2019,2020)


#--------------------------------------------------------------------------
########county-107~109
#檔案載入
county_all<-read_excel("220210_RA_all_county_low_type.xlsx")
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

#開始loop
list<-list()
for (j in 1:3){
  list[[j]]<-list()
}
for (j in 1:3) {
  for (i in 1:22) {
    #1、-1改成0 & 計算擁屋、無屋者、其他 & category改名字
    data_adj<-filter(county_all,code==countycode[i],year==years[j])%>%
      mutate(across(A:NU,~replace(.,which(.<0),0)))%>%
      mutate(cat.f=factor(category,
                          levels = c("0","1","2","3","4","5","6"),
                          labels = c("低收入戶(0)","低收入戶(1)","低收入戶(2)",
                                     "低收入戶(3)","低收入戶(4)",
                                     "中低收入戶","非中低收入戶")))%>%
      mutate(a= A,
             aa= percent(A/(A+C1+C2+D1+D2+E+FF),2),
             b= C1+D1,
             bb= percent((C1+D1)/(A+C1+C2+D1+D2+E+FF),2),
             c= C2+D2,
             cc= percent((C2+D2)/(A+C1+C2+D1+D2+E+FF),2),
             d= E+FF,
             dd= percent((E+FF)/(A+C1+C2+D1+D2+E+FF),2),
             e= A+C1+C2+D1+D2+E+FF,
             ee= percent(e/(e+B+NU),2),
             f= B,
             ff= percent(B/(e+B+NU),2),
             g= NU,
             gg= percent(NU/(e+B+NU),2),
             blank=c(" "),
             county2=county,
             code2=code,
             type2=type,
             year2=year)%>%
      subset(select = c(-A, -B, -C1,-C2,-D1,-D2,-E,-FF,-NU,
                        -year,-county,-type,-code))
    #2、新data frame加上0~4 sum 這行
    lowinc<-filter(data_adj,category!="5",category!="6")%>%
      group_by(year2)%>%
      summarise(a=sum(a),b=sum(b),c=sum(c),d=sum(d),e=sum(e),
                f=sum(f),g=sum(g))%>%
      mutate(aa=percent(a/e,2),bb=percent(b/e,2),cc=percent(c/e,2),dd=percent(d/e,2),
             ee=percent(e/(e+f+g),2),ff=percent(f/(e+f+g),2),gg=percent(g/(e+f+g),2),
             category="4a",cat.f="低收入戶")
    
    #3、新data frame併入
    list[[j]][[i]]<-filter(data_adj,year2==years[j])%>%
      bind_rows(lowinc)%>%
      arrange(category)%>%
      select(-category)%>%
      rbind(Newrow=c(" "),c(" "),c(" "),c(" "),c(" "),c(" "))%>%
      rbind(Newrow=c(str_c(years[j]-1911,"年度擁屋型態 按弱勢族群分類[",countyname[i+1],"]"),
                     " "," "," "," "," "," "," "," ",
                     " "," "," "," "," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","擁屋者"," "," "," "," "," "," "," "," "," ",
                     "無屋者"," ","其他"," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","(a)"," ","(b)"," ","(c)"," ","(d)"," ","(e)"," ","(f)"," ","(g)"
                     ," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","本人持有"," ","同戶親屬持有"," ","非同戶親屬持有"," ","擁屋但住宅非本人或親屬持有",
                     " ","整體擁屋(a+b+c+d)"," ",""," ",""," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","n","%","n","%","n","%","n","%","n","%","n","%","n","%"," "," "," "," "))
    

  }
}
#整合&輸出
county_table<-bind_rows(list)
write_xlsx(county_table,"220211_RA_人房地_low_type_county.xlsx")

#------------------------------------------------------------------------

#####【TW】
#檔案載入
tw_all<-read_excel("220210_RA_all_tw_low_type.xlsx")
#轉文字
tw_all$category<-as.character(tw_all$category)

#製表
list<-list()
for (j in 1:3) {
  #1、-1改成0 & 計算擁屋、無屋者、其他 & category改名字
  data_adj<-filter(tw_all,year==years[j])%>%
    mutate(across(A:NU,~replace(.,which(.<0),0)))%>%
    mutate(cat.f=factor(category,
                        levels = c("0","1","2","3","4","5","6"),
                        labels = c("低收入戶(0)","低收入戶(1)","低收入戶(2)",
                                   "低收入戶(3)","低收入戶(4)",
                                   "中低收入戶","非中低收入戶")))%>%
    mutate(a= A,
           aa= percent(A/(A+C1+C2+D1+D2+E+FF),2),
           b= C1+D1,
           bb= percent((C1+D1)/(A+C1+C2+D1+D2+E+FF),2),
           c= C2+D2,
           cc= percent((C2+D2)/(A+C1+C2+D1+D2+E+FF),2),
           d= E+FF,
           dd= percent((E+FF)/(A+C1+C2+D1+D2+E+FF),2),
           e= A+C1+C2+D1+D2+E+FF,
           ee= percent(e/(e+B+NU)),
           f= B,
           ff= percent(B/(e+B+NU),2),
           g= NU,
           gg= percent(NU/(e+B+NU),2),
           blank=c(" "),
           county2=county,
           year2=year)%>%
    subset(select = c(-A, -B, -C1,-C2,-D1,-D2,-E,-FF,-NU,
                      -year,-county,-type))
  #2、新data frame加上0~4 sum 這行
  lowinc<-filter(data_adj,category!="5",category!="6")%>%
    group_by(year2)%>%
    summarise(a=sum(a),b=sum(b),c=sum(c),d=sum(d),e=sum(e),
              f=sum(f),g=sum(g))%>%
    mutate(aa=percent(a/e,2),bb=percent(b/e,2),cc=percent(c/e,2),dd=percent(d/e,2),
           ee=percent(e/(e+f+g),2),ff=percent(f/(e+f+g),2),gg=percent(g/(e+f+g),2),
           category="4a",cat.f="低收入戶")
  #3、新data frame併入
  list[[j]]<-filter(data_adj,year2==years[j])%>%
    bind_rows(lowinc)%>%
    arrange(category)%>%
    select(-category)%>%
    rbind(Newrow=c(" "),c(" "),c(" "),c(" "),c(" "),c(" "))%>%
    rbind(Newrow=c(str_c(years[j]-1911,"年度擁屋型態 按弱勢族群分類(臺灣)"),
                   " "," "," "," "," "," "," "," ",
                   " "," "," "," "," "," "," "," "," "," "," "," "," "," "))%>%
    rbind(Newrow=c(" ","擁屋者"," "," "," "," "," "," "," "," "," ",
                   "無屋者"," ","其他"," "," "," "," "," "," "," "))%>%
    rbind(Newrow=c(" ","(a)"," ","(b)"," ","(c)"," ","(d)"," ","(e)"," ","(f)"," ","(g)"
                   ," "," "," "," "," "," "," "," "," "))%>%
    rbind(Newrow=c(" ","本人持有"," ","同戶親屬持有"," ","非同戶親屬持有"," ","擁屋但住宅非本人或親屬持有",
                   " ","整體擁屋(a+b+c+d)"," ",""," ",""," "," "," "," "," "," "," "," "," "," "))%>%
    rbind(Newrow=c(" ","n","%","n","%","n","%","n","%","n","%","n","%","n","%"," "," "," "," "))
  
}
tw_table<-bind_rows(list)
write_xlsx(tw_table,"220211_RA_人房地_low_type_tw.xlsx")