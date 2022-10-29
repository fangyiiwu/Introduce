set trace on
local count = 0

forval i = 63000010(10)63000120 {
	tab age_group having_house_type_cd if addr_city_cd ==`i' & 	
	age >= 24, matcell(A) matrow(age_group)
	di count = `count'+1
	putexcel set `i'.xlsx, sheet(年齡組別) modify
	putexcel save
	putexcel A1=("2020"`i') B1=("A") C1=("B") D1=("C1") E1=("C2") F1=("D1")
 	G1=("D2") H1=("E") I1=("F") J1=("NULL")
	putexcel A2=matrix(age_group) B2=matrix(A)
		matrix list A
	matrix 1 = [1\0\0\0\0\0\0\0\0]
	matrix list 1
	matrix A = having_household_type*1
	matrix 2 = [0\1\0\0\0\0\0\0\0]
	matrix list 2
	matrix B = having_household_type*2
	matrix 3 = [0\0\1\0\0\0\0\0\0]
	matrix list 3
	matrix C1 = having_household_type*3
	matrix 4 = [0\0\0\1\0\0\0\0\0]
	matrix list 4
	matrix C2 = having_household_type*4
	matrix 5 = [0\0\0\0\1\0\0\0\0]
	matrix list 5
	matrix D1 = having_household_type*5
	matrix 6 = [0\0\0\0\0\1\0\0\0]
	matrix list 6
	matrix D2 = having_household_type*6
	matrix 7 = [0\0\0\0\0\0\1\0\0]
	matrix list 7
	matrix E = having_household_type*7
	matrix 8 = [0\0\0\0\0\0\0\1\0]
	matrix list 8
	matrix F = having_household_type*8
	matrix 9 = [0\0\0\0\0\0\0\0\1]
	matrix list 9
	matrix NULL = having_household_type*9
	matrix C1+D1 = C1 + D1
	matrix C2+D2 = C2 + D2
	matrix E+F = E + F
	matrix Total = A + C1+D1 + C2+D2 + E+F
	matrix colnames A = A
	matrix list A
	matrix colnames B = B
	matrix list B
	matrix colnames C1 = C1
	matrix list C1
	matrix colnames C2 = C2
	matrix list C2
	matrix colnames D1 = D1
	matrix list D1
	matrix colnames D2 = D2
	matrix list D2
	matrix colnames E = E
	matrix list E
	matrix colnames F = F
	matrix list F
	matrix colnames NULL = NULL
	matrix list NULL
	matrix colnames C1+D1 = C1+D1
	matrix list C1+D1
	matrix colnames C2+D2 = C2+D2
	matrix list C2+D2
	matrix colnames E+F = E+F
	matrix list E+F
	matrix colnames Total = Total
	matrix list Total
	matrix coljoinbyname ALL C1+D1 C2+D2 E+F Total B NULL
	matrix list ALL
	putexcel save
}

set trace off