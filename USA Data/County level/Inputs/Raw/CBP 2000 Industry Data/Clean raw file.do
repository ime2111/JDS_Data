*Clean CBP 2000 Industry Data
import delimited "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Fixed Data/CBP 2000 Industry Data/CBP Industry 2000 raw.csv"
sort naics
keep if naics == "72----" "56----" "11----" "71----" "23----" "61----" "52----" "62----" "99----" "51----" "55----" "31----" "21----" "81----" "54----" "53----" "44----" "48----" "22----" "42----" "------"
help keep if
keep if naics == "72----" |naics == "56----" | naics == "11----" | naics == "71----" | naics == "23----" | naics == "61----" | naics == "52----" |naics ==  "62----" |naics == "99----"|naics == "51----" |naics == "55----"| naics == "31----"|naics == "21----" |naics == "81----" |naics == "54----" |naics == "53----" |naics == "44----"| naics == "48----"|naics == "22----" |naics == "42----"|naics ==  "------"
drop qp1 n1_4-n1000_4
rename ïfipstate statefips
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Fixed Data/CBP 2000 Industry Data/CBP Industry data 2000 clean.dta"
gen str2 stateFIPS2 = string(statefips,"%02.0f")
gen str3 ctyFIPS2 = string(fipscty,"%03.0f")
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Fixed Data/CBP 2000 Industry Data/CBP Industry data 2000 clean.dta", replace
gen FIPS = stateFIPS2 + ctyFIPS2
order FIPS, first
sort FIPS
drop statefips fipscty censtate cencty stateFIPS2 ctyFIPS2
drop empflag
gen industry = 0
order industry, after(naics)
replace industry = 1 if naics == "72----"
replace industry = 2 if naics == "56----"
replace industry = 3 if naics == "11----"
replace industry = 3 if naics == "71----"
replace industry = 4 if naics == "71----"
replace industry = 5 if naics == "23----"
replace industry = 6 if naics == "61----"
replace industry = 7 if naics == "52----"
replace industry = 8 if naics == "62----"
replace industry = 9 if naics == "99----"
replace industry = 10 if naics == "51----"
replace industry = 11 if naics == "55----"
replace industry = 12 if naics == "31----"
replace industry = 13 if naics == "21----"
replace industry = 14 if naics == "81----"
replace industry = 15 if naics == "54----"
replace industry = 16 if naics == "53----"
replace industry = 17 if naics == "44----"
replace industry = 18 if naics == "48----"
replace industry = 19 if naics == "22----"
replace industry = 20 if naics == "42----"
rename cbp_2000_num_emp cbp2000_num_emp
rename ap cbp2000_pay_annual
rename est cbp2000_num_est
tostring industry, replace
replace industry = "total" if naics == "------"
drop naics
reshape wide cbp2000_num_emp cbp2000_pay_annual cbp2000_num_est, i(FIPS) j(industry) string
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Fixed Data/CBP 2000 Industry Data/CBP Industry data 2000 clean wide.dta"
