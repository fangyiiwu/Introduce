* Edited: 11/25/2021 RA
* TASK: Export education, age and marriage status table
* export:2018~2020全台、六都、各縣市 education, age and marriage status table，按年度&區域儲存，共69個記事本
* =====================================================================================================================

*【2020 全國】

* Source Data Path
global source "D:\ntpu\ntpu_pf\data\raw\export_from_vertica"

* Export Data Path
global m_datapath "D:\ntpu\ntpu_pf\data\modified"

*保留製表所需變數
import delimited "$source\2020全台.csv"
keep education_cd marriage_cd having_house_type_cd age household_type_cd house_unitprice_noparking_city addr_city_cd
save "$m_datapath\2020全台_edited.dta"

*【分組】

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

*分類所需變數
save "$m_datapath\2020全台_edited&grouping.dta"

*【製表】

*教育製表*
tab education having_house_type_cd if age >= 24

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18

*年齡組別製表*
tab age_group having_house_type_cd

* =====================================================================================================================

*【2020 台北市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 63000000 <= addr_city_cd & addr_city_cd <= 63999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 63000000 <= addr_city_cd & addr_city_cd <= 63999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 63000000 <= addr_city_cd & addr_city_cd <= 63999999

*年齡組別製表*
tab age_group having_house_type_cd if 63000000 <= addr_city_cd & addr_city_cd <= 63999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 新北市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 65000000 <= addr_city_cd & addr_city_cd <= 65999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 65000000 <= addr_city_cd & addr_city_cd <= 65999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 65000000 <= addr_city_cd & addr_city_cd <= 65999999

*年齡組別製表*
tab age_group having_house_type_cd if 65000000 <= addr_city_cd & addr_city_cd <= 65999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 高雄市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 64000000 <= addr_city_cd & addr_city_cd <= 64999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 64000000 <= addr_city_cd & addr_city_cd <= 64999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 64000000 <= addr_city_cd & addr_city_cd <= 64999999

*年齡組別製表*
tab age_group having_house_type_cd if 64000000 <= addr_city_cd & addr_city_cd <= 64999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 台中市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 66000000 <= addr_city_cd & addr_city_cd <= 66999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 66000000 <= addr_city_cd & addr_city_cd <= 66999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 66000000 <= addr_city_cd & addr_city_cd <= 66999999

*年齡組別製表*
tab age_group having_house_type_cd if 66000000 <= addr_city_cd & addr_city_cd <= 66999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 台南市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 67000000 <= addr_city_cd & addr_city_cd <= 67999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 67000000 <= addr_city_cd & addr_city_cd <= 67999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 67000000 <= addr_city_cd & addr_city_cd <= 67999999

*年齡組別製表*
tab age_group having_house_type_cd if 67000000 <= addr_city_cd & addr_city_cd <= 67999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 桃園市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 68000000 <= addr_city_cd & addr_city_cd <= 68999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 68000000 <= addr_city_cd & addr_city_cd <= 68999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 68000000 <= addr_city_cd & addr_city_cd <= 68999999

*年齡組別製表*
tab age_group having_house_type_cd if 68000000 <= addr_city_cd & addr_city_cd <= 68999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 宜蘭縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10002000 <= addr_city_cd & addr_city_cd <= 10002999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10002000 <= addr_city_cd & addr_city_cd <= 10002999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10002000 <= addr_city_cd & addr_city_cd <= 10002999

*年齡組別製表*
tab age_group having_house_type_cd if 10002000 <= addr_city_cd & addr_city_cd <= 10002999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 新竹縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10004000 <= addr_city_cd & addr_city_cd <= 10004999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10004000 <= addr_city_cd & addr_city_cd <= 10004999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10004000 <= addr_city_cd & addr_city_cd <= 10004999

*年齡組別製表*
tab age_group having_house_type_cd if 10004000 <= addr_city_cd & addr_city_cd <= 10004999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 苗栗縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10005000 <= addr_city_cd & addr_city_cd <= 10005999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10005000 <= addr_city_cd & addr_city_cd <= 10005999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10005000 <= addr_city_cd & addr_city_cd <= 10005999

*年齡組別製表*
tab age_group having_house_type_cd if 10005000 <= addr_city_cd & addr_city_cd <= 10005999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 彰化縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10007000 <= addr_city_cd & addr_city_cd <= 10007999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10007000 <= addr_city_cd & addr_city_cd <= 10007999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10007000 <= addr_city_cd & addr_city_cd <= 10007999

