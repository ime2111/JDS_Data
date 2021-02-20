*Edit county masterfile duplicate city/county IDs
use "/Users/hannahsachs/Dropbox/IE_COVID-19 (1)/2. US Data/County level/Masterfiles/county.dta"
replace ID = "Missouri_St. Louis City" if FIPS == "29510"
replace ID = "Virginia_Bedford City" if FIPS == "51515"
replace ID = "Virginia_Richmond City" if FIPS == "51760"
replace ID = "Virginia_Fairfax City" if FIPS == "51600"
replace ID = "Virginia_Franklin City" if FIPS == "51620"
replace ID = "Virginia_Roanoke City" if FIPS == "51770"
