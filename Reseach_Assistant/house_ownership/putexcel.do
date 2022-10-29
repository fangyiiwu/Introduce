use "C:\Program Files (x86)\Stata SE 16\poe5stata\stockton5_small.dta"

*tab做出來+存成matrix
tab livarea pool, matcell(freq) matrow(names)
matrix list freq
matrix list names


*法一: 設檔名
putexcel set try.xlsx, sheet(example1) replace
putexcel save
*把tab結果放在excel
putexcel A1=("living area,hundreds of square feet") B1=("0") C1=("1") D1=("Total")
putexcel A2=matrix(names) B2=matrix(freq)
putexcel save


*法二: 設路徑+檔名
putexcel set "C:\Users\philip\Desktop\try.xlsx", sheet(example1) replace
putexcel save
*把tab結果放在excel
putexcel A1=("living area,hundreds of square feet") B1=("0") C1=("1") D1=("Total")
putexcel A2=matrix(names) B2=matrix(freq)

*========
*tab做出來+存成matrix
tab education havin_house_type_cd if age>=24 &addr_city_cd==6300010,
	matcell(edu_having) matrow(education)

*變excel
putexcel set "C:路徑\擁屋型態.xlsx", sheet(example1) replace
putexcel save
*把tab結果放在excel
putexcel A1=("") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") 
		 H1=("E") I1=("F") J1=("NULL") K1=("Total") 
putexcel A2=matrix(education) B2=matrix(edu_having)