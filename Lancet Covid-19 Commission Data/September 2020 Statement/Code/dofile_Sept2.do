*Lancet Calculations 9/2

use "/Users/isminiethridge/Dropbox/IE_COVID-19/1. Global Data/Global Masterfiles/Github_complete.dta"
keep iso3 UN_Country day ndpm tdpm tt ncpm ntpt nt pos_rate ERR tpc tc
keep if day > 213
by iso3: replace UN_Country = UN_Country[_n-1] if missing(UN_Country)
save "/Users/isminiethridge/Dropbox/IE_COVID-19/Lancet Covid-19 Data/Sept 2 calculations.dta", replace
by iso3: replace tpc = tpc[_n-1] if missing(tpc)
egen ncpm_avg = mean(ncpm), by(iso3)
egen ndpm_avg = mean(ndpm), by(iso3)
egen ERR_avg = mean(ERR), by(iso3)
keep if day == 245

gen S = 0 
gen L = 0
gen M = 0
gen H = 0
gen VH = 0
gen Missing = 0
replace Missing = 1 if tpc == . 
replace S = 1 if ncpm_avg  <= 5 & tpc >= 20 & Missing != 1
replace L = 1 if ncpm_avg  <= 10 & ncpm_avg > 5 & Missing != 1
replace M = 1 if ncpm_avg  > 10 & ncpm_avg <= 50 & Missing != 1
replace H = 1 if ncpm_avg  > 50 & ncpm_avg  <= 100 & Missing != 1
replace VH = 1 if ncpm_avg > 100 & Missing != 1
sort Missing VH H M L S ncpm_avg ERR_avg tpc ndpm_avg 
edit UN_Country ncpm_avg ndpm_avg tpc ERR_avg S L M H VH Missing
