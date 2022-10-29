* Edited: 12/10/2021
* TASK: Matrix Using

*=======================================================================================

*先用 "tabulate" 建立表格，並分別用 "matcell" 與 "matrow" 儲存橫列與縱行變數名稱及資料
tab education having_household_type, matcell(having_household_type) matrow(education)

*列出矩陣形式
matrix list having_household_type

*做出 9 x 1 的矩陣並用 "having_household_type" 的矩陣(n x 9)乘以 "matrix 1" 以保留 "having_household_type" 的第一行變數之觀察值
matrix 1 = [1\0\0\0\0\0\0\0\0]
matrix list 1
matrix A = having_household_type*1

*做出 9 x 1 的矩陣並用 "having_household_type" 的矩陣(n x 9)乘以 "matrix 1" 以保留 "having_household_type" 的第二行變數之觀察值
matrix 2 = [0\1\0\0\0\0\0\0\0]
matrix list 2
matrix B = having_household_type*2

*做出 9 x 1 的矩陣並用 "having_household_type" 的矩陣(n x 9)乘以 "matrix 1" 以保留 "having_household_type" 的第三行變數之觀察值
matrix 3 = [0\0\1\0\0\0\0\0\0]
matrix list 3
matrix C1 = having_household_type*3

*做出 9 x 1 的矩陣並用 "having_household_type" 的矩陣(n x 9)乘以 "matrix 1" 以保留 "having_household_type" 的第四行變數之觀察值
matrix 4 = [0\0\0\1\0\0\0\0\0]
matrix list 4
matrix C2 = having_household_type*4

*做出 9 x 1 的矩陣並用 "having_household_type" 的矩陣(n x 9)乘以 "matrix 1" 以保留 "having_household_type" 的第五行變數之觀察值
matrix 5 = [0\0\0\0\1\0\0\0\0]
matrix list 5
matrix D1 = having_household_type*5

*做出 9 x 1 的矩陣並用 "having_household_type" 的矩陣(n x 9)乘以 "matrix 1" 以保留 "having_household_type" 的第六行變數之觀察值
matrix 6 = [0\0\0\0\0\1\0\0\0]
matrix list 6
matrix D2 = having_household_type*6

*做出 9 x 1 的矩陣並用 "having_household_type" 的矩陣(n x 9)乘以 "matrix 1" 以保留 "having_household_type" 的第七行變數之觀察值
matrix 7 = [0\0\0\0\0\0\1\0\0]
matrix list 7
matrix E = having_household_type*7

*做出 9 x 1 的矩陣並用 "having_household_type" 的矩陣(n x 9)乘以 "matrix 1" 以保留 "having_household_type" 的第八行變數之觀察值
matrix 8 = [0\0\0\0\0\0\0\1\0]
matrix list 8
matrix F = having_household_type*8

*做出 9 x 1 的矩陣並用 "having_household_type" 的矩陣(n x 9)乘以 "matrix 1" 以保留 "having_household_type" 的第九行變數之觀察值
matrix 9 = [0\0\0\0\0\0\0\0\1]
matrix list 9
matrix NULL = having_household_type*9

*合併不同行變數觀察值之數據
matrix C1+D1 = C1 + D1
matrix C2+D2 = C2 + D2
matrix E+F = E + F
matrix 整體擁屋 = A + C1+D1 + C2+D2 + E+F

*先改變各矩陣變數名稱以便接下來合併成最終表格
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
matrix colnames 同戶親屬 = "同戶親屬"
matrix list 同戶親屬
matrix colnames 非同戶親屬持有 = "非同戶親屬持有"
matrix list 非同戶親屬持有
matrix colnames 擁屋但住宅非本人或親屬持有 = "擁屋但住宅非本人或親屬持有"
matrix list 擁屋但住宅非本人或親屬持有
matrix colnames 整體擁屋 = "整體擁屋"
matrix list 整體擁屋

*合併成最終表格
matrix coljoinbyname 擁屋型態 = 同戶親屬 非同戶親屬持有 擁屋但住宅非本人或親屬持有 整體擁屋 B NULL
matrix list 擁屋型態