*做368鄉鎮市區的表
*範例: 台北市的年齡組成
*===============================
*1、forvalues方式
set trace on

forval i = 63000010(10)63000120 {
	tab age_group having_house_type_cd if addr_city_cd ==`i' & 	
	age >= 24, matcell(A) matrow(age_group)
	matrix list A
	putexcel set `i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2020"`i') B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1")
 	G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group) B2=matrix(A)
	putexcel save

}

set trace off

*===============================
*2、foreach方式，寫不出來@@

set trace on

foreach i of local(addr_city_cd) {
	tab age_group having_house_type_cd if `i' == 63000120 & age >= 24, matcell(A) matrow(		age_group)
	*上面那行應該就不行了
	matrix list A
	putexcel set 台北市北投區.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2020台北市北投區年齡組別") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group) B2=matrix(A)
	putexcel save

}

set trace off

*===============================
*新的tab

*教育製表*
tab education having_house_type_cd if age >= 24 & 63000000 <= addr_city_cd & addr_city_cd <= 63999999

*婚姻狀況製表*
tab marriage having_house_type_cd if age >= 18 & 63000000 <= addr_city_cd & addr_city_cd <= 63999999

*家戶組成製表*
tab household_type having_house_type_cd if age >= 18 & 63000000 <= addr_city_cd & addr_city_cd <= 63999999

*年齡組別製表*
tab age_group2 having_house_type_cd if 63000000 <= addr_city_cd & addr_city_cd <= 63999999











*===============================


*做22縣市的表
*先把addr_city_cd轉換成數字縣市，為縣市取名 分組，再用forvalue迴圈
*1=台北市、2=新北市、3=高雄市....

gen addr_name if  63000000 <= addr_city_cd & addr_city_cd <= 63999999
replace addr_name = 2 if 65000000 <= addr_city_cd & addr_city_cd <= 65999999
replace addr_name = 3 if 64000000 <= addr_city_cd & addr_city_cd <= 64999999
*以此類推......

