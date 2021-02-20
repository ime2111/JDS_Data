*Add NYC Borough data
gen date = substr(timestamp,1,10)
gen date2= date(date, "YMD") - date("12/31/2019", "MDY")
sort type
drop if type == "deaths-no-underlying" 
drop if type == "deaths-pending-underlying" 
drop if type == "deaths-probable" 
drop if type == "deaths-underlying" 
drop if type == "ever-hospitalized"
drop timestamp date
rename date2 date
drop unknown total

*save as combined file

*first run cases

use "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Timeseries/nyc data/nyc.dta"
drop if type == "deaths"
drop type
destring bronx-staten_island, replace
order date, first
sort date
duplicates drop date, force
xpose, clear varname
order _varname, first
ssc install nrow
nrow
rename _# c#
rename date name


*merge with FIPS template
merge 1:1 name using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Timeseries/nyc data/nyc FIPS template.dta"
order FIPS, after(name)
drop _merge
tostring FIPS, replace
drop name
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Timeseries/nyc data/cases.dta"


*then run deaths
*import conmbined file

use "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Timeseries/nyc data/nyc.dta"
drop if type == "cases"
drop type
destring bronx-staten_island, replace
order date, first
sort date
duplicates drop date, force
xpose, clear varname
order _varname, first
ssc install nrow
nrow
rename _# d#
rename date name
merge 1:1 name using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Timeseries/nyc data/nyc FIPS template.dta"
order FIPS, after(name)
drop _merge
tostring FIPS, replace
drop name
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Timeseries/nyc data/deaths.dta"


*merge with county masterfile
