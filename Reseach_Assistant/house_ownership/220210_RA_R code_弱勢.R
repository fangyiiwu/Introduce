library("readxl")
library("tidyverse")
install.packages("writexl")
library("writexl")
library("scales")

setwd("C:/Users/philip/Desktop")

countycode<-c(10002,10004,10005,10007,10008,10009,10010,10013,
              10014,10015,10016,10017,10018,10020,63000,64000,
              65000,66000,67000,68000,90070,90200 )
countyname<-c("宜蘭???","???竹縣","??????縣","彰???縣","??????縣","??????縣",
              "???義???","屏東???","?????????","?????????","澎???縣","?????????",
              "???竹???","???義???","?????????","高??????","?????????","???中???",
              "?????????","桃??????","???江縣","?????????")

years<-c(2018,2019,2020)

#-----------------------------------
########county-107~109
#檔??????入
county_all<-read_excel("220210_RA_all_county_low_type.xlsx")
#轉數???
county_all$A<-as.numeric(county_all$A)
county_all$B<-as.numeric(county_all$B)
county_all$C1<-as.numeric(county_all$C1)
county_all$C2<-as.numeric(county_all$C2)
county_all$D1<-as.numeric(county_all$D1)
county_all$D2<-as.numeric(county_all$D2)
county_all$E<-as.numeric(county_all$E)
county_all$FF<-as.numeric(county_all$FF)
county_all$NU<-as.numeric(county_all$NU)

#??????loop
list<-list()
for (j in 1:3){
  list[[j]]<-list()
}
for (j in 1:3) {
  for (i in 1:22) {
    list[[j]][[i]]<-filter(county_all,code==countycode[i],year==years[j])%>%
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
             code2=code,
             type2=type,
             year2=year)%>%
      subset(select = c(-A, -B, -C1,-C2,-D1,-D2,-E,-FF,-NU,
                        -year,-county,-code,-type))%>%
      rbind(Newrow=c(" "),c(" "),c(" "),c(" "),c(" "),c(" "))%>%
      rbind(Newrow=c(str_c(years[j]-1911,"年度???????????? ???弱??????群??????[",countyname[i+1],"]"),
                     " "," "," "," "," "," "," "," ",
                     " "," "," "," "," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c("弱勢???群","?????????"," "," "," "," "," "," "," "," "," ",
                     "???屋???"," ","??????"," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","(a)"," ","(b)"," ","(c)"," ","(d)"," ","(e)"," ","(f)"," ","(g)"
                     ," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","???人??????"," ","???戶親屬??????"," ","??????戶親屬??????"," ","??????????????????本人???親屬??????",
                     " ","???體??????(a+b+c+d)"," ",""," ",""," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","n","%","n","%","n","%","n","%","n","%","n","%","n","%"," "," "," "," "))
    
  }
}
#??????&輸出
county_table<-bind_rows(list)
write_xlsx(county_table,"220210_RA_人房???_low_type_county.xlsx")

#------------------------------------------------------------------------

#####???TW???
#檔??????入
tw_all<-read_excel("220210_RA_all_tw_low_type.xlsx")
#轉數???
tw_all$A<-as.numeric(tw_all$A)
tw_all$B<-as.numeric(tw_all$B)
tw_all$C1<-as.numeric(tw_all$C1)
tw_all$C2<-as.numeric(tw_all$C2)
tw_all$D1<-as.numeric(tw_all$D1)
tw_all$D2<-as.numeric(tw_all$D2)
tw_all$E<-as.numeric(tw_all$E)
tw_all$FF<-as.numeric(tw_all$FF)
tw_all$NU<-as.numeric(tw_all$NU)

#??????loop
list<-list()
for (j in 1:3) {
  list[[j]]<-filter(tw_all,year==years[j])%>%
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
                        -year,-county,-type))%>%
      rbind(Newrow=c(" "),c(" "),c(" "),c(" "),c(" "),c(" "))%>%
      rbind(Newrow=c(str_c(years[j]-1911,"年度???????????? ???弱??????群??????(??????)"),
                     " "," "," "," "," "," "," "," ",
                     " "," "," "," "," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c("?????????"," "," "," "," "," "," "," "," "," ",
                     "???屋???"," ","??????"," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","(a)"," ","(b)"," ","(c)"," ","(d)"," ","(e)"," ","(f)"," ","(g)"
                     ," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","???人??????"," ","???戶親屬??????"," ","??????戶親屬??????"," ","??????????????????本人???親屬??????",
                     " ","???體??????(a+b+c+d)"," ",""," ",""," "," "," "," "," "," "," "," "," "," "))%>%
      rbind(Newrow=c(" ","n","%","n","%","n","%","n","%","n","%","n","%","n","%"," "," "," "," "))
    
}

#??????&輸出
tw_table<-bind_rows(list)
write_xlsx(tw_table,"220210_RA_人房???_low_type_tw.xlsx")