*年齡組別製表*
tab age_group having_house_type_cd if 10007000 <= addr_city_cd & addr_city_cd <= 10007999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 南投縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10008000 <= addr_city_cd & addr_city_cd <= 10008999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10008000 <= addr_city_cd & addr_city_cd <= 10008999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10008000 <= addr_city_cd & addr_city_cd <= 10008999

*年齡組別製表*
tab age_group having_house_type_cd if 10008000 <= addr_city_cd & addr_city_cd <= 10008999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 雲林縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10009000 <= addr_city_cd & addr_city_cd <= 10009999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10009000 <= addr_city_cd & addr_city_cd <= 10009999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10009000 <= addr_city_cd & addr_city_cd <= 10009999

*年齡組別製表*
tab age_group having_house_type_cd if 10009000 <= addr_city_cd & addr_city_cd <= 10009999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 嘉義縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10010000 <= addr_city_cd & addr_city_cd <= 10010999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10010000 <= addr_city_cd & addr_city_cd <= 10010999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10010000 <= addr_city_cd & addr_city_cd <= 10010999

*年齡組別製表*
tab age_group having_house_type_cd if 10010000 <= addr_city_cd & addr_city_cd <= 10010999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 屏東縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10013000 <= addr_city_cd & addr_city_cd <= 10013999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10013000 <= addr_city_cd & addr_city_cd <= 10013999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10013000 <= addr_city_cd & addr_city_cd <= 10013999

*年齡組別製表*
tab age_group having_house_type_cd if 10013000 <= addr_city_cd & addr_city_cd <= 10013999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 台東縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10014000 <= addr_city_cd & addr_city_cd <= 10014999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10014000 <= addr_city_cd & addr_city_cd <= 10014999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10014000 <= addr_city_cd & addr_city_cd <= 10014999

*年齡組別製表*
tab age_group having_house_type_cd if 10014000 <= addr_city_cd & addr_city_cd <= 10014999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 花蓮縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10015000 <= addr_city_cd & addr_city_cd <= 10015999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10015000 <= addr_city_cd & addr_city_cd <= 10015999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10015000 <= addr_city_cd & addr_city_cd <= 10015999

*年齡組別製表*
tab age_group having_house_type_cd if 10015000 <= addr_city_cd & addr_city_cd <= 10015999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 澎湖縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10016000 <= addr_city_cd & addr_city_cd <= 10016999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10016000 <= addr_city_cd & addr_city_cd <= 10016999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10016000 <= addr_city_cd & addr_city_cd <= 10016999

*年齡組別製表*
tab age_group having_house_type_cd if 10016000 <= addr_city_cd & addr_city_cd <= 10016999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 基隆市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10017000 <= addr_city_cd & addr_city_cd <= 10017999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10017000 <= addr_city_cd & addr_city_cd <= 10017999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10017000 <= addr_city_cd & addr_city_cd <= 10017999

*年齡組別製表*
tab age_group having_house_type_cd if 10017000 <= addr_city_cd & addr_city_cd <= 10017999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 新竹市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10018000 <= addr_city_cd & addr_city_cd <= 10018999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10018000 <= addr_city_cd & addr_city_cd <= 10018999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10018000 <= addr_city_cd & addr_city_cd <= 10018999

*年齡組別製表*
tab age_group having_house_type_cd if 10018000 <= addr_city_cd & addr_city_cd <= 10018999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 嘉義市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10020000 <= addr_city_cd & addr_city_cd <= 10020999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10020000 <= addr_city_cd & addr_city_cd <= 10020999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10020000 <= addr_city_cd & addr_city_cd <= 10020999

*年齡組別製表*
tab age_group having_house_type_cd if 10020000 <= addr_city_cd & addr_city_cd <= 10020999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 連江縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 09007000 <= addr_city_cd & addr_city_cd <= 09007999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 09007000 <= addr_city_cd & addr_city_cd <= 09007999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 09007000 <= addr_city_cd & addr_city_cd <= 09007999

*年齡組別製表*
tab age_group having_house_type_cd if 09007000 <= addr_city_cd & addr_city_cd <= 09007999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2020 金門縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 09020000 <= addr_city_cd & addr_city_cd <= 09020999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 09020000 <= addr_city_cd & addr_city_cd <= 09020999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 09020000 <= addr_city_cd & addr_city_cd <= 09020999

