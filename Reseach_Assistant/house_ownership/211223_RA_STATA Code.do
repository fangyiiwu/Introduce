* Edited: 12/23/2021 RA
* Task: producing data
* Export file: D:\ntpu\ntpu_pf\code\1223_RA.do

* Data Using
import delimited "D:\ntpu\ntpu_pf\data\modified\1216\only_PSI_data.csv"

*Data transforming

*==============================================================================================================
*創建縣市變數使loop能執行
gen county_cd_num= county_cd
destring county_cd_num, replace

gen county_cd_num= 0 if county_cd == "0"
replace county_cd_num = 63000  if county_cd == "A"
replace county_cd_num =66000 if county_cd == "B"
replace county_cd_num =10017  if county_cd == "C"
replace county_cd_num =67000  if county_cd == "D"
replace county_cd_num =64000  if county_cd == "E"
replace county_cd_num =65000  if county_cd == "F"
replace county_cd_num =10002 if county_cd == "G"
replace county_cd_num =68000  if county_cd == "H"
replace county_cd_num =10020 if county_cd == "I"
replace county_cd_num =10004  if county_cd == "J"
replace county_cd_num =10005  if county_cd == "K"
replace county_cd_num =10008  if county_cd == "M"
replace county_cd_num =10007  if county_cd == "N"
replace county_cd_num =10018  if county_cd == "O"
replace county_cd_num =10009  if county_cd == "P"
replace county_cd_num =10010 if county_cd == "Q"
replace county_cd_num =10013 if county_cd == "T"
replace county_cd_num =10015  if county_cd == "U"
replace county_cd_num =10014  if county_cd == "V"
replace county_cd_num =9020  if county_cd == "W"
replace county_cd_num =10016  if county_cd == "X"
replace county_cd_num =9007  if county_cd == "Z"

*==============================================================================================================

*--2020 TW_擁屋原因 製表

tab age_group_cd register_reason_group_cd , matcell(A) matrow(age_group_cd)
matrix list A
putexcel set 2020_tw擁屋.xlsx
putexcel save
putexcel A1=("2020") B1=("A") C1=("B") D1=("C") E1=("D") F1=("E") G1=("F") 
putexcel A2=matrix(age_group_cd) B2=matrix(A)
putexcel save

*==============================================================================================================

*--2020 County層級 擁屋原因 製表

set trace on

levelsof county_cd_num, local(levels)
foreach l of local levels {
	tab age_group_cd register_reason_group_cd if county_cd_num == `l' , matcell(A) matrow(age_group_cd)
	matrix list A
	putexcel set 2020_county擁屋`l'.xlsx
	putexcel save
	putexcel A1=("2020_`l'") B1=("A") C1=("B") D1=("C") E1=("D") F1=("E") G1=("F") 
	putexcel A2=matrix(age_group_cd) B2=matrix(A)
	putexcel save
	
}

set trace off

*===================================================================================================================================
*--2020 town層級 教育、婚姻、家戶組成、年齡組成 製表

set trace on

