*Lancet Calculations 8/30
use "/Users/isminiethridge/Dropbox/IE_COVID-19/1. Global Data/Global Masterfiles/Github_complete.dta"
keep iso3 UN_Country day tdpm tt ncpm ntpt nt pos_rate ERR tpc
keep if day > 226
save "/Users/isminiethridge/Dropbox/IE_COVID-19/Lancet Covid-19 Data/2 wk avg Aug 30.dta", replace

*Clean data
sort country day
drop if country == ""
drop if day == .
sort iso3
by iso3: replace ERR = ERR[_n-1] if missing(ERR)

*Calculate 14 day avg
egen ncpm_avg = mean(ncpm), by(iso3)
egen ntpt_avg = mean(ntpt), by(iso3)
egen ERR_avg = mean(ERR), by(iso3)
egen pos_rate_avg = mean(positive_rate), by(iso3)

*NOT NECESSARY BUT EASIER TO READ
keep if day == 240

*Generate classifications
gen S = 0 
gen VL = 0
gen L = 0
gen M = 0
gen H = 0
gen VH = 0
gen Missing = 0

*Classify data
replace Missing = 1 if pos_rate_avg == . 
replace S = 1 if ncpm_avg  <= 5 & pos_rate_avg <= .01 & Missing != 1
replace VL = 1 if ncpm_avg > 5 & ncpm_avg  <= 10 & pos_rate_avg <= .01 & Missing != 1
replace L = 1 if ncpm_avg  <= 10 & pos_rate_avg <= .1 & pos_rate_avg >= .01 & Missing != 1
replace M = 1 if ncpm_avg  > 10 & ncpm_avg <= 50 & Missing != 1
replace M = 1 if ncpm_avg  < 10 & pos_rate_avg > .1 & Missing != 1
replace H = 1 if ncpm_avg  > 50 & ncpm_avg  <= 100 & Missing != 1
replace VH = 1 if ncpm_avg > 100 & Missing != 1

*Sort
sort Missing VH H M L VL S ncpm_avg ERR_avg tdpm

*View data
list country ERR_avg if S == 1 
list country ERR_avg if VL == 1 
list country ERR_avg if L == 1
list country ERR_avg if M == 1 
list country ERR_avg if H == 1
list country ERR_avg if VH == 1

save "/Users/isminiethridge/Dropbox/IE_COVID-19/Lancet Covid-19 Data/Aug 30 classified data.dta", replace

*Table 2

gen d_VL = 0
gen d_L = 0
gen d_M = 0
gen d_H = 0
gen d_VH = 0

replace d_VL = 1 if ndpm_avg <= 0.1 
replace d_L = 1 if ndpm_avg > 0.1 & ndpm_avg <= 0.5 
replace d_M = 1 if ndpm_avg > 0.5 & ndpm_avg <= 1.0 
replace d_H = 1 if ndpm_avg > 1.0 & ndpm_avg <= 5.0 
replace d_VH = 1 if ndpm_avg > 5.0 
sort d_VH d_H d_M d_L d_VL ndpm_avg tdpm
edit country d_VH d_H d_M d_L d_VL ndpm_avg tdpm
