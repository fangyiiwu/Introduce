* Task: 
* Last Modified:


* Specify File Path

global sourcedata "C:\data\....\"
global exportdata "path to the export data"

* Import file

import delimited using "$sourcedata\filename.csv"

* ==========================================
* Variable Creation 
* ==========================================

*教育表格變數分組*
gen education if education_cd   = 1
replace education = 1 if education_cd == 2
replace education = 1 if education_cd == 3
replace education = 1 if education_cd == 4
replace education = 2 if education_cd == 11
replace education = 2 if education_cd == 12
replace education = 2 if education_cd == 13
replace education = 2 if education_cd == 14
replace education = 3 if education_cd == 21
replace education = 3 if education_cd == 22
replace education = 4 if education_cd == 31
replace education = 4 if education_cd == 32
replace education = 4 if education_cd == 41
replace education = 4 if education_cd == 42
replace education = 4 if education_cd == 52
replace education = 4 if education_cd == 61
replace education = 4 if education_cd == 62
replace education = 4 if education_cd == 71
replace education = 4 if education_cd == 72
replace education = 5 if education_cd == 81
replace education = 5 if education_cd == 82
replace education = 5 if education_cd == 91
replace education = 5 if education_cd == 92
replace education = 6 if education_cd == 99

label define education, 1 = 'elementary'
label define education, 2 = 'post'
label define education, 3 = 'university'
label define education, 4 = 'high'
label define education, 5 = 'junior'
label define education, 6 = 'na'

*家戶組成分組*
gen child_combined = child_cnt_0_6 + child_cnt_7_14
gen child if marriage_cd = 1
replace child = 1 if marriage_cd == 3
replace child = 1 if marriage_cd == 4
replace child = 1 if marriage_cd == 5
replace child = 2 if marriage_cd == 2

*年齡組別分組*
gen age_group = 1 if age <= 4
replace age_group = 2 if 5 <= age & age <= 9
replace age_group = 3 if 10 <= age & age <= 14
replace age_group = 4 if 15 <= age & age <= 19
replace age_group = 5 if 20 <= age & age <= 24
replace age_group = 6 if 25 <= age & age <= 29
replace age_group = 7 if 30 <= age & age <= 34
replace age_group = 8 if 35 <= age & age <= 39
replace age_group = 9 if 40 <= age & age <= 44
replace age_group = 10 if 45 <= age & age <= 49
replace age_group = 11 if 50 <= age & age <= 54
replace age_group = 12 if 55 <= age & age <= 59
replace age_group = 13 if 60 <= age & age <= 64
replace age_group = 14 if 65 <= age & age <= 69
replace age_group = 15 if 70 <= age & age <= 74
replace age_group = 16 if 75 <= age & age <= 79
replace age_group = 17 if 80 <= age & age <= 84
replace age_group = 18 if 85 <= age & age <= 89
replace age_group = 19 if 90 <= age & age <= 94
replace age_group = 20 if 95 <= age & age <= 99
replace age_group = 21 if age >= 100

* Export processed data
save "$exportdata\newfile.dta", replace

* ==========================================
* Table Output 
* ==========================================
use ..... 

*教育製表*
tab education having_house_type_cd

*婚姻狀況製表*
tab marriage_cd having_house_type_cd

*家戶組成製表*
tab child having_house_type_cd

*年齡組別製表*
tab age_group having_house_type_cd