*年齡組別製表*
tab age_group having_house_type_cd if 09020000 <= addr_city_cd & addr_city_cd <= 09020999

* =====================================================================================================================

*【2019 全國】

*保留製表所需變數
import delimited "$source\2019全台.csv"
keep education_cd marriage_cd having_house_type_cd age household_type_cd house_unitprice_noparking_city addr_city_cd
save "$m_datapath\2019全台_edited.dta"

*【分組】

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

*分類所需變數
save "$m_datapath\2019全台_edited&grouping.dta"

*【製表】

*教育製表*
tab education having_house_type_cd if age >= 24

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18

*年齡組別製表*
tab age_group having_house_type_cd

* =====================================================================================================================

*【2019 台北市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 63000000 <= addr_city_cd & addr_city_cd <= 63999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 63000000 <= addr_city_cd & addr_city_cd <= 63999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 63000000 <= addr_city_cd & addr_city_cd <= 63999999

*年齡組別製表*
tab age_group having_house_type_cd if 63000000 <= addr_city_cd & addr_city_cd <= 63999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 新北市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 65000000 <= addr_city_cd & addr_city_cd <= 65999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 65000000 <= addr_city_cd & addr_city_cd <= 65999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 65000000 <= addr_city_cd & addr_city_cd <= 65999999

*年齡組別製表*
tab age_group having_house_type_cd if 65000000 <= addr_city_cd & addr_city_cd <= 65999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 高雄市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 64000000 <= addr_city_cd & addr_city_cd <= 64999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 64000000 <= addr_city_cd & addr_city_cd <= 64999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 64000000 <= addr_city_cd & addr_city_cd <= 64999999

*年齡組別製表*
tab age_group having_house_type_cd if 64000000 <= addr_city_cd & addr_city_cd <= 64999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 台中市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 66000000 <= addr_city_cd & addr_city_cd <= 66999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 66000000 <= addr_city_cd & addr_city_cd <= 66999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 66000000 <= addr_city_cd & addr_city_cd <= 66999999

*年齡組別製表*
tab age_group having_house_type_cd if 66000000 <= addr_city_cd & addr_city_cd <= 66999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 台南市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 67000000 <= addr_city_cd & addr_city_cd <= 67999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 67000000 <= addr_city_cd & addr_city_cd <= 67999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 67000000 <= addr_city_cd & addr_city_cd <= 67999999

*年齡組別製表*
tab age_group having_house_type_cd if 67000000 <= addr_city_cd & addr_city_cd <= 67999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 桃園市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 68000000 <= addr_city_cd & addr_city_cd <= 68999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 68000000 <= addr_city_cd & addr_city_cd <= 68999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 68000000 <= addr_city_cd & addr_city_cd <= 68999999

*年齡組別製表*
tab age_group having_house_type_cd if 68000000 <= addr_city_cd & addr_city_cd <= 68999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 宜蘭縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10002000 <= addr_city_cd & addr_city_cd <= 10002999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10002000 <= addr_city_cd & addr_city_cd <= 10002999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10002000 <= addr_city_cd & addr_city_cd <= 10002999

*年齡組別製表*
tab age_group having_house_type_cd if 10002000 <= addr_city_cd & addr_city_cd <= 10002999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 新竹縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10004000 <= addr_city_cd & addr_city_cd <= 10004999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10004000 <= addr_city_cd & addr_city_cd <= 10004999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10004000 <= addr_city_cd & addr_city_cd <= 10004999

*年齡組別製表*
tab age_group having_house_type_cd if 10004000 <= addr_city_cd & addr_city_cd <= 10004999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 苗栗縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10005000 <= addr_city_cd & addr_city_cd <= 10005999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10005000 <= addr_city_cd & addr_city_cd <= 10005999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10005000 <= addr_city_cd & addr_city_cd <= 10005999

*年齡組別製表*
tab age_group having_house_type_cd if 10005000 <= addr_city_cd & addr_city_cd <= 10005999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 彰化縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10007000 <= addr_city_cd & addr_city_cd <= 10007999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10007000 <= addr_city_cd & addr_city_cd <= 10007999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10007000 <= addr_city_cd & addr_city_cd <= 10007999

*年齡組別製表*
tab age_group having_house_type_cd if 10007000 <= addr_city_cd & addr_city_cd <= 10007999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 南投縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10008000 <= addr_city_cd & addr_city_cd <= 10008999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10008000 <= addr_city_cd & addr_city_cd <= 10008999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10008000 <= addr_city_cd & addr_city_cd <= 10008999

