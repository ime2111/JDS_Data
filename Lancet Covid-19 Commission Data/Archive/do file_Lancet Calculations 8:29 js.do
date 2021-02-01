*Lancet Calculations Aug 29
*Using Github_complete.dta file
**Careful to not overwrite
use "/Users/jeffsachs/Dropbox/IE_COVID-19/1. Global Data/Global Masterfiles/Github_complete.dta"
keep if day > 226
save "/Users/jeffsachs/Dropbox/IE_COVID-19/Lancet Covid-19 Data/2 wk average Aug 29.dta", replace
*keep iso3 country day tc-ntpts ERR test_pct_pos
keep iso3 country day tc-ntpts ERR testpos
sort country day
drop if country == ""
drop if day == .
sort iso3
by iso3: replace ERR = ERR[_n-1] if missing(ERR)

*Generate Averages
egen tc_2wk_avg = mean(tc), by(iso3)
egen nc_2wk_avg = mean(nc), by(iso3)
egen td_2wk_avg = mean(td), by(iso3)
egen nd_2wk_avg = mean(nd), by(iso3)
egen tcpm_2wk_avg = mean(tcpm), by(iso3)
egen ncpm_2wk_avg = mean(ncpm), by(iso3)
egen tt_2wk_avg = mean(tt), by(iso3)
egen nt_2wk_avg = mean(nt), by(iso3)
egen nts_2wk_avg = mean(nts), by(iso3)
egen ttpt_2wk_avg = mean(ttpt), by(iso3)
egen ntpt_2wk_avg = mean(ntpt), by(iso3)
egen ntpts_2wk_avg = mean(ntpts), by(iso3)
egen ERR_2wk_avg = mean(ERR), by(iso3)
egen positive_rate_2wk_avg = mean(testpos), by(iso3)

*NOT NECESSARY BUT EASIER TO READ
*keep if day == 240

*Generate Categories
gen suppression = 0 
gen low_level = 0
gen high_level = 0
gen missing_data = 0

*Classify ORIGINAL CRITERIA
replace missing_data = 1 if ncpm_2wk_avg == .
replace missing_data = 1 if ntpt_2wk_avg == .
replace suppression = 1 if ncpm_2wk_avg <= 5 & positive_rate_2wk_avg < .01 & missing_data != 1
replace low_level = 1 if ncpm_2wk_avg > 5 & ncpm_2wk_avg < 50 & positive_rate_2wk_avg < .05 & missing_data != 1
replace high_level = 1 if ncpm_2wk_avg > 50 & missing_data != 1
replace high_level = 1 if positive_rate_2wk_avg > .05 & missing_data != 1
sort missing_data high_level low_level suppression

*Classify NEW

gen suppression_2 = 0 
gen low_level_2 = 0
gen moderate_level_2 = 0
gen high_level_2 = 0
gen missing_data_2 = 0

replace missing_data_2 = 1 if ncpm_2wk_avg == .
replace missing_data_2 = 1 if ntpt_2wk_avg == .
replace suppression_2 = 1 if ncpm_2wk_avg <= 5 & missing_data_2 != 1
replace low_level_2 = 1 if ncpm_2wk_avg > 5 & ncpm_2wk_avg < 50 & positive_rate_2wk_avg < .03 & ERR_2wk_avg < 1 & missing_data_2 != 1
replace moderate_level_2 = 1 if ncpm_2wk_avg > 5 & ncpm_2wk_avg < 50 & positive_rate_2wk_avg > .03 & missing_data_2 != 1
replace moderate_level_2 = 1 if ncpm_2wk_avg > 5 & ncpm_2wk_avg < 50 & ERR_2wk_avg > 1 & missing_data_2 != 1
replace high_level_2 = 1 if ncpm_2wk_avg > 50 & missing_data_2 != 1
sort missing_data_2 high_level_2 moderate_level_2 low_level_2 suppression_2
