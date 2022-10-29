* Edited: 12/09/2021 RA
* Task: producing data
* Export file: D:\ntpu\ntpu_pf\code\1209_RA.do

* Data Using
*人房地資料
import delimited "D:\ntpu\ntpu_pf\data\raw\export_from_vertica\2020全台_edit&grouping.csv"
*屋主資料
import delimited "D:\ntpu\year_city\2020.csv"

*Data transforming 1

*教育

*台北市

*台北市松山區
tab education having_house_type_cd if addr_city_cd == 63000010 & age >= 24, matcell(A) matrow(education_cd)
matrix list A
matrix list education_cd
putexcel set 台北市松山區.xlsx, sheet(教育) replace
putexcel save
putexcel A1=("2020台北市松山區教育") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(education_cd) B2=matrix(A)
putexcel save

*台北市信義區
tab education having_house_type_cd if addr_city_cd == 63000020 & age >= 24, matcell(A) matrow(education_cd)
matrix list A
matrix list education_cd
putexcel set 台北市信義區.xlsx, sheet(教育) replace
putexcel save
putexcel A1=("2020台北市信義區教育") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(education_cd) B2=matrix(A)
putexcel save

*台北市大安區
tab education having_house_type_cd if addr_city_cd == 63000030 & age >= 24, matcell(A) matrow(education_cd)
matrix list A
matrix list education_cd
putexcel set 台北市大安區.xlsx, sheet(教育) replace
putexcel save
putexcel A1=("2020台北市大安區教育") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(education_cd) B2=matrix(A)
putexcel save

*台北市中山區
tab education having_house_type_cd if addr_city_cd == 63000040 & age >= 24, matcell(A) matrow(education_cd)
matrix list A
matrix list education_cd
putexcel set 台北市中山區.xlsx, sheet(教育) replace
putexcel save
putexcel A1=("2020台北市中山區教育") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(education_cd) B2=matrix(A)
putexcel save

*台北市中正區
tab education having_house_type_cd if addr_city_cd == 63000050 & age >= 24, matcell(A) matrow(education_cd)
matrix list A
matrix list education_cd
putexcel set 台北市中正區.xlsx, sheet(教育) replace
putexcel save
putexcel A1=("2020台北市中正區教育") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(education_cd) B2=matrix(A)
putexcel save

*台北市大同區
tab education having_house_type_cd if addr_city_cd == 63000060 & age >= 24, matcell(A) matrow(education_cd)
matrix list A
matrix list education_cd
putexcel set 台北市大同區.xlsx, sheet(教育) replace
putexcel save
putexcel A1=("2020台北市大同區教育") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(education_cd) B2=matrix(A)
putexcel save

*台北市萬華區
tab education having_house_type_cd if addr_city_cd == 63000070 & age >= 24, matcell(A) matrow(education_cd)
matrix list A
putexcel set 台北市萬華區.xlsx, sheet(教育) replace
putexcel save
putexcel A1=("2020台北市萬華區教育") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(education_cd) B2=matrix(A)
putexcel save


*台北市文山區
tab education having_house_type_cd if addr_city_cd == 63000080 & age >= 24, matcell(A) matrow(education_cd)
matrix list A
putexcel set 台北市文山區.xlsx, sheet(教育) replace
putexcel save
putexcel A1=("2020台北市文山區教育") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(education_cd) B2=matrix(A)
putexcel save

*台北市南港區
tab education having_house_type_cd if addr_city_cd == 63000090 & age >= 24, matcell(A) matrow(education_cd)
matrix list A
putexcel set 台北市南港區.xlsx, sheet(教育) replace
putexcel save
putexcel A1=("2020台北市南港區教育") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(education_cd) B2=matrix(A)
putexcel save

*台北市內湖區
tab education having_house_type_cd if addr_city_cd == 63000100 & age >= 24, matcell(A) matrow(education_cd)
matrix list A
putexcel set 台北市內湖區.xlsx, sheet(教育) replace
putexcel save
putexcel A1=("2020台北市內湖區教育") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(education_cd) B2=matrix(A)
putexcel save