*年齡組別製表*
tab age_group having_house_type_cd if 10008000 <= addr_city_cd & addr_city_cd <= 10008999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 雲林縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10009000 <= addr_city_cd & addr_city_cd <= 10009999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10009000 <= addr_city_cd & addr_city_cd <= 10009999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10009000 <= addr_city_cd & addr_city_cd <= 10009999

*年齡組別製表*
tab age_group having_house_type_cd if 10009000 <= addr_city_cd & addr_city_cd <= 10009999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 嘉義縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10010000 <= addr_city_cd & addr_city_cd <= 10010999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10010000 <= addr_city_cd & addr_city_cd <= 10010999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10010000 <= addr_city_cd & addr_city_cd <= 10010999

*年齡組別製表*
tab age_group having_house_type_cd if 10010000 <= addr_city_cd & addr_city_cd <= 10010999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 屏東縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10013000 <= addr_city_cd & addr_city_cd <= 10013999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10013000 <= addr_city_cd & addr_city_cd <= 10013999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10013000 <= addr_city_cd & addr_city_cd <= 10013999

*年齡組別製表*
tab age_group having_house_type_cd if 10013000 <= addr_city_cd & addr_city_cd <= 10013999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 台東縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10014000 <= addr_city_cd & addr_city_cd <= 10014999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10014000 <= addr_city_cd & addr_city_cd <= 10014999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10014000 <= addr_city_cd & addr_city_cd <= 10014999

*年齡組別製表*
tab age_group having_house_type_cd if 10014000 <= addr_city_cd & addr_city_cd <= 10014999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 花蓮縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10015000 <= addr_city_cd & addr_city_cd <= 10015999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10015000 <= addr_city_cd & addr_city_cd <= 10015999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10015000 <= addr_city_cd & addr_city_cd <= 10015999

*年齡組別製表*
tab age_group having_house_type_cd if 10015000 <= addr_city_cd & addr_city_cd <= 10015999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 澎湖縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10016000 <= addr_city_cd & addr_city_cd <= 10016999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10016000 <= addr_city_cd & addr_city_cd <= 10016999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10016000 <= addr_city_cd & addr_city_cd <= 10016999

*年齡組別製表*
tab age_group having_house_type_cd if 10016000 <= addr_city_cd & addr_city_cd <= 10016999


* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 基隆市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10017000 <= addr_city_cd & addr_city_cd <= 10017999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10017000 <= addr_city_cd & addr_city_cd <= 10017999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10017000 <= addr_city_cd & addr_city_cd <= 10017999

*年齡組別製表*
tab age_group having_house_type_cd if 10017000 <= addr_city_cd & addr_city_cd <= 10017999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 新竹市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10018000 <= addr_city_cd & addr_city_cd <= 10018999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10018000 <= addr_city_cd & addr_city_cd <= 10018999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10018000 <= addr_city_cd & addr_city_cd <= 10018999

*年齡組別製表*
tab age_group having_house_type_cd if 10018000 <= addr_city_cd & addr_city_cd <= 10018999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 嘉義市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10020000 <= addr_city_cd & addr_city_cd <= 10020999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10020000 <= addr_city_cd & addr_city_cd <= 10020999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10020000 <= addr_city_cd & addr_city_cd <= 10020999

*年齡組別製表*
tab age_group having_house_type_cd if 10020000 <= addr_city_cd & addr_city_cd <= 10020999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 連江縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 09007000 <= addr_city_cd & addr_city_cd <= 09007999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 09007000 <= addr_city_cd & addr_city_cd <= 09007999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 09007000 <= addr_city_cd & addr_city_cd <= 09007999

*年齡組別製表*
tab age_group having_house_type_cd if 09007000 <= addr_city_cd & addr_city_cd <= 09007999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2019 金門縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 09020000 <= addr_city_cd & addr_city_cd <= 09020999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 09020000 <= addr_city_cd & addr_city_cd <= 09020999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 09020000 <= addr_city_cd & addr_city_cd <= 09020999

*年齡組別製表*
tab age_group having_house_type_cd if 09020000 <= addr_city_cd & addr_city_cd <= 09020999

* =====================================================================================================================

*【2018 全國】

