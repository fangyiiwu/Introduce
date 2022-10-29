* Edited: 12/16/2021 RA
* Task: producing data、使用迴圈產生表格
* Export file: 	D:\ntpu\ntpu_pf\code\1216_RA.do、D:\ntpu\ntpu_pf\export\1216table\2020台北市各行政區教育,婚姻,家戶組成,年齡組成表格、2020全台各年齡層擁屋原因
* Data Using
use "D:\ntpu\ntpu_pf\data\modified\2020全台_edited&grouping.dta" 
use "D:\ntpu\ntpu_year_city\PSI\2020.csv" 



*Data Grouping

*婚姻分組
gen marriage =1 if marriage_cd == 1
replace marriage = 2 if marriage_cd == 2 | marriage_cd == 6
replace marriage = 3 if marriage_cd == 3 | marriage_cd == 5 | marriage_cd ==7
replace marriage = 4 if marriage_cd == 4 | marriage_cd == 8
*未婚=1、有偶=2、離婚=3、喪偶=4



*家戶組成分組
gen household_type = 1 if household_type_cd == 1
replace household_type = 2 if household_type_cd == 2  | household_type_cd == 721
replace household_type = 3 if household_type_cd == 3 | household_type_cd == 731
replace household_type = 4 if household_type_cd == 4  | household_type_cd == 741
replace household_type = 5 if household_type_cd == 5  | household_type_cd == 751 | household_type_cd == 752 | household_type_cd == 753 | household_type_cd == 754
replace household_type = 6 if household_type_cd == 6  | household_type_cd == 761 | household_type_cd == 762 | household_type_cd == 763 | household_type_cd == 764
replace household_type = 7 if household_type_cd == 7
*單人=1、夫婦=2、三代=3、祖孫=4、核心=5、單親=6、其他=7
/*Quote : 上述"其他"指無法看出其家庭結構屬於前六項之一，故單獨分類*/

*年齡分組
gen age_group2 = 1 if age_group == 1 | age_group == 2 | age_group == 3 | age_group == 4
replace age_group2 = 2 if age_group == 5
replace age_group2 = 3 if age_group == 6
replace age_group2 = 4 if age_group == 7
replace age_group2 = 5 if age_group == 8
replace age_group2 = 6 if age_group == 9
replace age_group2 = 7 if age_group == 10
replace age_group2 = 8 if age_group == 11
replace age_group2 = 9 if age_group == 12
replace age_group2 = 10 if age_group == 13
replace age_group2 = 11 if age_group == 14
replace age_group2 = 12 if age_group == 15
replace age_group2 = 13 if age_group == 16
replace age_group2 = 14 if age_group == 17
replace age_group2 = 15 if age_group == 18
replace age_group2 = 16 if age_group == 19 | age_group == 20 | age_group == 21

*==========================================================================================

*loop--forvalues方式

*台北市
*--婚姻、家戶組成、年齡組成 製表

set trace on

forvalues i = 63000010(10)63000120 {
	tab education having_house_type_cd if addr_city_cd == `i' & age >= 24, matcell(A) matrow(education_cd)
	putexcel set `i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2020`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	tab marriage having_house_type_cd if addr_city_cd == `i' & age >= 18, matcell(A) matrow(marriage)
	putexcel set `i'.xlsx, sheet(婚姻) modify
	putexcel save
	putexcel A1=("2020_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(marriage) B2=matrix(A)
	putexcel save
	tab household_type having_house_type_cd if addr_city_cd == `i' & age >= 18, matcell(A) matrow(household_type)
	putexcel set `i'.xlsx, sheet(家戶組成) modify
	putexcel save
	putexcel A1=("2020`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(household_type) B2=matrix(A)
	putexcel save
	tab age_group2 having_house_type_cd if addr_city_cd == `i', matcell(A) matrow(age_group2)
	putexcel set `i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2020`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group2) B2=matrix(A)
	putexcel save
}

set trace off

*loop grouping try
set trace on

forval i = 63000010(10)63000120 {
	tab education having_house_type_cd if addr_city_cd == `i' & age >= 24, matcell(having_house_type_cd) matrow(	education_cd)
	putexcel set `i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2020`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(having_house_type_cd)
	matrix list having_house_type_cd
	matrix a = [1\0\0\0\0\0\0\0\0]
	matrix list a
	matrix A = having_house_type_cd*a
	matrix list A
	matrix b = [0\1\0\0\0\0\0\0\0]
	matrix list b
	matrix B = having_house_type_cd*b
	matrix c = [0\0\1\0\0\0\0\0\0]
	matrix list c
	matrix C1 = having_house_type_cd*c
	matrix d = [0\0\0\1\0\0\0\0\0]
	matrix list d
	matrix C2 = having_house_type_cd*d
	matrix e = [0\0\0\0\1\0\0\0\0]
	matrix list e
	matrix D1 = having_house_type_cd*e
	matrix f = [0\0\0\0\0\1\0\0\0]
	matrix list f
	matrix D2 = having_house_type_cd*f
	matrix g = [0\0\0\0\0\0\1\0\0]
	matrix list g
	matrix E = having_house_type_cd*g
	matrix h = [0\0\0\0\0\0\0\1\0]
	matrix list h
	matrix F = having_house_type_cd*h
	matrix i = [0\0\0\0\0\0\0\0\1]
	matrix list i
	matrix NULL = having_house_type_cd*i
	matrix C1D1 = C1 + D1
	matrix C2D2 = C2 + D2
	matrix EF = E + F
	matrix total = A + C1D1 + C2D2 + EF
	matrix colnames A = A
	matrix colnames B = B
	matrix colnames C1 = C1
	matrix colnames C2 = C2
	matrix colnames D1 = D1
	matrix colnames D2 = D2
	matrix colnames E = E
	matrix colnames F = F
	matrix colnames NULL = NULL
	matrix colnames C1D1 = C1D1
	matrix colnames C2D2 = C2D2
	matrix colnames EF = EF
	matrix colnames total = total
	matrix coljoinbyname ALL = A C1D1 C2D2 EF total B NULL
	matrix list ALL
	putexcel save
}

set trace off

*=========================================================================================

*2020全台各年齡層擁屋原因
tab age_group_cd register_reason_group_cd, matcell(A) matrow(age_group_cd)
matrix list A
putexcel set 2020全台各年齡層擁屋.xlsx
putexcel save
putexcel A1=("2020全台各年齡擁屋") B1=("A") C1=("B") D1=("C") E1=("D") F1=("E") G1=("F") 
putexcel A2=matrix(age_group_cd) B2=matrix(A)
putexcel save

