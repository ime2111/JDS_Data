set more off
destring, replace
encode iso, gen(ison)
unab vars: *100
local stubs : subinstr local vars "100" "", all
reshape long `stubs', i(ison) j(day)
generate d1M = d/(pop/1000000)
xtset ison day
sort ison day
generate gmdecline = -.01*(gm_t + gm_rr + gm_gp + gm_w)/4
generate rdecline = (2.4 - r)/2.4
generate efficientcontrol = rdecline - gmdecline
bysort ison: egen gmdeclineavg = mean(gmdecline) if day >= 74 & day <= 125
bysort ison: egen rdeclineavg = mean(rdecline) if day >= 74 & day <= 125
bysort ison: egen efficientcontrolavg = mean(efficientcontrol) if day >= 74 & day <= 125
list country gmdeclineavg rdeclineavg efficientcontrolavg if oecd == 1 & day == 120
list country score if day == 120 & oecd == 1
bysort ison: egen raverage = mean(r) if day >= 74 & day <= 125 & r ~= . 
gsort -efficientcontrolavg
egen maxeff = max(efficientcontrolavg) if oecd == 1
egen mineff = min(efficientcontrolavg) if oecd == 1
egen maxd1M = max(d1M) if day == 120 & oecd ==1
egen mind1M = min(d1M) if day == 120 & oecd == 1
egen maxr = max(raverage) if oecd == 1
egen minr = min(raverage) if oecd == 1

generate  scoreCOVID = (1/3)*(efficientcontrolavg-mineff)/(maxeff - mineff) ///
                               +(1/3)*(maxr - raverage)/(maxr - minr) ///*
							   +(1/3)*(maxd1M - d1M)/(maxd1M - mind1M)
gsort -scoreCOVID
list country scoreCOVID d1M raverage efficientcontrolavg rdecline gmdeclineavg if day == 120 & oecd == 1
gsort -r
list country r if oecd == 1 & day == 120
*list country mavg ghavg if oecd == 1 & day == 120
drop maxeff mineff maxd1M mind1M maxr minr gmdecline rdecline efficientcontrol gmdeclineavg rdeclineavg efficientcontrolavg nocontrol ineffcontrol effcontrol ///
nocontrolavg ineffcontrolavg effcontrolavg score scoreCOVID raverage maxeff mavg ghavg
*calculating the first day of arrival
generate fday = 200
sort ison day
bysort ison: replace fday = day if (L.c == 0 | L.c == .) & c > 0  & c ~= . 
bysort ison: egen firstday = min(fday)
gsort firstday
list Country day firstday if firstday > 0 & day == 130






 



							  









