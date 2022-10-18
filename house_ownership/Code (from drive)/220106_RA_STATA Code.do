* Edited: 12/30/2021 RA
* Task: producing data
* Export file: D:\ntpu\ntpu_pf\code\220106_RA.do

*Data Editing
use "D:\ntpu\ntpu_pf\data\modified\2019全台_edited&grouping.dta"
cd "D:\ntpu\ntpu_pf\export\220106_table\2019人房地4表"


*==============================================================================================================

*--2019 county層級 教育、婚姻、家戶組成、年齡組成 製表

gen addr_city_cd_str= addr_city_cd
tostring addr_city_cd_str, replace
gen addr_county_cd_5 = substr(addr_city_cd_str, 1, 5)
gen addr_county_cd_num= addr_county_cd_5
destring addr_county_cd_num, replace

set trace on

levelsof addr_county_cd_num, local(levels)
foreach i of local levels {
	tab education having_house_type_cd if addr_county_cd_num == `i' & age >= 24, matcell(A) matrow(education_cd)
	putexcel set 2019_county_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2019`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	tab marriage having_house_type_cd if addr_county_cd_num == `i' & age >= 18, matcell(A) matrow(marriage)
	putexcel set 2019_county_`i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2019_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(A)
	putexcel save
	tab household_type having_house_type_cd if addr_county_cd_num == `i' & age >= 18, matcell(A) matrow(household_type)
	putexcel set 2019_county_`i'.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2019`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(A)
	putexcel save
	tab age_group2 having_house_type_cd if addr_county_cd_num == `i', matcell(A) matrow(age_group2)
	putexcel set 2019_county_`i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2019`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(A)
	putexcel save
}

set trace off

*==============================================================================================================

*2018 town層級 遮罩
set trace on

levelsof addr_city_cd, local(levels)
foreach i of local levels {
	import excel 2018_town_`i'.xlsx, sheet(教育) firstrow clear
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace G = -1 if G < 3
	replace H = -1 if H < 3
	replace I = -1 if I < 3
	replace J = -1 if J < 3
	mkmat B C D E F G H I J, matrix(mask)
	mkmat A, matrix(education_cd)
	putexcel set 2018_town_mask_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2018_town_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(mask)
	putexcel save
	import excel 2018_town_`i'.xlsx, sheet(婚姻) firstrow clear
	replace A = -1 if A < 3
	replace B = -1 if B < 3
	replace C1 = -1 if C1 < 3
	replace C2 = -1 if C2 < 3
	replace D1 = -1 if D1 < 3
	replace D2 = -1 if D2 < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace NULL = -1 if NULL < 3
	mkmat A B C1 C2 D1 D2 E F NULL, matrix(mask)
	mkmat _`i', matrix(marriage)
	putexcel set 2018_town_mask_`i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2018_town_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(mask)
	putexcel save
	import excel 2018_town_`i'.xlsx, sheet(家戶組成) firstrow clear
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace G = -1 if G < 3
	replace H = -1 if H < 3
	replace I = -1 if I < 3
	replace J = -1 if J < 3
	mkmat B C D E F G H I J, matrix(mask)
	mkmat A, matrix(household_type)
	putexcel set 2018_town_mask_`i'.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2018_town_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(mask)
	putexcel save
	import excel 2018_town_`i'.xlsx, sheet(年齡組別) firstrow clear
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace G = -1 if G < 3
	replace H = -1 if H < 3
	replace I = -1 if I < 3
	replace J = -1 if J < 3
	mkmat B C D E F G H I J, matrix(mask)
	mkmat A, matrix(age_group2)
	putexcel set 2018_town_mask_`i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2018_town_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(mask)
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

levelsof addr_county_cd_num, local(levels)
foreach i of local levels {
	tab education having_house_type_cd if addr_county_cd_num == `i' & age >= 24, matcell(A) matrow(education_cd)
	putexcel set 2018_county_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2018`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	tab marriage having_house_type_cd if addr_county_cd_num == `i' & age >= 18, matcell(A) matrow(marriage)
	putexcel set 2018_county_`i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2018_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(A)
	putexcel save
	tab household_type having_house_type_cd if addr_county_cd_num == `i' & age >= 18, matcell(A) matrow(household_type)
	putexcel set 2018_county_`i'.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2018`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(A)
	putexcel save
	tab age_group2 having_house_type_cd if addr_county_cd_num == `i', matcell(A) matrow(age_group2)
	putexcel set 2018_county_`i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2018`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(A)
	putexcel save
}

set trace off

*==============================================================================================================

*--2019 全台 教育、婚姻、家戶組成、年齡組成 製表

	tab education having_house_type_cd if age >= 24, matcell(A) matrow(education_cd)
	putexcel set 2019_tw.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2019") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	tab marriage having_house_type_cd if age >= 18, matcell(A) matrow(marriage)
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
	
*==============================================================================================================

*--2018 全台 教育、婚姻、家戶組成、年齡組成 製表

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
	
*==============================================================================================================	

*--2018 全台擁屋原因 製表

tab age_group_cd register_reason_group_cd , matcell(A) matrow(age_group_cd)
matrix list A
putexcel set 2018_tw擁屋.xlsx
putexcel save
putexcel A1=("2018") B1=("A") C1=("B") D1=("C") E1=("D") F1=("E") G1=("F") 
putexcel A2=matrix(age_group_cd) B2=matrix(A)
putexcel save

gen county_cd_num= 0 if org_cd == "0"
replace county_cd_num = 63000  if org_cd == "A"
replace county_cd_num =66000 if org_cd == "B"
replace county_cd_num =10017  if org_cd == "C"
replace county_cd_num =67000  if org_cd == "D"
replace county_cd_num =64000  if org_cd == "E"
replace county_cd_num =65000  if org_cd == "F"
replace county_cd_num =10002 if org_cd == "G"
replace county_cd_num =68000  if org_cd == "H"
replace county_cd_num =10020 if org_cd == "I"
replace county_cd_num =10004  if org_cd == "J"
replace county_cd_num =10005  if org_cd == "K"
replace county_cd_num =10008  if org_cd == "M"
replace county_cd_num =10007  if org_cd == "N"
replace county_cd_num =10018  if org_cd == "O"
replace county_cd_num =10009  if org_cd == "P"
replace county_cd_num =10010 if org_cd == "Q"
replace county_cd_num =10013 if org_cd == "T"
replace county_cd_num =10015  if org_cd == "U"
replace county_cd_num =10014  if org_cd == "V"
replace county_cd_num =9020  if org_cd == "W"
replace county_cd_num =10016  if org_cd == "X"
replace county_cd_num =9007  if org_cd == "Z"
destring county_cd_num, replace


*2018 county遮罩
set trace on

levelsof county_cd_num, local(levels)
foreach i of local levels {
	import excel 2018_county擁屋`i'.xlsx, firstrow clear
	replace A = -1 if A < 3
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	mkmat A B C D E F, matrix(mask)
	mkmat _`i', matrix(reason_cd)
	putexcel set 2018_county_mask_擁屋_`i'.xlsx, replace
	putexcel save
	putexcel A1=("2018_county擁屋_mask_`i'") B1=("A") C1=("B") D1=("C") E1=("D") F1=("E") G1=("F")
	putexcel A2=matrix(reason_cd) B2=matrix(mask)
	putexcel save
	
}

