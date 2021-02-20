*Download data from: https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv

**formatting FIPS code for new covid cases and deaths data

*cases
import delimited https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv
rename fips FIPS
gen str5 FIPS2 = string(FIPS,"%05.0f")
order FIPS2, after(FIPS)
drop FIPS
rename FIPS2 FIPS
*delete missing values
drop if FIPS == "."
*changing variable name to prefix-date format
rename v# c#
drop if iso3 != "USA"
drop uid-code3
drop admin2-combined_key
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Timeseries/new cases/cases.dta", replace
clear

*deaths
import delimited https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv
rename fips FIPS
gen str5 FIPS2 = string(FIPS,"%05.0f")
order FIPS2, after(FIPS)
drop FIPS
rename FIPS2 FIPS
*delete missing values
drop if FIPS == "."
*changing variable name to prefix-date format
rename v# d#
drop if iso3 != "USA"
drop uid-code3 admin2-population
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Timeseries/new deaths/deaths.dta", replace
clear

*merge cases and deaths to fixed county file
use "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Masterfiles/county.dta"
merge 1:1 FIPS using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Timeseries/new cases/cases.dta", update replace
drop if STATE == ""
drop _merge
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Masterfiles/county.dta", replace
*merge deaths to fixed county file
merge 1:1 FIPS using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Timeseries/new deaths/deaths.dta", update replace
drop if STATE == ""
order _merge_1980-_merge_chr, last
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Masterfiles/county.dta", replace