*保留製表所需變數
import delimited "$source\2018全台.csv"
keep education_cd marriage_cd having_house_type_cd age household_type_cd house_unitprice_noparking_city addr_city_cd
save "$m_datapath\2018全台_edited.dta"

*【分組】

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

*分類所需變數
save "$m_datapath\2018全台_edited&grouping.dta"

*【製表】

*教育製表*
tab education having_house_type_cd if age >= 24

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18

*年齡組別製表*
tab age_group having_house_type_cd

* =====================================================================================================================

*【2018 台北市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 63000000 <= addr_city_cd & addr_city_cd <= 63999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 63000000 <= addr_city_cd & addr_city_cd <= 63999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 63000000 <= addr_city_cd & addr_city_cd <= 63999999

*年齡組別製表*
tab age_group having_house_type_cd if 63000000 <= addr_city_cd & addr_city_cd <= 63999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 新北市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 65000000 <= addr_city_cd & addr_city_cd <= 65999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 65000000 <= addr_city_cd & addr_city_cd <= 65999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 65000000 <= addr_city_cd & addr_city_cd <= 65999999

*年齡組別製表*
tab age_group having_house_type_cd if 65000000 <= addr_city_cd & addr_city_cd <= 65999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 高雄市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 64000000 <= addr_city_cd & addr_city_cd <= 64999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 64000000 <= addr_city_cd & addr_city_cd <= 64999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 64000000 <= addr_city_cd & addr_city_cd <= 64999999

*年齡組別製表*
tab age_group having_house_type_cd if 64000000 <= addr_city_cd & addr_city_cd <= 64999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 台中市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 66000000 <= addr_city_cd & addr_city_cd <= 66999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 66000000 <= addr_city_cd & addr_city_cd <= 66999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 66000000 <= addr_city_cd & addr_city_cd <= 66999999

*年齡組別製表*
tab age_group having_house_type_cd if 66000000 <= addr_city_cd & addr_city_cd <= 66999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 台南市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 67000000 <= addr_city_cd & addr_city_cd <= 67999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 67000000 <= addr_city_cd & addr_city_cd <= 67999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 67000000 <= addr_city_cd & addr_city_cd <= 67999999

*年齡組別製表*
tab age_group having_house_type_cd if 67000000 <= addr_city_cd & addr_city_cd <= 67999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 桃園市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 68000000 <= addr_city_cd & addr_city_cd <= 68999999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 68000000 <= addr_city_cd & addr_city_cd <= 68999999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 68000000 <= addr_city_cd & addr_city_cd <= 68999999

*年齡組別製表*
tab age_group having_house_type_cd if 68000000 <= addr_city_cd & addr_city_cd <= 68999999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 宜蘭縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10002000 <= addr_city_cd & addr_city_cd <= 10002999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10002000 <= addr_city_cd & addr_city_cd <= 10002999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10002000 <= addr_city_cd & addr_city_cd <= 10002999

*年齡組別製表*
tab age_group having_house_type_cd if 10002000 <= addr_city_cd & addr_city_cd <= 10002999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 新竹縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10004000 <= addr_city_cd & addr_city_cd <= 10004999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10004000 <= addr_city_cd & addr_city_cd <= 10004999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10004000 <= addr_city_cd & addr_city_cd <= 10004999

*年齡組別製表*
tab age_group having_house_type_cd if 10004000 <= addr_city_cd & addr_city_cd <= 10004999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 苗栗縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10005000 <= addr_city_cd & addr_city_cd <= 10005999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10005000 <= addr_city_cd & addr_city_cd <= 10005999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10005000 <= addr_city_cd & addr_city_cd <= 10005999

*年齡組別製表*
tab age_group having_house_type_cd if 10005000 <= addr_city_cd & addr_city_cd <= 10005999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 彰化縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10007000 <= addr_city_cd & addr_city_cd <= 10007999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10007000 <= addr_city_cd & addr_city_cd <= 10007999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10007000 <= addr_city_cd & addr_city_cd <= 10007999

*年齡組別製表*
tab age_group having_house_type_cd if 10007000 <= addr_city_cd & addr_city_cd <= 10007999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 南投縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10008000 <= addr_city_cd & addr_city_cd <= 10008999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10008000 <= addr_city_cd & addr_city_cd <= 10008999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10008000 <= addr_city_cd & addr_city_cd <= 10008999

