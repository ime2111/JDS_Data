*Add covid data- state level
*copy raw data into excel file from https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv
*prepping covid cases deaths for merge

*import Excel as ALL STRING
import excel "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/timeseries/covid/covid.xlsx", sheet("Sheet1") firstrow allstring

gen date2 = date(date, "MDY")-date("12/31/2019", "MDY")
order date2, after(date)
drop date
rename date2 date
rename fips FIPS
rename cases c	
rename deaths d
reshape wide c d, i(FIPS) j(date)
drop state
destring *, replace
tostring FIPS, replace
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/timeseries/covid/covid.dta"

*merge1:1 with masterfile
use "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/masterfiles/state.dta"
merge 1:1 FIPS using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/timeseries/covid/covid.dta", nogenerate update replace
drop if state == ""