*台北市北投區
tab education having_house_type_cd if addr_city_cd == 63000120 & age >= 24, matcell(A) matrow(education_cd)
matrix list A
putexcel set 台北市北投區.xlsx, sheet(教育) replace
putexcel save
putexcel A1=("2020台北市北投區教育") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(education_cd) B2=matrix(A)
putexcel save

*-----------------婚姻----------------

*台北市松山區
tab marriage_cd having_house_type_cd if addr_city_cd == 63000010 & age >= 18, matcell(A) matrow(marriage_cd)
matrix list A
putexcel set 台北市松山區.xlsx, sheet(婚姻) modify
putexcel save
putexcel A1=("2020台北市松山區婚姻") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(marriage_cd) B2=matrix(A)
putexcel save

*台北市信義區
tab marriage_cd having_house_type_cd if addr_city_cd == 63000020 & age >= 24, matcell(A) matrow(marriage_cd)
matrix list A
putexcel set 台北市信義區.xlsx, sheet(婚姻) modify
putexcel save
putexcel A1=("2020台北市信義區婚姻") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(marriage_cd) B2=matrix(A)
putexcel save

*台北市大安區
tab marriage_cd having_house_type_cd if addr_city_cd == 63000030 & age >= 24, matcell(A) matrow(marriage_cd)
matrix list A
putexcel set 台北市大安區.xlsx, sheet(婚姻) modify
putexcel save
putexcel A1=("2020台北市大安區婚姻") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(marriage_cd) B2=matrix(A)
putexcel save

*台北市中山區
tab marriage_cd having_house_type_cd if addr_city_cd == 63000040 & age >= 24, matcell(A) matrow(marriage_cd)
matrix list A
putexcel set 台北市中山區.xlsx, sheet(婚姻) modify
putexcel save
putexcel A1=("2020台北市中山區婚姻") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(marriage_cd) B2=matrix(A)
putexcel save

*台北市中正區
tab marriage_cd having_house_type_cd if addr_city_cd == 63000050 & age >= 24, matcell(A) matrow(marriage_cd)
matrix list A
putexcel set 台北市中正區.xlsx, sheet(婚姻) modify
putexcel save
putexcel A1=("2020台北市中正區婚姻") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(marriage_cd) B2=matrix(A)
putexcel save

*台北市大同區
tab marriage_cd having_house_type_cd if addr_city_cd == 63000060 & age >= 24, matcell(A) matrow(marriage_cd)
matrix list A
putexcel set 台北市大同區.xlsx, sheet(婚姻) modify
putexcel save
putexcel A1=("2020台北市大同區婚姻") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(marriage_cd) B2=matrix(A)
putexcel save

*台北市萬華區
tab marriage_cd having_house_type_cd if addr_city_cd == 63000070 & age >= 24, matcell(A) matrow(marriage_cd)
matrix list A
putexcel set 台北市萬華區.xlsx, sheet(婚姻) modify
putexcel save
putexcel A1=("2020台北市萬華區婚姻") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(marriage_cd) B2=matrix(A)
putexcel save


*台北市文山區
tab marriage_cd having_house_type_cd if addr_city_cd == 63000080 & age >= 24, matcell(A) matrow(marriage_cd)
matrix list A
putexcel set 台北市文山區.xlsx, sheet(婚姻) modify
putexcel save
putexcel A1=("2020台北市文山區婚姻") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(marriage_cd) B2=matrix(A)
putexcel save

*台北市南港區
tab marriage_cd having_house_type_cd if addr_city_cd == 63000090 & age >= 24, matcell(A) matrow(marriage_cd)
matrix list A
putexcel set 台北市南港區.xlsx, sheet(婚姻) modify
putexcel save
putexcel A1=("2020台北市南港區婚姻") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(marriage_cd) B2=matrix(A)
putexcel save

