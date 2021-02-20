*Adding inmates data
use "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/Federal Penitentiaries/FIPS inmates clean.dta"
collapse (sum) inmates, by(FIPS)
*drop missing values
drop in 1
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/Federal Penitentiaries/FIPS inmates collapsed.dta"
*merge with fixed county data file
use "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County Masterfiles/County Fixed 05112020.dta"
merge 1:1 FIPS using "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/Federal Penitentiaries/FIPS inmates collapsed.dta", generate(_merge_inmates)
order inmates, after(pop)
save "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County Masterfiles/County Fixed 05112020.dta", replace
