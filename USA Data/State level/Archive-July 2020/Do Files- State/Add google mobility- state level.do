*adding google mobility to state-level data: https://www.google.com/covid19/mobility/
*rename file to 'gm.csv'
import delimited "/Users/isminiethridge/Dropbox/IE_COVID-19/Global Mobility Report/gm.csv", clear
*weed out everything but states
drop if country_region != "United States"
drop if sub_region_1 == ""
drop if sub_region_2 != ""
*rename variables
rename retail_and_recreation_percent_ch gm_rr_
rename grocery_and_pharmacy_percent_cha gm_gp_
rename parks_percent_change_from_baseli gm_p_
rename transit_stations_percent_change_ gm_t_
rename workplaces_percent_change_from_b gm_w_
rename residential_percent_change_from_ gm_r_
*gen numeric dates
gen date2 = date(date, "YMD")-date("12/31/2019", "MDY")
order date2, after(date)
drop date
rename date2 date
rename sub_region_1 state
*drop unecessary variables
drop sub_region_2
drop country_region_code country_region
*reshape wide
reshape wide gm_rr_-gm_r_, i(state) j(date)
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/timeseries/google mobility/gm state.dta"

*merge with masterfile
use "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/masterfiles/state.dta"
merge 1:1 state using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/timeseries/google mobility/gm.dta", nogenerate
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/State level/masterfiles/state.dta", nogenerate update replace 