*台北市內湖區
tab marriage_cd having_house_type_cd if addr_city_cd == 63000100 & age >= 24, matcell(A) matrow(marriage_cd)
matrix list A
putexcel set 台北市內湖區.xlsx, sheet(婚姻) modify
putexcel save
putexcel A1=("2020台北市內湖區婚姻") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(marriage_cd) B2=matrix(A)
putexcel save

*台北市北投區
tab marriage_cd having_house_type_cd if addr_city_cd == 63000120 & age >= 24, matcell(A) matrow(marriage_cd)
matrix list A
putexcel set 台北市北投區.xlsx, sheet(婚姻) modify
putexcel save
putexcel A1=("2020台北市北投區婚姻") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(marriage_cd) B2=matrix(A)
putexcel save

*-----------------家戶組成製表----------------

*台北市松山區
tab household_type_cd having_house_type_cd if addr_city_cd == 63000010 & age >= 18, matcell(A) matrow(household_type_cd)
matrix list A
putexcel set 台北市松山區.xlsx, sheet(家戶組成) modify
putexcel save
putexcel A1=("2020台北市松山區家戶組成") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(household_type_cd) B2=matrix(A)
putexcel save

*台北市信義區
tab household_type_cd having_house_type_cd if addr_city_cd == 63000020 & age >= 24, matcell(A) matrow(household_type_cd)
matrix list A
putexcel set 台北市信義區.xlsx, sheet(家戶組成) modify
putexcel save
putexcel A1=("2020台北市信義區家戶組成") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(household_type_cd) B2=matrix(A)
putexcel save

*台北市大安區
tab household_type_cd having_house_type_cd if addr_city_cd == 63000030 & age >= 24, matcell(A) matrow(household_type_cd)
matrix list A
putexcel set 台北市大安區.xlsx, sheet(家戶組成) modify
putexcel save
putexcel A1=("2020台北市大安區家戶組成") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(household_type_cd) B2=matrix(A)
putexcel save

*台北市中山區
tab household_type_cd having_house_type_cd if addr_city_cd == 63000040 & age >= 24, matcell(A) matrow(household_type_cd)
matrix list A
putexcel set 台北市中山區.xlsx, sheet(家戶組成) modify
putexcel save
putexcel A1=("2020台北市中山區家戶組成") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(household_type_cd) B2=matrix(A)
putexcel save

*台北市中正區
tab household_type_cd having_house_type_cd if addr_city_cd == 63000050 & age >= 24, matcell(A) matrow(household_type_cd)
matrix list A
putexcel set 台北市中正區.xlsx, sheet(家戶組成) modify
putexcel save
putexcel A1=("2020台北市中正區家戶組成") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(household_type_cd) B2=matrix(A)
putexcel save

*台北市大同區
tab household_type_cd having_house_type_cd if addr_city_cd == 63000060 & age >= 24, matcell(A) matrow(household_type_cd)
matrix list A
putexcel set 台北市大同區.xlsx, sheet(家戶組成) modify
putexcel save
putexcel A1=("2020台北市大同區家戶組成") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(household_type_cd) B2=matrix(A)
putexcel save

*台北市萬華區
tab household_type_cd having_house_type_cd if addr_city_cd == 63000070 & age >= 24, matcell(A) matrow(household_type_cd)
matrix list A
putexcel set 台北市萬華區.xlsx, sheet(家戶組成) modify
putexcel save
putexcel A1=("2020台北市萬華區家戶組成") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(household_type_cd) B2=matrix(A)
putexcel save


*台北市文山區
tab household_type_cd having_house_type_cd if addr_city_cd == 63000080 & age >= 24, matcell(A) matrow(household_type_cd)
matrix list A
putexcel set 台北市文山區.xlsx, sheet(家戶組成) modify
putexcel save
putexcel A1=("2020台北市文山區家戶組成") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(household_type_cd) B2=matrix(A)
putexcel save

*台北市南港區
tab household_type_cd having_house_type_cd if addr_city_cd == 63000090 & age >= 24, matcell(A) matrow(household_type_cd)
matrix list A
putexcel set 台北市南港區.xlsx, sheet(家戶組成) modify
putexcel save
putexcel A1=("2020台北市南港區家戶組成") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(household_type_cd) B2=matrix(A)
putexcel save