set trace off


*==============================================================================================================	
*2019擁屋原因
gen county_cd_num= 0 if org_cd == "0"
replace county_cd_num = 63000  if org_cd == "A"
replace county_cd_num =66000 if org_cd == "B"
replace county_cd_num =10017  if org_cd == "C"
replace county_cd_num =67000  if org_cd == "D"
replace county_cd_num =64000  if org_cd == "E"
replace county_cd_num =65000  if org_cd == "F"
replace county_cd_num =10002 if org_cd == "G"
replace county_cd_num =68000  if org_cd == "H"
replace county_cd_num =10020 if org_cd == "I"
replace county_cd_num =10004  if org_cd == "J"
replace county_cd_num =10005  if org_cd == "K"
replace county_cd_num =10008  if org_cd == "M"
replace county_cd_num =10007  if org_cd == "N"
replace county_cd_num =10018  if org_cd == "O"
replace county_cd_num =10009  if org_cd == "P"
replace county_cd_num =10010 if org_cd == "Q"
replace county_cd_num =10013 if org_cd == "T"
replace county_cd_num =10015  if org_cd == "U"
replace county_cd_num =10014  if org_cd == "V"
replace county_cd_num =9020  if org_cd == "W"
replace county_cd_num =10016  if org_cd == "X"
replace county_cd_num =9007  if org_cd == "Z"
destring county_cd_num, replace


*2019 county遮罩
set trace on

