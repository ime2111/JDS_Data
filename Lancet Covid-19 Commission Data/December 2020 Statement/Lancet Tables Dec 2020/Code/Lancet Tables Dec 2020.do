*Lancet Regional Tables Dec 2020
use "/Users/isminiethridge/Dropbox/IE_COVID-19/1. Global Data/Global Masterfiles/Lancet December 2020.dta"

*population calculations
use "/Users/isminiethridge/Dropbox/IE_COVID-19/1. Global Data/Global Masterfiles/Lancet December 2020.dta"
keep iso3 population lancetregion
by iso3: replace population = population[_n-1] if population == .
sort lancetregion
drop if lancetregion == ""
by lancetregion: egen pop_lancetregion = sum(population)
egen worldpop = sum(population)
save "/Users/isminiethridge/Dropbox/IE_COVID-19/Lancet Covid-19 Data/Lancet Tables Dec 2020/Lancet Region Pop.dta", replace

use "/Users/isminiethridge/Dropbox/IE_COVID-19/Lancet Covid-19 Data/Lancet Tables Dec 2020/Lancet Tables 2.dta"
keep iso3 country_un date day population ncpm nc lancetregion
merge m:m lancetregion using "/Users/isminiethridge/Dropbox/IE_COVID-19/Lancet Covid-19 Data/Lancet Tables Dec 2020/Lancet Region Pop.dta", generate(_merge_pop)
drop if lancetregion == ""
gen Q = 0
replace Q = 1 if day <= 91
replace Q = 2 if day >= 92 & day <= 182
replace Q = 3 if day >= 183 & day <= 274
replace Q = 4 if day >= 275 

sort Q lancetregion
by Q lancetregion: egen nc_lancetregion = sum(nc)

gen Q_days = 0
replace Q_days = 91 if Q == 1
replace Q_days = 91 if Q == 2
replace Q_days = 92 if Q == 3
replace Q_days = 67 if Q == 4
drop if day > 341
sort Q lancetregion
by Q lancetregion: gen avg_nc_lancetregion = ((nc_lancetregion/pop_lancetregion)/Q_days)*1000000

*East Asia sub group calculations
use "/Users/isminiethridge/Dropbox/IE_COVID-19/1. Global Data/Global Masterfiles/Lancet December 2020.dta"
keep iso3 country_un date day population ncpm nc lancetregion
merge m:m lancetregion using "/Users/isminiethridge/Dropbox/IE_COVID-19/Lancet Covid-19 Data/Lancet Tables Dec 2020/Lancet Region Pop.dta", generate(_merge_pop)
drop if lancetregion == ""
gen Q = 0
replace Q = 1 if day <= 91
replace Q = 2 if day >= 92 & day <= 182
replace Q = 3 if day >= 183 & day <= 274
replace Q = 4 if day >= 275 
keep if lancetregion == "East Asia Pacific"
replace pop_lancetregion =  920676226 
replace pop_lancetregion =   1439323774 if iso3 == "CHN"
replace lancetregion = "China" if iso3 == "CHN"
sort Q lancetregion
by Q lancetregion: egen nc_lancetregion = sum(nc)
keep lancetregion pop_lancetregion Q nc_lancetregion
gen Q_days = 0
replace Q_days = 91 if Q == 1
replace Q_days = 91 if Q == 2
replace Q_days = 92 if Q == 3
replace Q_days = 67 if Q == 4
bysort Q lancetregion: gen avg_nc_lancetregion = ((nc_lancetregion/pop_lancetregion)/Q_days)*1000000
duplicates drop
save "/Users/isminiethridge/Dropbox/IE_COVID-19/Lancet Covid-19 Data/Lancet Tables Dec 2020/EA and China Calculations Dec 7 2020.dta", replace
