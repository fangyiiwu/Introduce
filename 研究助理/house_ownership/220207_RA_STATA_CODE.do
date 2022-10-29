* Edited: 02/07/2022 RA
* Task: producing data
* Export file: D:\ntpu\ntpu_pf\code\0207_RA.do

* Data Using
use "D:\ntpu\ntpu_pf\data\modified\2020全台_edited&grouping.dta" 

*==============================================================================================================	

*-
*檢視缺漏_創造變數
egen miss_having_house_type_cd =rmiss(having_house_type_cd)
egen miss_education_cd =rmiss(education_cd)
egen miss_age =rmiss(age)
egen miss_marriage_cd =rmiss(marriage_cd)
egen miss_household_type_cd =rmiss(household_type_cd)
egen miss_register_reason_group_cd =rmiss(register_reason_group_cd)

*==============================================================================================================	

*檢視缺漏個數
tab miss_having_house_type_cd
tab miss_age
tab miss_education_cd
tab miss_marriage_cd
tab miss_household_type_cd
tab miss_register_reason_group_cd

*==============================================================================================================	

*檢視分組每組個數
tab education if age >= 24
tab marriage if age >= 18
tab household_type if age >= 18
tab age_group2 

*==============================================================================================================	

*【中低收入戶】
*檢視缺漏個數
egen miss_low_type_cd =rmiss( low_type_cd )
tab miss_low_type_cd

*創新變數，使low_type_cd2包含所有人
gen low_type_cd_num = 0 if low_type_cd == "0"
replace low_type_cd_num = 1 if low_type_cd == "1"
replace low_type_cd_num = 2 if low_type_cd == "2" 
replace low_type_cd_num = 3 if low_type_cd == "3" 
replace low_type_cd_num = 4 if low_type_cd == "4" 
replace low_type_cd_num = 5 if low_type_cd == "M"
replace low_type_cd_num = 6 if low_type_cd_num == .

*==============================================================================================================	

*2020 中低收入戶_全台
tab low_type_cd_num having_house_type_cd, matcell(A) matrow(low_type_cd_num)
putexcel set 2020_tw.xlsx, sheet(弱勢) replace
putexcel save
putexcel A1=("2020") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(low_type_cd_num) B2=matrix(A)
putexcel save

*==============================================================================================================	

*2020 中低收入戶_county

set trace on

levelsof coun_cd, local(levels)
foreach i of local levels {
	tab low_type_cd_num having_house_type_cd if coun_cd == `i', matcell(A) matrow(low_type_cd_num)
	putexcel set 2020_county_`i'.xlsx, sheet(弱勢) replace
	putexcel save
	putexcel A1=("2020`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(low_type_cd_num) B2=matrix(A)
	putexcel save
	
}

set trace off

*==============================================================================================================	

*2019 中低收入戶_全台
tab low_type_cd_num having_house_type_cd, matcell(A) matrow(low_type_cd_num)
putexcel set 2019_tw.xlsx, sheet(弱勢) replace
putexcel save
putexcel A1=("2019") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(low_type_cd_num) B2=matrix(A)
putexcel save

*==============================================================================================================	

*2019 中低收入戶_county

set trace on

levelsof coun_cd, local(levels)
foreach i of local levels {
	tab low_type_cd_num having_house_type_cd if coun_cd == `i', matcell(A) matrow(low_type_cd_num)
	putexcel set 2019_county_`i'.xlsx, sheet(弱勢) replace
	putexcel save
	putexcel A1=("2019`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(low_type_cd_num) B2=matrix(A)
	putexcel save
	
}

set trace off

*==============================================================================================================	

*2018 中低收入戶_全台
tab low_type_cd_num having_house_type_cd, matcell(A) matrow(low_type_cd_num)
putexcel set 2018_tw.xlsx, sheet(弱勢) replace
putexcel save
putexcel A1=("2018") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
putexcel A2=matrix(low_type_cd_num) B2=matrix(A)
putexcel save

*==============================================================================================================	

*2018 中低收入戶_county

set trace on

levelsof coun_cd, local(levels)
foreach i of local levels {
	tab low_type_cd_num having_house_type_cd if coun_cd == `i', matcell(A) matrow(low_type_cd_num)
	putexcel set 2018_county_`i'.xlsx, sheet(弱勢) replace
	putexcel save
	putexcel A1=("2018`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(low_type_cd_num) B2=matrix(A)
	putexcel save
	
}

set trace off

*==============================================================================================================	

*2020 中低收入戶_county 遮罩

gen addr_city_cd_str= addr_city_cd
tostring addr_city_cd_str, replace
gen addr_county_cd_5 = substr(addr_city_cd_str, 1, 5)
gen addr_county_cd_num= addr_county_cd_5
destring addr_county_cd_num, replace

set trace on

levelsof addr_county_cd_num, local(levels)
foreach i of local levels {
	import excel 2020_county_`i'.xlsx, sheet(弱勢) firstrow clear
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
	mkmat A, matrix(low_type_cd_num)
	putexcel set 2020_county_mask_`i'.xlsx, sheet(弱勢) replace
	putexcel save
	putexcel A1=("2020_county_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(low_type_cd_num) B2=matrix(mask)
	putexcel save

}

set trace off

*==============================================================================================================	

*2019 中低收入戶_county 遮罩

gen addr_city_cd_str= addr_city_cd
tostring addr_city_cd_str, replace
gen addr_county_cd_5 = substr(addr_city_cd_str, 1, 5)
gen addr_county_cd_num= addr_county_cd_5
destring addr_county_cd_num, replace

set trace on

levelsof addr_county_cd_num, local(levels)
foreach i of local levels {
	import excel 2019_county_`i'.xlsx, sheet(弱勢) firstrow clear
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
	mkmat A, matrix(low_type_cd_num)
	putexcel set 2019_county_mask_`i'.xlsx, sheet(弱勢) replace
	putexcel save
	putexcel A1=("2019_county_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(low_type_cd_num) B2=matrix(mask)
	putexcel save

}

set trace off

*==============================================================================================================	

*2018 中低收入戶_county 遮罩

gen addr_city_cd_str= addr_city_cd
tostring addr_city_cd_str, replace
gen addr_county_cd_5 = substr(addr_city_cd_str, 1, 5)
gen addr_county_cd_num= addr_county_cd_5
destring addr_county_cd_num, replace

set trace on

levelsof addr_county_cd_num, local(levels)
foreach i of local levels {
	import excel 2018_county_`i'.xlsx, sheet(弱勢) firstrow clear
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
	mkmat A, matrix(low_type_cd_num)
	putexcel set 2018_county_mask_`i'.xlsx, sheet(弱勢) replace
	putexcel save
	putexcel A1=("2018_county_mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(low_type_cd_num) B2=matrix(mask)
	putexcel save

}

set trace off