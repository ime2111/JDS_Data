use "/Users/jeffsachs/Dropbox/JDS_Data/Global Daily COVID-19 Data/Masterfiles/Global COVID-19 Data.dta", replace
save "/Users/jeffsachs/Dropbox/JDS_Data/Global Daily COVID-19 Data/Masterfiles/Global COVID-19 Data.dta", replace
save "/Users/jeffsachs/Dropbox/JDS_Data/WHR Paper Data/Pisa.dta", replace

keep if day == 430

export excel country iso3 PISA_readingavg PISA_scienceavg PISA_mathavg  ///
using "/Users/jeffsachs/Dropbox/JDS_Data/WHR Paper Data/Pisa.xls", replace 
use "/Users/jeffsachs/Dropbox/JDS_Data/Global Daily COVID-19 Data/Masterfiles/Global COVID-19 Data.dta", replace