*年齡組別製表*
tab age_group having_house_type_cd if 10008000 <= addr_city_cd & addr_city_cd <= 10008999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 雲林縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10009000 <= addr_city_cd & addr_city_cd <= 10009999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10009000 <= addr_city_cd & addr_city_cd <= 10009999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10009000 <= addr_city_cd & addr_city_cd <= 10009999

*年齡組別製表*
tab age_group having_house_type_cd if 10009000 <= addr_city_cd & addr_city_cd <= 10009999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 嘉義縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10010000 <= addr_city_cd & addr_city_cd <= 10010999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10010000 <= addr_city_cd & addr_city_cd <= 10010999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10010000 <= addr_city_cd & addr_city_cd <= 10010999

*年齡組別製表*
tab age_group having_house_type_cd if 10010000 <= addr_city_cd & addr_city_cd <= 10010999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 屏東縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10013000 <= addr_city_cd & addr_city_cd <= 10013999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10013000 <= addr_city_cd & addr_city_cd <= 10013999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10013000 <= addr_city_cd & addr_city_cd <= 10013999

*年齡組別製表*
tab age_group having_house_type_cd if 10013000 <= addr_city_cd & addr_city_cd <= 10013999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 台東縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10014000 <= addr_city_cd & addr_city_cd <= 10014999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10014000 <= addr_city_cd & addr_city_cd <= 10014999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10014000 <= addr_city_cd & addr_city_cd <= 10014999

*年齡組別製表*
tab age_group having_house_type_cd if 10014000 <= addr_city_cd & addr_city_cd <= 10014999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 花蓮縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10015000 <= addr_city_cd & addr_city_cd <= 10015999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10015000 <= addr_city_cd & addr_city_cd <= 10015999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10015000 <= addr_city_cd & addr_city_cd <= 10015999

*年齡組別製表*
tab age_group having_house_type_cd if 10015000 <= addr_city_cd & addr_city_cd <= 10015999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 澎湖縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10016000 <= addr_city_cd & addr_city_cd <= 10016999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10016000 <= addr_city_cd & addr_city_cd <= 10016999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10016000 <= addr_city_cd & addr_city_cd <= 10016999

*年齡組別製表*
tab age_group having_house_type_cd if 10016000 <= addr_city_cd & addr_city_cd <= 10016999


* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 基隆市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10017000 <= addr_city_cd & addr_city_cd <= 10017999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10017000 <= addr_city_cd & addr_city_cd <= 10017999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10017000 <= addr_city_cd & addr_city_cd <= 10017999

*年齡組別製表*
tab age_group having_house_type_cd if 10017000 <= addr_city_cd & addr_city_cd <= 10017999

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 新竹市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10018000 <= addr_city_cd & addr_city_cd <= 10018999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10018000 <= addr_city_cd & addr_city_cd <= 10018999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10018000 <= addr_city_cd & addr_city_cd <= 10018999

*年齡組別製表*
tab age_group having_house_type_cd if 10018000 <= addr_city_cd & addr_city_cd <= 10018999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 嘉義市】

*教育製表*
tab education having_house_type_cd if age >= 24 & 10020000 <= addr_city_cd & addr_city_cd <= 10020999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 10020000 <= addr_city_cd & addr_city_cd <= 10020999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 10020000 <= addr_city_cd & addr_city_cd <= 10020999

*年齡組別製表*
tab age_group having_house_type_cd if 10020000 <= addr_city_cd & addr_city_cd <= 10020999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 連江縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 09007000 <= addr_city_cd & addr_city_cd <= 09007999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 09007000 <= addr_city_cd & addr_city_cd <= 09007999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 09007000 <= addr_city_cd & addr_city_cd <= 09007999

*年齡組別製表*
tab age_group having_house_type_cd if 09007000 <= addr_city_cd & addr_city_cd <= 09007999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*【2018 金門縣】

*教育製表*
tab education having_house_type_cd if age >= 24 & 09020000 <= addr_city_cd & addr_city_cd <= 09020999

*婚姻狀況製表*
tab marriage_cd having_house_type_cd if age >= 18 & 09020000 <= addr_city_cd & addr_city_cd <= 09020999

*家戶組成製表*
tab household_type_cd having_house_type_cd if age >= 18 & 09020000 <= addr_city_cd & addr_city_cd <= 09020999

*年齡組別製表*
tab age_group having_house_type_cd if 09020000 <= addr_city_cd & addr_city_cd <= 09020999
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

save "$m_datapath\1125_edited.dta"



