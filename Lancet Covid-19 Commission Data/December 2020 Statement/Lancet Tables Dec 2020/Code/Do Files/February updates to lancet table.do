*February 2021 update for Dec 2020 Lancet Statement Table 1 


use "~/Dropbox/JDS_Data/Global Daily COVID-19 Data/Masterfiles/Global COVID-19 Data.dta"
merge m:m iso3 using "~/Dropbox/JDS_Data/Lancet Covid-19 Commission Data/December 2020 Statement/Lancet Tables Dec 2020/Inputs/Lancet Region Pop.dta", generate(_merge_pop)
keep iso3 country_un date day ncpm nc lancetregion pop_lancetregion worldpop 
drop if lancetregion == ""

*Save your update separately 
save "/Users/isminiethridge/Dropbox/JDS_Data/Lancet Covid-19 Commission Data/December 2020 Statement/Lancet Tables Dec 2020/Outputs/Lancet Tables update February 2021.dta"

*Generate Quarters
*20:Q2 = April 1 2020 - June 30 2020
*20:Q3 = July 1 2020 - Sept 30 2020
*20:Q4 = Oct 1 2020 – December 31 2020
*21:Q5 = January 1 2021 - Present
 
gen Q = 0
replace Q = 1 if day <= 91
replace Q = 2 if day >= 92 & day <= 182
replace Q = 3 if day >= 183 & day <= 274
replace Q = 4 if day >= 275 & day <= 366
replace Q = 5 if day >= 367

*Calculate new cases (total) by region
sort Q lancetregion
by Q lancetregion: egen nc_lancetregion = sum(nc)

*Add in number of days per quarter
gen Q_days = 0
replace Q_days = 91 if Q == 1
replace Q_days = 91 if Q == 2
replace Q_days = 92 if Q == 3
replace Q_days = 92 if Q == 4
replace Q_days = 32 if Q == 5

*Calculate new cases per day per million (by region & quarter) 
by Q lancetregion: gen avg_nc_lancetregion = ((nc_lancetregion/pop_lancetregion)/Q_days)*1000000

*Save file with all country data
save "/Users/isminiethridge/Dropbox/JDS_Data/Lancet Covid-19 Commission Data/December 2020 Statement/Lancet Tables Dec 2020/Outputs/Lancet Tables update February 2021 (all countries).dta", replace

*Eliminate countries, keep regions
drop iso3-ncpm 
order Q, first
order Q_days, after(Q)
duplicates drop

*Save file with only region data
save "/Users/isminiethridge/Dropbox/JDS_Data/Lancet Covid-19 Commission Data/December 2020 Statement/Lancet Tables Dec 2020/Outputs/Lancet Tables update February 2021 (regions only).dta"

*East Asia Sub Group Calculations
use "/Users/isminiethridge/Dropbox/JDS_Data/Lancet Covid-19 Commission Data/December 2020 Statement/Lancet Tables Dec 2020/Outputs/Lancet Tables update February 2021 (all countries).dta"
drop nc_lancetregion nc_pmpd_lancetregion
keep if lancetregion == "East Asia Pacific"
replace pop_lancetregion =  920676226 
replace pop_lancetregion =   1439323774 if iso3 == "CHN"
replace lancetregion = "China" if iso3 == "CHN"
sort Q lancetregion
by Q lancetregion: egen nc_lancetregion = sum(nc)
keep lancetregion pop_lancetregion worldpop Q Q_days nc_lancetregion
duplicates drop
bysort Q lancetregion: gen nc_pmpd_lancetregion = ((nc_lancetregion/pop_lancetregion)/Q_days)*1000000
save "/Users/isminiethridge/Dropbox/JDS_Data/Lancet Covid-19 Commission Data/December 2020 Statement/Lancet Tables Dec 2020/Outputs/Lancet Tables update February 2021 (East Asia Sub Regions).dta"

*Copy data from both files (lancet regions and east asia sub regions) to excel file and format accordingly
