*Lancet Table 1 Calculations
use "/Users/isminiethridge/Dropbox/IE_COVID-19/1. Global Data/Global Masterfiles/Github_complete.dta"
keep iso3 UN_Country UN_region oecd g20 eu asean pop2018 PISA_2018 GDP_pc_PPP gini1618 extreme_poverty day date ndpm tdpm tt ncpm ntpt nt pos_rate ERR tpc tc
gen two_wk = 0
bysort iso3: replace two_wk = day - day[_N]
sort iso3
drop if UN_Country == ""
save "/Users/isminiethridge/Dropbox/IE_COVID-19/Lancet Covid-19 Data/2_week_avg.dta", replace
egen ncpm_avg = mean(ncpm) if two_wk > -14, by(iso3)
egen ndpm_avg = mean(ndpm) if two_wk > -14, by(iso3)
egen ERR_avg = mean(ERR) if two_wk > -14, by(iso3) 
egen pos_rate_avg = mean(pos_rate) if two_wk > -14, by(iso3) 
egen tpc_avg = mean(tpc) if two_wk > -14, by(iso3) 

gen S = 0 
gen L = 0
gen M = 0
gen H = 0
gen VH = 0
gen Missing = 0
replace Missing = 1 if tpc_avg == . 
replace S = 1 if ncpm_avg  <= 5 & tpc >= 20 & Missing != 1
replace L = 1 if ncpm_avg  <= 10 & S != 1
replace M = 1 if ncpm_avg  > 10 & ncpm_avg <= 50 
replace H = 1 if ncpm_avg  > 50 & ncpm_avg  <= 100 
replace VH = 1 if ncpm_avg > 100 

sort Missing VH H M L S ncpm_avg ERR_avg tpc_avg ndpm_avg iso3 day
browse UN_Country date day ncpm_avg ndpm_avg tpc_avg ERR_avg S L M H VH Missing if two_wk == 0

save "/Users/isminiethridge/Dropbox/IE_COVID-19/Lancet Covid-19 Data/2_week_avg.dta", replace
