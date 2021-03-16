*COVID-19 Global Monthly Averages

use "~/Dropbox/JDS_Data/Global Daily COVID-19 Data/Masterfiles/Global COVID-19 Data.dta"
gen month_num = month
order month_num, after(month)

*NOTE: replace month value for 2021 (Jan 2021=month 13, Feb 2021=month14, March 2021=month 15, etc.)
replace month_num = 13 if day > 366 & day <= 397
replace month_num = 14 if day > 397 & day <= 425
replace month_num = 15 if day > 425 

*clean/format data for collapse
drop tu
tostring iso3-Coordinates, replace

order month_num, after(iso3) 

*generate averages-- NOTE that if new variables are added you may need to adjust specification of variables to collapse (mean)
collapse (firstnm) iso2-Coordinates (mean) pop2018-ox_ct, by(iso3 month_num)

destring month_num, replace
sort iso3 month_num

drop month 

save "~/Dropbox/JDS_Data/Global Monthly Avg COVID-19/Outputs/Monthly Global COVID-19 Data_$S_DATE.dta", replace