levelsof county_cd_num, local(levels)
foreach i of local levels {
	import excel 2019_county擁屋`i'.xlsx, firstrow clear
	replace A = -1 if A < 3
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	mkmat A B C D E F, matrix(mask)
	mkmat _`i', matrix(reason_cd)
	putexcel set 2019_county_mask_擁屋_`i'.xlsx, replace
	putexcel save
	putexcel A1=("2019_county擁屋_mask_`i'") B1=("A") C1=("B") D1=("C") E1=("D") F1=("E") G1=("F")
	putexcel A2=matrix(reason_cd) B2=matrix(mask)
	putexcel save
	
}

set trace off
*==============================================================================================================	
*2020擁屋原因
gen county_cd_num= 0 if org_cd == "0"
replace county_cd_num = 63000  if org_cd == "A"
replace county_cd_num =66000 if org_cd == "B"
replace county_cd_num =10017  if org_cd == "C"
replace county_cd_num =67000  if org_cd == "D"
replace county_cd_num =64000  if org_cd == "E"
replace county_cd_num =65000  if org_cd == "F"
replace county_cd_num =10002 if org_cd == "G"
replace county_cd_num =68000  if org_cd == "H"
replace county_cd_num =10020 if org_cd == "I"
replace county_cd_num =10004  if org_cd == "J"
replace county_cd_num =10005  if org_cd == "K"
replace county_cd_num =10008  if org_cd == "M"
replace county_cd_num =10007  if org_cd == "N"
replace county_cd_num =10018  if org_cd == "O"
replace county_cd_num =10009  if org_cd == "P"
replace county_cd_num =10010 if org_cd == "Q"
replace county_cd_num =10013 if org_cd == "T"
replace county_cd_num =10015  if org_cd == "U"
replace county_cd_num =10014  if org_cd == "V"
replace county_cd_num =9020  if org_cd == "W"
replace county_cd_num =10016  if org_cd == "X"
replace county_cd_num =9007  if org_cd == "Z"
destring county_cd_num, replace


*2020 county遮罩
set trace on

levelsof county_cd_num, local(levels)
foreach i of local levels {
	import excel 2020_county擁屋`i'.xlsx, firstrow clear
	replace A = -1 if A < 3
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	mkmat A B C D E F, matrix(mask)
	mkmat _`i', matrix(reason_cd)
	putexcel set 2020_county_mask_擁屋_`i'.xlsx, replace
	putexcel save
	putexcel A1=("2020_county擁屋_mask_`i'") B1=("A") C1=("B") D1=("C") E1=("D") F1=("E") G1=("F")
	putexcel A2=matrix(reason_cd) B2=matrix(mask)
	putexcel save
	
}

set trace off




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
	tab marriage having_house_type_cd if addr_city_cd == `i' & age >= 18, matcell(A) matrow(marriage_cd)
	putexcel set 2019_town_`i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2019_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage_cd) B2=matrix(A)
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







*--2018 county層級  遮

gen addr_city_cd_str= addr_city_cd
tostring addr_city_cd_str, replace
gen addr_county_cd_5 = substr(addr_city_cd_str, 1, 5)
gen addr_county_cd_num= addr_county_cd_5
destring addr_county_cd_num, replace


set trace on

levelsof addr_county_cd_num, local(levels)
foreach i of local levels {
	import excel 2018_county_`i'.xlsx, sheet(教育) firstrow clear
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace G = -1 if G < 3
	replace H = -1 if H < 3
	replace I = -1 if I < 3
	replace J = -1 if J < 3
	mkmat B C D E F G H I J, matrix(mask)
	mkmat A, matrix(education_cd)
	putexcel set 2018_county_mask_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2018_county_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(mask)
	putexcel save
	import excel 2018_county_`i'.xlsx, sheet(婚姻) firstrow clear
	replace A = -1 if A < 3
	replace B = -1 if B < 3
	replace C1 = -1 if C1 < 3
	replace C2 = -1 if C2 < 3
	replace D1 = -1 if D1 < 3
	replace D2 = -1 if D2 < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace NULL = -1 if NULL < 3
	mkmat A B C1 C2 D1 D2 E F NULL, matrix(mask)
	mkmat _`i', matrix(marriage)
	putexcel set 2018_county_mask_`i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2018_county_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(mask)
	putexcel save
	import excel 2018_county_`i'.xlsx, sheet(家戶組成) firstrow clear
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace G = -1 if G < 3
	replace H = -1 if H < 3
	replace I = -1 if I < 3
	replace J = -1 if J < 3
	mkmat B C D E F G H I J, matrix(mask)
	mkmat A, matrix(household_type)
	putexcel set 2018_county_mask_`i'.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2018_county_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(mask)
	putexcel save
	import excel 2018_county_`i'.xlsx, sheet(年齡組別) firstrow clear
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace G = -1 if G < 3
	replace H = -1 if H < 3
	replace I = -1 if I < 3
	replace J = -1 if J < 3
	mkmat B C D E F G H I J, matrix(mask)
	mkmat A, matrix(age_group2)
	putexcel set 2018_county_mask_`i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2018_county_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(mask)
	putexcel save

}

