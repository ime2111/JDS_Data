*Feb 1 2021 Global Vaccination Data

*data downloaded from: https://ourworldindata.org/covid-vaccinations
*can probably also pull directly from github

import delimited "/Users/isminiethridge/Downloads/owid-covid-data (6).csv"

*clean out variables other than vaccination indicators
keep iso_code location date population total_vaccinations people_vaccinated people_fully_vaccinated total_vaccinations_per_hundred people_vaccinated_per_hundred people_fully_vaccinated_per_hund

*fill in missing data
bysort iso_code date: replace total_vaccinations = total_vaccinations[_n-1] if total_vaccinations == .
bysort iso_code: replace total_vaccinations = total_vaccinations[_n-1] if total_vaccinations == .
bysort iso_code: replace people_vaccinated = people_vaccinated[_n-1] if people_vaccinated == .
bysort iso_code: replace people_fully_vaccinated = people_fully_vaccinated[_n-1] if people_fully_vaccinated == .
bysort iso_code: replace total_vaccinations_per_hundred = total_vaccinations_per_hundred[_n-1] if total_vaccinations_per_hundred == .
bysort iso_code: replace people_vaccinated_per_hundred = people_vaccinated_per_hundred[_n-1] if people_vaccinated_per_hundred == .
bysort iso_code: replace people_fully_vaccinated_per_hund = people_fully_vaccinated_per_hund[_n-1] if people_fully_vaccinated_per_hund == .

*drop countries with no data
drop if total_vaccinations == .

*keep most recent data (automatically filled in with most recent data from previous commands)
keep if date == "2021-02-01"
sort total_vaccinations
drop date
order population, after(location)
save "/Users/isminiethridge/Dropbox/JDS_Data/Lancet Covid-19 Commission Data/Website Material/Feb 2021 Vaccination Table/Feb 2021 Vaccination Data.dta"

*copied data into excel sheet to format table and generate proportions
