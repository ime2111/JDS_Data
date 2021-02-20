*download data from: https://rt.live/	
*prepping rt data for merge
import delimited "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/timeseries/rt/rt.csv"

drop lower_80 upper_80
rename region id
gen date2 = date(date, "YMD")- date("12/31/2019", "MDY")
drop date
rename date2 date
order date, after(id)
rename mean rt_mean_
rename median rt_median_
rename new_cases rt_new_cases_
rename new_deaths rt_new_deaths
destring date, replace
*reshape
reshape wide index rt_mean_ rt_median_ infections test_adjusted_positive test_adjusted_positive_raw positive tests new_tests rt_new_cases_ rt_new_deaths, i(id) j(date)
*save file

*merge 1:1 with masterfile data on id
use "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/masterfiles/state.dta"
merge 1:1 id using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/timeseries/rt/rt.dta", nogenerate update replace
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/masterfiles/state.dta", replace

*drop entries with no data if needed
drop if date == ""
*reorder if needed
order state id, first