levelsof addr_city_cd, local(levels)
foreach i of local levels {
	tab education having_house_type_cd if addr_city_cd == `i' & age >= 24, matcell(A) matrow(education_cd)
	putexcel set 2020_town_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2020`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	tab marriage having_house_type_cd if addr_city_cd == `i' & age >= 18, matcell(A) matrow(marriage)
	putexcel set 2020_town_`i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2020_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(A)
	putexcel save
	tab household_type having_house_type_cd if addr_city_cd == `i' & age >= 18, matcell(A) matrow(household_type)
	putexcel set 2020_town_`i'.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2020`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(A)
	putexcel save
	tab age_group2 having_house_type_cd if addr_city_cd == `i', matcell(A) matrow(age_group2)
	putexcel set 2020_town_`i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2020`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(A)
	putexcel save
}

set trace off

*==============================================================================================================

*--2020 county層級 教育、婚姻、家戶組成、年齡組成 製表
gen addr_city_cd_str= addr_city_cd
tostring addr_city_cd_str, replace
gen addr_county_cd_5 = substr(addr_city_cd_str, 1, 5)
gen addr_county_cd_num= addr_county_cd_5
destring addr_county_cd_num, replace

set trace on

local count = 0
levelsof addr_county_cd_num, local(levels)
foreach i of local levels {
	tab education having_house_type_cd if addr_county_cd_num == `i' & age >= 24, matcell(A) matrow(education_cd)
	putexcel set 2020_county_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2020`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	tab marriage having_house_type_cd if addr_county_cd_num == `i' & age >= 18, matcell(A) matrow(marriage)
	putexcel set 2020_county_`i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2020_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(A)
	putexcel save
	tab household_type having_house_type_cd if addr_county_cd_num == `i' & age >= 18, matcell(A) matrow(household_type)
	putexcel set 2020_county_`i'.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2020`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(A)
	putexcel save
	tab age_group2 having_house_type_cd if addr_county_cd_num == `i', matcell(A) matrow(age_group2)
	putexcel set 2020_county_`i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2020`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(A)
	putexcel save
}

set trace off

*==============================================================================================================

*--2020 TW 教育、婚姻、家戶組成、年齡組成 製表

	tab education having_house_type_cd if age >= 24, matcell(A) matrow(education_cd)
	putexcel set 2020_tw.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2020") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	tab marriage having_house_type_cd if age >= 18, matcell(A) matrow(marriage)
	putexcel set 2020_tw.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2020") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(A)
	putexcel save
	tab household_type having_house_type_cd if age >= 18, matcell(A) matrow(household_type)
	putexcel set 2020_tw.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2020") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(A)
	putexcel save
	tab age_group2 having_house_type_cd, matcell(A) matrow(age_group2)
	putexcel set 2020_tw.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2020") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(A)
	putexcel save
	

*==========================================================================
*以下的2018、2019當天只跑到一半，執行後就能攜出
*===================

*loop

*--2019 town層級 教育、婚姻、家戶組成、年齡組成 製表

set trace on

levelsof addr_city_cd, local(levels)
foreach i of local levels {
	tab education having_house_type_cd if addr_city_cd == `i' & age >= 24, matcell(A) matrow(education_cd)
	putexcel set 2019_town_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2019`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	tab marriage_cd having_house_type_cd if addr_city_cd == `i' & age >= 18, matcell(A) matrow(marriage_cd)
	putexcel set 2019_town_`i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2019_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(A)
	putexcel save
	tab household_type having_house_type_cd if addr_city_cd == `i' & age >= 18, matcell(A) matrow(household_type)
	putexcel set 2019_town_`i'.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2019`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(A)
	putexcel save
	tab age_group2 having_house_type_cd if addr_city_cd == `i', matcell(A) matrow(age_group2)
	putexcel set 2019_town_`i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2019`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(A)
	putexcel save
}

set trace off

*==============================================================================================================

*--2019 county層級 教育、婚姻、家戶組成、年齡組成 製表

gen addr_city_cd_str= addr_city_cd
tostring addr_city_cd_str, replace
gen addr_county_cd_5 = substr(addr_city_cd_str, 1, 5)
gen addr_county_cd_num= addr_county_cd_5
destring addr_county_cd_num, replace

set trace on

levelsof addr_county_cd, local(levels)
foreach i of local levels {
	tab education having_house_type_cd if addr_county_cd == `i' & age >= 24, matcell(A) matrow(education_cd)
	putexcel set 2019_county_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2019`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	tab marriage_cd having_house_type_cd if addr_county_cd == `i' & age >= 18, matcell(A) matrow(marriage_cd)
	putexcel set 2019_county_`i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2019_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(A)
	putexcel save
	tab household_type having_house_type_cd if addr_county_cd == `i' & age >= 18, matcell(A) matrow(household_type)
	putexcel set 2019_county_`i'.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2019`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(A)
	putexcel save
	tab age_group2 having_house_type_cd if addr_county_cd == `i', matcell(A) matrow(age_group2)
	putexcel set 2019_county_`i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2019`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(A)
	putexcel save
}

set trace off

*==============================================================================================================

*--2019 TW 教育、婚姻、家戶組成、年齡組成 製表

	tab education having_house_type_cd if age >= 24, matcell(A) matrow(education_cd)
	putexcel set 2019_tw.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2019") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	tab marriage_cd having_house_type_cd if age >= 18, matcell(A) matrow(marriage_cd)
	putexcel set 2019_tw.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2019") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(A)
	putexcel save
	tab household_type having_house_type_cd if age >= 18, matcell(A) matrow(household_type)
	putexcel set 2019_tw.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2019") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(A)
	putexcel save
	tab age_group2 having_house_type_cd, matcell(A) matrow(age_group2)
	putexcel set 2019_tw.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2019") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(A)
	putexcel save
	
	

*============================================================================================================================================================================================================================

*loop

*--2018 town層級 教育、婚姻、家戶組成、年齡組成 製表

set trace on

local count = 0
levelsof addr_city_cd, local(levels)
foreach i of local levels {
	tab education having_house_type_cd if addr_city_cd == `i' & age >= 24, matcell(A) matrow(education_cd)
	putexcel set 2018_town_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2018`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	tab marriage having_house_type_cd if addr_city_cd == `i' & age >= 18, matcell(A) matrow(marriage)
	putexcel set 2018_town_`i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2018_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(A)
	putexcel save
	tab household_type having_house_type_cd if addr_city_cd == `i' & age >= 18, matcell(A) matrow(household_type)
	putexcel set 2018_town_`i'.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2018`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(A)
	putexcel save
	tab age_group2 having_house_type_cd if addr_city_cd == `i', matcell(A) matrow(age_group2)
	putexcel set 2018_town_`i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2018`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(A)
	putexcel save
}

set trace off

*==============================================================================================================

*--2018 county層級 教育、婚姻、家戶組成、年齡組成 製表

gen addr_city_cd_str= addr_city_cd
tostring addr_city_cd_str, replace
gen addr_county_cd_5 = substr(addr_city_cd_str, 1, 5)
gen addr_county_cd_num= addr_county_cd_5
destring addr_county_cd_num, replace

set trace on

local count = 0
levelsof addr_county_cd, local(levels)
foreach i of local levels {
	tab education having_house_type_cd if addr_county_cd == `i' & age >= 24, matcell(A) matrow(education_cd)
	putexcel set 2018_county_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2018`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	tab marriage having_house_type_cd if addr_county_cd == `i' & age >= 18, matcell(A) matrow(marriage)
	putexcel set 2018_county_`i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2018_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(A)
	putexcel save
	tab household_type having_house_type_cd if addr_county_cd == `i' & age >= 18, matcell(A) matrow(household_type)
	putexcel set 2018_county_`i'.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2018`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(A)
	putexcel save
	tab age_group2 having_house_type_cd if addr_county_cd == `i', matcell(A) matrow(age_group2)
	putexcel set 2018_county_`i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2018`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(A)
	putexcel save
}

set trace off

*==============================================================================================================

*--2018 TW 教育、婚姻、家戶組成、年齡組成 製表

	tab education having_house_type_cd if age >= 24, matcell(A) matrow(education_cd)
	putexcel set 2018_tw.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2018") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	tab marriage having_house_type_cd if age >= 18, matcell(A) matrow(marriage)
	putexcel set 2018_tw.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2018") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(A)
	putexcel save
	tab household_type having_house_type_cd if age >= 18, matcell(A) matrow(household_type)
	putexcel set 2018_tw.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2018") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(A)
	putexcel save
	tab age_group2 having_house_type_cd, matcell(A) matrow(age_group2)
	putexcel set 2018_tw.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2018") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(A)
	putexcel save
	