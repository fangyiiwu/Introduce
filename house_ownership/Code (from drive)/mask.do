*loop
*法一:一次做完---2020 town為例
set trace on

levelsof addr_city_cd, local(levels)
foreach i of local levels {
	*和原來一樣，輸出未遮罩excel
	tab education having_house_type_cd if addr_city_cd == `i' & age >= 24, matcell(A) matrow(education_cd)
	putexcel set 2020_town_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2020`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(A)
	putexcel save
	*matrix轉成variable再轉回matrix:
	*svmat把matrix轉成variable後，在variable狀態做replace。
	svmat double A, name(c`i')
	replace c`i'1 = -1 if c`i'1 < 3
	replace c`i'2 = -1 if c`i'2 < 3
	replace c`i'3 = -1 if c`i'3 < 3
	replace c`i'4 = -1 if c`i'4 < 3
	replace c`i'5 = -1 if c`i'5 < 3
	replace c`i'6 = -1 if c`i'6 < 3
	replace c`i'7 = -1 if c`i'7 < 3
	replace c`i'8 = -1 if c`i'8 < 3
	replace c`i'9 = -1 if c`i'9 < 3
	*遮罩完再用mkmat轉回matrix，方便putexcel輸出
	mkmat c`i'1 c`i'2 c`i'3 c`i'4 c`i'5 c`i'6 c`i'7 c`i'8 c`i'9, matrix(mask)
	*輸出遮罩後excel
	putexcel set 2020_town_mask_`i'.xlsx, sheet(教育) replace
	putexcel save
	putexcel A1=("2020__mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(mask)
	putexcel save
}

set trace off

*===========================================================

*法二:匯出未遮罩後，再import來遮---2020 county為例
set trace on

levelsof addr_county_cd_num, local(levels)
foreach i of local levels {
	*讀取時讓第一行變variable label
	import excel 2020_county_`i'.xlsx,firstrow
	replace B = -1 if B < 3
	replace C = -1 if C < 3
	replace D = -1 if D < 3
	replace E = -1 if E < 3
	replace F = -1 if F < 3
	replace G = -1 if G < 3
	replace H = -1 if H < 3
	replace I = -1 if I < 3
	replace J = -1 if J < 3
	*遮罩完再用mkmat轉回matrix，方便putexcel輸出
	mkmat B C D E F G H I J, matrix(mask)
	mkmat A, matrix(education_cd)
	*輸出遮罩後excel
	putexcel set 2020_county_mask_`i'.xlsx, sheet(教育) replace
	putexcel A1=("2020__mask_`i'") B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1") G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(education_cd) B2=matrix(mask)
	putexcel save
}

set trace off