set trace off
*==============================
*--2019 county層級  遮

gen addr_city_cd_str= addr_city_cd
tostring addr_city_cd_str, replace
gen addr_county_cd_5 = substr(addr_city_cd_str, 1, 5)
gen addr_county_cd_num= addr_county_cd_5
destring addr_county_cd_num, replace


set trace on

levelsof addr_county_cd_num, local(levels)
foreach i of local levels {
	import excel 2019_county_`i'.xlsx, sheet(教育) firstrow clear
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace G = -1 if G < 3
	replace H = -1 if H < 3
	replace I = -1 if I < 3
	replace J = -1 if J < 3
	mkmat B C D E F G H I J, matrix(mask)
	mkmat A, matrix(education_cd)
	putexcel set 2019_county_mask_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2019_county_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(mask)
	putexcel save
	import excel 2019_county_`i'.xlsx, sheet(婚姻) firstrow clear
	replace A = -1 if A < 3
	replace B = -1 if B < 3
	replace C1 = -1 if C1 < 3
	replace C2 = -1 if C2 < 3
	replace D1 = -1 if D1 < 3
	replace D2 = -1 if D2 < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace NULL = -1 if NULL < 3
	mkmat A B C1 C2 D1 D2 E F NULL, matrix(mask)
	mkmat _`i', matrix(marriage)
	putexcel set 2019_county_mask_`i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2019_county_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(mask)
	putexcel save
	import excel 2019_county_`i'.xlsx, sheet(家戶組成) firstrow clear
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace G = -1 if G < 3
	replace H = -1 if H < 3
	replace I = -1 if I < 3
	replace J = -1 if J < 3
	mkmat B C D E F G H I J, matrix(mask)
	mkmat A, matrix(household_type)
	putexcel set 2019_county_mask_`i'.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2019_county_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(mask)
	putexcel save
	import excel 2019_county_`i'.xlsx, sheet(年齡組別) firstrow clear
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace G = -1 if G < 3
	replace H = -1 if H < 3
	replace I = -1 if I < 3
	replace J = -1 if J < 3
	mkmat B C D E F G H I J, matrix(mask)
	mkmat A, matrix(age_group2)
	putexcel set 2019_county_mask_`i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2019_county_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(mask)
	putexcel save

}

set trace off
*==============================

*2019 town層級 遮罩
set trace on

levelsof addr_city_cd, local(levels)
foreach i of local levels {
	import excel 2019_town_`i'.xlsx, sheet(教育) firstrow clear
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace G = -1 if G < 3
	replace H = -1 if H < 3
	replace I = -1 if I < 3
	replace J = -1 if J < 3
	mkmat B C D E F G H I J, matrix(mask)
	mkmat A, matrix(education_cd)
	putexcel set 2019_town_mask_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2019_town_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(mask)
	putexcel save
	import excel 2019_town_`i'.xlsx, sheet(婚姻) firstrow clear
	replace A = -1 if A < 3
	replace B = -1 if B < 3
	replace C1 = -1 if C1 < 3
	replace C2 = -1 if C2 < 3
	replace D1 = -1 if D1 < 3
	replace D2 = -1 if D2 < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace NULL = -1 if NULL < 3
	mkmat A B C1 C2 D1 D2 E F NULL, matrix(mask)
	mkmat _`i', matrix(marriage)
	putexcel set 2019_town_mask_`i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2019_town_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(mask)
	putexcel save
	import excel 2019_town_`i'.xlsx, sheet(家戶組成) firstrow clear
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace G = -1 if G < 3
	replace H = -1 if H < 3
	replace I = -1 if I < 3
	replace J = -1 if J < 3
	mkmat B C D E F G H I J, matrix(mask)
	mkmat A, matrix(household_type)
	putexcel set 2019_town_mask_`i'.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2019_town_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(mask)
	putexcel save
	import excel 2019_town_`i'.xlsx, sheet(年齡組別) firstrow clear
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace G = -1 if G < 3
	replace H = -1 if H < 3
	replace I = -1 if I < 3
	replace J = -1 if J < 3
	mkmat B C D E F G H I J, matrix(mask)
	mkmat A, matrix(age_group2)
	putexcel set 2019_town_mask_`i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2019_town_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(mask)
	putexcel save

}

set trace off