*台北市內湖區
tab household_type_cd having_house_type_cd if addr_city_cd == 63000100 & age >= 24, matcell(A) matrow(household_type_cd)
matrix list A
putexcel set 台北市內湖區.xlsx, sheet(家戶組成) modify
putexcel save
putexcel A1=("2020台北市內湖區家戶組成") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(household_type_cd) B2=matrix(A)
putexcel save

*台北市北投區
tab household_type_cd having_house_type_cd if addr_city_cd == 63000120 & age >= 24, matcell(A) matrow(household_type_cd)
matrix list A
putexcel set 台北市北投區.xlsx, sheet(家戶組成) modify
putexcel save
putexcel A1=("2020台北市北投區家戶組成") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(household_type_cd) B2=matrix(A)
putexcel save

*----------------年齡組別製表----------------

*台北市松山區
tab age_group having_house_type_cd if addr_city_cd == 63000010 & age >= 18, matcell(A) matrow(age_group)
matrix list A
putexcel set 台北市松山區.xlsx, sheet(年齡組別) modify
putexcel save
putexcel A1=("2020台北市松山區年齡組別") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(age_group) B2=matrix(A)
putexcel save

*台北市信義區
tab age_group having_house_type_cd if addr_city_cd == 63000020 & age >= 24, matcell(A) matrow(age_group)
matrix list A
putexcel set 台北市信義區.xlsx, sheet(年齡組別) modify
putexcel save
putexcel A1=("2020台北市信義區年齡組別") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(age_group) B2=matrix(A)
putexcel save

*台北市大安區
tab age_group having_house_type_cd if addr_city_cd == 63000030 & age >= 24, matcell(A) matrow(age_group)
matrix list A
putexcel set 台北市大安區.xlsx, sheet(年齡組別) modify
putexcel save
putexcel A1=("2020台北市大安區年齡組別") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(age_group) B2=matrix(A)
putexcel save

*台北市中山區
tab age_group having_house_type_cd if addr_city_cd == 63000040 & age >= 24, matcell(A) matrow(age_group)
matrix list A
putexcel set 台北市中山區.xlsx, sheet(年齡組別) modify
putexcel save
putexcel A1=("2020台北市中山區年齡組別") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(age_group) B2=matrix(A)
putexcel save

*台北市中正區
tab age_group having_house_type_cd if addr_city_cd == 63000050 & age >= 24, matcell(A) matrow(age_group)
matrix list A
putexcel set 台北市中正區.xlsx, sheet(年齡組別) modify
putexcel save
putexcel A1=("2020台北市中正區年齡組別") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(age_group) B2=matrix(A)
putexcel save

*台北市大同區
tab age_group having_house_type_cd if addr_city_cd == 63000060 & age >= 24, matcell(A) matrow(age_group)
matrix list A
putexcel set 台北市大同區.xlsx, sheet(年齡組別) modify
putexcel save
putexcel A1=("2020台北市大同區年齡組別") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(age_group) B2=matrix(A)
putexcel save

*台北市萬華區
tab age_group having_house_type_cd if addr_city_cd == 63000070 & age >= 24, matcell(A) matrow(age_group)
matrix list A
putexcel set 台北市萬華區.xlsx, sheet(年齡組別) modify
putexcel save
putexcel A1=("2020台北市萬華區年齡組別") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(age_group) B2=matrix(A)
putexcel save


*台北市文山區
tab age_group having_house_type_cd if addr_city_cd == 63000080 & age >= 24, matcell(A) matrow(age_group)
matrix list A
putexcel set 台北市文山區.xlsx, sheet(年齡組別) modify
putexcel save
putexcel A1=("2020台北市文山區年齡組別") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(age_group) B2=matrix(A)
putexcel save

