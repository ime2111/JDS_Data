*adding google mobility data to county-level
import delimited "/Users/isminiethridge/Dropbox/IE_COVID-19/2. US Data/County level/Timeseries/Google Mobility/Global_Mobility_Report 05132020.csv", clear 

*rename variables
rename retail_and_recreation_percent_ch gm_rr_
rename grocery_and_pharmacy_percent_cha gm_gp_
rename parks_percent_change_from_baseli gm_p_
rename transit_stations_percent_change_ gm_t_
rename workplaces_percent_change_from_b gm_w_
rename residential_percent_change_from_ gm_r_

drop if country_region != "United States"
drop if sub_region_2 == ""
drop country_region_code country_region
gen date2= date(date, "20YMD")-date("12/31/2019", "MDY")
order date2, after(date)
drop date
rename date2 date

*removing "County"
gen county = subinstr(sub_region_2, "County", "", 1)
gen ID = sub_region_1 + "_" + county
order ID, after(county)
order ID, after(sub_region_2)
tostring date, replace 
reshape wide gm_rr_ gm_gp_ gm_p_ gm_t_ gm_w_ gm_r_, i(ID) j(date)

*order variables- edit to include new variables
order gm_rr_100-gm_r_99, sequential
order ID, first
order sub_region_1, after(ID)
order sub_region_2, after(sub_region_1)

*edit duplicate city/county IDs for merge w/ county masterfile
replace ID = "Missouri_St. Louis City" if sub_region_2 == "St. Louis" & ID == "Missouri_St. Louis"
replace ID = "Virginia_Fairfax City" if sub_region_2 == "Fairfax" & ID == "Virginia_Fairfax" 
replace ID = "Virginia_Franklin City" if sub_region_2 == "Franklin" & ID == "Virginia_Franklin"  
replace ID = "Virginia_Richmond City" if sub_region_2 == "Richmond" & ID == "Virginia_Richmond" 
replace ID = "Virginia_Roanoke City" if sub_region_2 == "Roanoke" & ID == "Virginia_Roanoke" 
replace ID = "Maryland_Baltimore City" if sub_region_2 == "Baltimore" & ID == "Maryland_Baltimore"
replace ID = "Alaska_Kenai Peninsula " if sub_region_2 == "Kenai Peninsula Borough" & ID == "Alaska_Kenai Peninsula Borough"
replace ID = "New Mexico_Doña Ana" if sub_region_2 == "DoÃ±a Ana County" & ID == "New Mexico_DoÃ±a Ana"
replace sub_region_2 = "Doña Ana County" if sub_region_2 == "DoÃ±a Ana County"
replace ID = subinstr(ID, "Parish", "", 1) if sub_region_1 == "Louisiana" 

**delete trailing space for merge
replace ID = strrtrim(ID) 
