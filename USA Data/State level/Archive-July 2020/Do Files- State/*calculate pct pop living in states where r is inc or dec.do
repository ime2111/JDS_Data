Calculate pct pop living in states where r is increasing or decreasing

*generate totalpop variable 
egen totalpop = sum(pop2019)
order totalpop, after (pop2019)

*wide to long 
encode state, gen(state_n)
unab vars: *100
local stubs : subinstr local vars "100" "", all
reshape long `stubs', i(state) j(day)

**set xtset
xtset state_n day 

**delineate states above and below r = 1 
gen rt_mean_growth = 0 
order rt_mean_growth, after(rt_mean_)
replace rt_mean_growth = 1 if rt_mean_ > 1

*calculate total pop living in states where R<>1
sort state_n day
bysort state: generate pop_r_inc = pop2019*rt_mean_growth
bysort day: egen pop_r_inctot = sum (pop_r_inc) if day >= 83

*calculate pct pop
gen pctpop_r_inc = (pop_r_inctot/totalpop)*100

**calculate each state's % of totalpop
gen pct_uspop = (pop2019/totalpop)*100

**list the day, total population that is increasing, and proportion on given day
list day pop_r_inctot  pctpop_r_inc if day >= 160 & state == "Alabama"

**list state, r, population, % for states w/ R greater than 1 on given day
list day state rt_mean_ pop2019 pct_uspop if day >= 150 & rt_mean_ > 1
export excel day state rt_mean_ pop2019 pct_uspop pctpop_r_inc if day >= 160 & rt_mean_ > 1 using "/Users/hannahsachs/Dropbox/IE_COVID-19 (1)/2. US Data/State level/Graphs of R Above 1/06022020 table", firstrow(variables)

**change the date to export of all data 
export excel state day pop_r_inctot pctpop_r_inc if day >= 83 & state == "Alabama" using "/Users/hannahsachs/Dropbox/IE_COVID-19 (1)/2. US Data/State level/Graphs of R Above 1/06022020", firstrow(variables)

**Title: Percent of US Population Where R > 1  During March 23, 2020 - x

*For a Map
rename state Name 
export delimited state rt_mean_ if day == 179 using "/Users/hannahsachs/Dropbox/IE_COVID-19 (1)/2. US Data/State level/Graphs of R Above 1/June 27 Rt"
rename Name state



