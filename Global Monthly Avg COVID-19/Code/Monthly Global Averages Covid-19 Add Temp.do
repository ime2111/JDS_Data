*Clean Global Land Temp Data

import excel "/Users/isminiethridge/Dropbox/IE_COVID-19/1. Global Data/Fixed/Temperature/Average Temperature Month Country 2012.xlsx", sheet("Sheet1") firstrow clear
rename Country country
merge m:1 country using "/Users/isminiethridge/Dropbox/IE_COVID-19/1. Global Data/ISO codes and regions/ISO codes.dta", generate(_merge_temp)
replace ISO = "ATG" if country == "Antigua And Barbuda"
replace ISO = "BOL" if country == "Bolivia"
replace ISO = "BES" if country == "Bonaire, Saint Eustatius And Saba"
replace ISO = "BIH" if country == "Bosnia And Herzegovina"
replace ISO = "VGB" if country == "British Virgin Islands"
replace ISO = "MMR" if country == "Burma"
replace ISO = "CPV" if country == "Cape Verde"
replace ISO = "COD" if country == "Congo (Democratic Republic Of The)"
replace ISO = "CUW" if country == "Cura√ßao"
replace ISO = "CZE" if country == "Czech Republic"
replace ISO = "CIV" if country == "C√¥te D'Ivoire"
replace ISO = "DNK" if country == "Denmark (Europe)"
replace ISO = "FLK" if country == "Falkland Islands (Islas Malvinas)"
replace ISO = "FSM" if country == "Federated States Of Micronesia"
replace ISO = "FRA" if country == "France (Europe)"
replace ISO = "PSE" if country == "Gaza Strip"
replace ISO = "GNB" if country == "Guinea Bissau"
replace ISO = "HMD" if country == "Heard Island And Mcdonald Islands"
replace ISO = "IRN" if country == "Iran"
replace ISO = "IRN" if country == "Iran"
replace ISO = "IMN" if country == "Isle Of Man"
replace ISO = "UMI" if country == "Kingman Reef"
replace ISO = "LAO" if country == "Laos"
replace ISO = "MAC" if country == "Macau"
replace ISO = "MKD" if country == "Macedonia"
replace ISO = "MDA" if country == "Moldova"
replace ISO = "NLD" if country == "Netherlands (Europe)"
replace ISO = "PRK" if country == "North Korea"
replace ISO = "REU" if country == "Reunion"
replace ISO = "RUS" if country == "Russia"
replace ISO = "BLM" if country == "Saint Barth√©lemy"
replace ISO = "KNA" if country == "Saint Kitts And Nevis"
replace ISO = "MAF" if country == "Saint Martin"
replace ISO = "SPM" if country == "Saint Pierre And Miquelon"
replace ISO = "VCT" if country == "Saint Vincent And The Grenadines"
replace ISO = "STP" if country == "Sao Tome And Principe"
replace ISO = "SXM" if country == "Sint Maarten"
replace ISO = "KOR" if country == "South Korea"
replace ISO = "SJM" if country == "Svalbard And Jan Mayen"
replace ISO = "SWZ" if country == "Swaziland"
replace ISO = "SYR" if country == "Syria"
replace ISO = "TWN" if country == "Taiwan"
replace ISO = "TZA" if country == "Tanzania"
replace ISO = "TLS" if country == "Timor Leste"
replace ISO = "TTO" if country == "Trinidad And Tobago"
replace ISO = "TCA" if country == "Turks And Caicas Islands"
replace ISO = "GBR" if country == "United Kingdom"
replace ISO = "USA" if country == "United States"
replace ISO = "VEN" if country == "Venezuela"
replace ISO = "VNM" if country == "Vietnam"
replace ISO = "VIR" if country == "Virgin Islands"
sort ISO
replace ISO = "GBR" if country == "United Kingdom (Europe)"
sort ISO
drop if _merge_temp == 2
drop if ISO == ""
duplicates report ISO
drop if country == "Denmark"
drop if country == "France"
drop if country == "United Kingdom"
drop if country == "Netherlands"
duplicates report ISO
save "/Users/isminiethridge/Dropbox/JDS_Data/Global Monthly Avg COVID-19/Input Data/Avg Monthly Temp by Country 2012 clean.dta"
drop _merge_temp
sort country dt
save "/Users/isminiethridge/Dropbox/JDS_Data/Global Monthly Avg COVID-19/Input Data/Avg Monthly Temp by Country 2012 clean.dta", replace
gen month=month(dt)
save "/Users/isminiethridge/Dropbox/JDS_Data/Global Monthly Avg COVID-19/Input Data/Avg Monthly Temp by Country 2012 clean.dta", replace
use "/Users/isminiethridge/Dropbox/JDS_Data/Global Monthly Avg COVID-19/Input Data/Global Monthly Avg COVID-19.dta"
use "/Users/isminiethridge/Dropbox/JDS_Data/Global Monthly Avg COVID-19/Input Data/Avg Monthly Temp by Country 2012 clean.dta"
rename ISO iso3
save "/Users/isminiethridge/Dropbox/JDS_Data/Global Monthly Avg COVID-19/Input Data/Avg Monthly Temp by Country 2012 clean.dta", replace
use "/Users/isminiethridge/Dropbox/JDS_Data/Global Monthly Avg COVID-19/Input Data/Global Monthly Avg COVID-19.dta"
merge 1:1 iso3 month using "/Users/isminiethridge/Dropbox/JDS_Data/Global Monthly Avg COVID-19/Input Data/Avg Monthly Temp by Country 2012 clean.dta", generate(_merge_temp)
sort _merge_temp
drop if _merge_temp == 2
drop iso_month
sort country_un month
save "/Users/isminiethridge/Dropbox/JDS_Data/Global Monthly Avg COVID-19/Input Data/Global Monthly Avg COVID-19.dta", replace
rename country temp_country
order temp_country, after(iso3)
drop if month == 13
log close