*台北市南港區
tab age_group having_house_type_cd if addr_city_cd == 63000090 & age >= 24, matcell(A) matrow(age_group)
matrix list A
putexcel set 台北市南港區.xlsx, sheet(年齡組別) modify
putexcel save
putexcel A1=("2020台北市南港區年齡組別") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(age_group) B2=matrix(A)
putexcel save

*台北市內湖區
tab age_group having_house_type_cd if addr_city_cd == 63000100 & age >= 24, matcell(A) matrow(age_group)
matrix list A
putexcel set 台北市內湖區.xlsx, sheet(年齡組別) modify
putexcel save
putexcel A1=("2020台北市內湖區年齡組別") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(age_group) B2=matrix(A)
putexcel save

*台北市北投區
tab age_group having_house_type_cd if addr_city_cd == 63000120 & age >= 24, matcell(A) matrow(age_group)
matrix list A
putexcel set 台北市北投區.xlsx, sheet(年齡組別) modify
putexcel save
putexcel A1=("2020台北市北投區年齡組別") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(age_group) B2=matrix(A)
putexcel save

*=====================================新北市還沒開始做======================================
*教育
*新北市區
tab education having_house_type_cd if addr_city_cd == 67000010 & age >= 24, matcell(A) matrow(education_cd)
matrix list A
matrix list education_cd
putexcel set 新北市區.xlsx, sheet(教育) replace
putexcel save
putexcel A1=("2020新北市區教育") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(education_cd) B2=matrix(A)
putexcel save



*-----------------婚姻----------------

*新北市區
tab marriage_cd having_house_type_cd if addr_city_cd == 63000010 & age >= 18, matcell(A) matrow(marriage_cd)
matrix list A
putexcel set 新北市區.xlsx, sheet(婚姻) modify
putexcel save
putexcel A1=("2020新北市區婚姻") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(marriage_cd) B2=matrix(A)
putexcel save


*-----------------家戶組成製表----------------

*新北市區
tab household_type_cd having_house_type_cd if addr_city_cd == 63000010 & age >= 18, matcell(A) matrow(household_type_cd)
matrix list A
putexcel set 新北市區.xlsx, sheet(家戶組成) modify
putexcel save
putexcel A1=("2020新北市區家戶組成") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(household_type_cd) B2=matrix(A)
putexcel save


*----------------年齡組別製表----------------

*新北市區
tab age_group having_house_type_cd if addr_city_cd == 63000010 & age >= 18, matcell(A) matrow(age_group)
matrix list A
putexcel set 新北市區.xlsx, sheet(年齡組別) modify
putexcel save
putexcel A1=("2020新北市區年齡組別") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(age_group) B2=matrix(A)
putexcel save


*==============================================================================================================
*Data transforming 2

*2020全台各年齡層擁屋原因
tab age_group_cd register_reason_group_cd, matcell(A) matrow(age_group_cd)
matrix list A
putexcel set 2020全台各年齡層擁屋.xlsx
putexcel save
putexcel A1=("2020全台各年齡擁屋") B1=("A") C1=("B") D1=("C") E1=("D") F1=("E") G1=("F") 
putexcel A2=matrix(age_group_cd) B2=matrix(A)
putexcel save

*2020台北市各年齡層擁屋原因
tab age_group_cd register_reason_group_cd if county_cd == "A" , matcell(A) matrow(age_group_cd)
matrix list A
putexcel set 2020台北市各年齡層擁屋.xlsx
putexcel save
putexcel A1=("2020台北市各年齡層擁屋") B1=("A") C1=("B") D1=("C") E1=("D") F1=("E") G1=("F") 
putexcel A2=matrix(age_group_cd) B2=matrix(A)
putexcel save

*2020新北市各年齡層擁屋原因
tab age_group_cd register_reason_group_cd if county_cd == "F" , matcell(A) matrow(age_group_cd)
matrix list A
putexcel set 2020新北市各年齡層擁屋.xlsx
putexcel save
putexcel A1=("2020新北市各年齡層擁屋") B1=("A") C1=("B") D1=("C") E1=("D") F1=("E") G1=("F") 
putexcel A2=matrix(age_group_cd) B2=matrix(A)
putexcel save
