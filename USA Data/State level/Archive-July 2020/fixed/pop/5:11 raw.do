use "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/masterfiles/05112020.dta"
use "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/covid/covid cases deaths 05112020.dta"
merge 1:1 FIPS using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/state id template.dta"
merge 1:m FIPS using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/state id template.dta"
merge m:1 FIPS using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/state id template.dta"
destring FIPS, replace
merge m:1 FIPS using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/state id template.dta"
sort _merge
clear
use "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/state id template.dta"
insobs 1, after(8)
replace state = "District of Columbia" in 9
replace id = "DC" in 9
replace FIPS = 11 in 9
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/state id template.dta", replace
use "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/covid/covid cases deaths 05112020.dta"
merge m:1 FIPS using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/state id template.dta"
destring FIPS, replace
merge m:1 FIPS using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/state id template.dta"
drop in 3810
drop _merge
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/covid/covid cases deaths 05112020.dta", replace
order id, after(state)
order id, before(state)
sort date
merge m:m FIPS date using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/rt/rt05112020.dta"
merge m:m FIPS date using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/rt/rt05112020.dta", generate(_merge_rt)
sort _merge_rt
drop if state == "Puerto Rico"
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/masterfiles/05112020.dta", replace
sort state
clear
format pop2019 %12.0g
drop in 52/57
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/fixed/pop/state pop 2019.dta"
rename fips FIPS
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/fixed/pop/state pop 2019.dta", replace
use "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/masterfiles/05112020.dta"
merge 1:m FIPS using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/fixed/pop/state pop 2019.dta", generate(_merge_pop)
merge m:1 FIPS using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/fixed/pop/state pop 2019.dta", generate(_merge_pop)
drop in 3592/3750
order date, after(FIPS)
order pop2019, after(FIPS)
order FIPS, first
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/masterfiles/05112020.dta", replace
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/masterfiles/05112020.dta", replace
sort date
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/masterfiles/05112020.dta", replace
