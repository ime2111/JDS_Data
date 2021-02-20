generate start = 92
generate end = 132
set more off
destring, replace
encode id, gen(idn)
unab vars: *100
local stubs : subinstr local vars "100" "", all
reshape long `stubs', i(idn) j(day)
generate d1M = d/(pop/1000000)
rename rt_mean_ r
xtset idn day
sort idn day
generate gmdecline = -.01*(gm_t + gm_rr + gm_gp + gm_w)/4
generate rdecline = (2.4 - r)/2.4
generate efficientcontrol = rdecline - gmdecline
bysort idn: egen gmdeclineavg = mean(gmdecline) if day >= start & day <= end
bysort idn: egen rdeclineavg = mean(rdecline) if day >= start & day <= end
bysort idn: egen efficientcontrolavg = mean(efficientcontrol) if day >= start & day <= end
gsort - efficientcontrolavg
list state gmdeclineavg rdeclineavg efficientcontrolavg if  day == end
bysort idn: egen raverage = mean(r) if day >= start & day <= end & r ~= . 
gsort -efficientcontrolavg
egen maxeff = max(efficientcontrolavg) 
egen mineff = min(efficientcontrolavg) 
egen maxd1M = max(d1M) if day == end 
egen mind1M = min(d1M) if day == end 
egen maxr = max(raverage) 
egen minr = min(raverage) 

generate  scoreCOVID = (1/3)*(efficientcontrolavg-mineff)/(maxeff - mineff) ///
                               +(1/3)*(maxr - raverage)/(maxr - minr) ///*
							   +(1/3)*(maxd1M - d1M)/(maxd1M - mind1M)
gsort -scoreCOVID
list state scoreCOVID d1M raverage efficientcontrolavg rdecline gmdeclineavg if day == end
gsort -r
list state r if day == end
*list state mavg ghavg if day == end
drop maxeff mineff maxd1M mind1M maxr minr gmdecline rdecline efficientcontrol gmdeclineavg rdeclineavg efficientcontrolavg  ///
 scoreCOVID raverage maxeff
*calculating the first day of arrival
generate fday = 200
sort idn day
bysort idn: replace fday = day if (L.c == 0 | L.c == .) & c > 0  & c ~= . 
bysort idn: egen firstday = min(fday)
gsort firstday
list state day firstday if firstday > 0 & day == 133
drop start end 






 



							  









