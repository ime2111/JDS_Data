use "/Users/jeffsachs/Dropbox/JDS_Data/Global Monthly Avg COVID-19/Outputs/Feb 18 2021-Monthly Global COVID-19 Data.dta", replace
save "/Users/jeffsachs/Dropbox/JDS_Data/Global Monthly Avg COVID-19/Outputs/Feb 18 2021-Monthly Global COVID-19 Data.dta", replace
save "/Users/jeffsachs/Dropbox/JDS_Data/WHR Paper Data/Feb 18 2021-WHR COVID-19 Data.dta", replace

bysort iso3: egen ndpmQ1 = mean(ndpm) if month >= 1 & month <= 3
bysort iso3: egen ndpmQ2 = mean(ndpm) if month >= 4 & month <= 6
bysort iso3: egen ndpmQ3 = mean(ndpm) if month >= 7 & month <= 9
bysort iso3: egen ndpmQ4 = mean(ndpm) if month >= 10 & month <= 12
bysort iso3: egen ndpmQ5 = mean(ndpm) if month == 13 
bysort iso3  (ndpmQ1): replace ndpmQ1 = ndpmQ1[1]  
bysort iso3  (ndpmQ2): replace ndpmQ2 = ndpmQ2[1] 
bysort iso3  (ndpmQ3): replace ndpmQ3 = ndpmQ3[1] 
bysort iso3  (ndpmQ4): replace ndpmQ4 = ndpmQ4[1] 
bysort iso3  (ndpmQ5): replace ndpmQ5 = ndpmQ5[1] 

keep if month == 14 & apna == 1

export excel country iso3 rcepn apna ndpmQ1 ndpmQ2 ndpmQ3 ndpmQ4 ndpmQ5 ///
using "/Users/jeffsachs/Dropbox/JDS_Data/WHR Paper Data/Feb 18 2021-WHR COVID-19 Data.xls", replace 
use "/Users/jeffsachs/Dropbox/JDS_Data/Global Monthly Avg COVID-19/Outputs/Feb 18 2021-Monthly Global COVID-19 Data.dta", replace
