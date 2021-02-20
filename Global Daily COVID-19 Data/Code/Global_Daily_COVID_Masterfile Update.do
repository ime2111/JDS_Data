

*save backup copy of masterfile and inputs
use "~/Dropbox/JDS_Data/Global Daily COVID-19 Data/Masterfiles/Global COVID-19 Data.dta"
save "~/Dropbox/JDS_Data/Global Daily COVID-19 Data/Masterfiles/Backup Masterfiles/Global COVID-19_Data_$S_DATE.dta"

use "~/Dropbox/JDS_Data/Global Daily COVID-19 Data/Build/Inputs/Processed Data/New_COVID_Data.dta"
save "~/Dropbox/JDS_Data/Global Daily COVID-19 Data/Build/Inputs/Processed Data/Backup_New_COVID_Data/New_COVID_Data_$S_DATE.dta"

*import updated data from GitHub

import delimited https://raw.githubusercontent.com/sdsna/lancet-covid-19-database/master/data/database.csv, clear
gen day=date(date, "YMD")-date("12/31/2019", "MDY")
order day, after(date)

*rename variables
rename iso_code iso3

rename jhu_confirmed jhu_c
rename jhu_deaths jhu_d
rename jhu_recovered jhu_r

rename owid_total_cases tc
rename owid_new_cases nc
rename owid_total_deaths td
rename owid_new_deaths nd
rename owid_total_cases_per_million tcpm
rename owid_new_cases_per_million ncpm
rename owid_total_deaths_per_million tdpm
rename owid_new_deaths_per_million ndpm
rename owid_total_tests tt
rename owid_new_tests nt
rename owid_new_tests_smoothed nts
rename owid_total_tests_per_thousand ttpt
rename owid_new_tests_per_thousand ntpt
rename owid_new_tests_smoothed_per_thou ntpts
rename owid_tests_units tu
rename owid_stringency_index stringency_index
rename owid_tests_per_case owid_tpc
rename owid_positive_rate owid_pos_rate
rename owid_population population
rename owid_population_density pop_density
rename owid_median_age median_age
rename owid_aged_65_older aged_65_older
rename owid_aged_70_older aged_70_older
rename owid_gdp_per_capita gdp_per_capita
rename owid_extreme_poverty ext_poverty
rename owid_cardiovasc_death_rate cardio_death_rate
rename owid_diabetes_prevalence diabetes_prevalence
rename owid_female_smokers female_smokers
rename owid_male_smokers male_smokers
rename owid_handwashing_facilities handwashing_facilities
rename owid_hospital_beds_per_thousand hospital_beds_pt
rename owid_life_expectancy life_expectancy
rename owid_tpc tpc_avg
rename owid_pos_rate pos_rate_avg

rename marioli_effective_reproduction_r ERR
rename marioli_ci_65_u ERR_ci_65_u
rename marioli_ci_65_l ERR_ci_65_l
rename marioli_ci_95_u ERR_ci_95_u
rename marioli_ci_95_l ERR_ci_95_l

rename yougov_fear_of_catching yg_fc
rename yougov_government_handling yg_gh
rename yougov_avoiding_crowded_places yg_cp
rename yougov_wearing_mask_in_public yg_mip
rename yougov_avoiding_going_to_work yg_aw
rename yougov_avoiding_raw_meat yg_arm
rename yougov_stopping_sending_children yg_scs
rename yougov_improving_personal_hygien yg_ph
rename yougov_refraining_from_touching_ yg_rto
rename yougov_avoiding_contact_with_tou yg_act
rename yougov_support_stopping_flights_ yg_sfc
rename yougov_support_quarantine_flight yg_qfc
rename yougov_support_stopping_internat yg_ssif
rename yougov_support_quarantine_intern yg_sqif
rename yougov_support_quarantine_chines yg_sqct
rename yougov_support_quarantine_any_pe yg_sqap
rename yougov_support_quarantine_any_lo yg_sqal
rename yougov_support_free_masks yg_sfm
rename yougov_support_work_from_home yg_swfh
rename yougov_support_temporarily_close yg_stcs
rename yougov_support_cancel_large_even yg_scle
rename yougov_support_cancel_hospital_r yg_schr
rename yougov_confidence_in_health_auth yg_cha
rename yougov_perceived_national_improv yg_pci
rename yougov_perceived_global_improvem yg_pgi
rename yougov_international_happiness yg_ih
rename yougov_personal_health_fears yg_phf
rename yougov_friends_and_family_health yg_ffh
rename yougov_finances_fears yg_ff
rename yougov_job_loss_fears yg_jlf
rename yougov_education_fears yg_ef
rename yougov_social_impact_fears yg_sif


rename google_mobility_change_grocery_a gm_gp
rename google_mobility_change_parks gm_p
rename google_mobility_change_transit_s gm_ts
rename google_mobility_change_retail_an gm_rr
rename google_mobility_change_residenti gm_r
rename google_mobility_change_workplace gm_cw

rename ox_c1_school_closing ox_sc
rename ox_c2_workplace_closing ox_wc
rename ox_c3_cancel_public_events ox_cpe
rename ox_c4_restrictions_on_gatherings ox_rg
rename ox_c5_close_public_transport ox_cpt
rename ox_c6_stay_at_home_requirements ox_shr
rename ox_c7_restrictions_on_internal_m ox_rim
rename ox_c8_international_travel_contr ox_itc
rename ox_e1_income_support ox_is
rename ox_e2_debt_or_contract_relief ox_dcr
rename ox_e3_fiscal_measures ox_fm
rename ox_e4_international_support ox_ints
rename ox_h1_public_information_campaig ox_pic
rename ox_h2_testing_policy ox_tp
rename ox_h3_contact_tracing oc_ct
rename ox_h4_emergency_investment_in_he ox_eihc
rename ox_h5_investment_in_vaccines ox_iiv
rename ox_stringency_index_for_display ox_sid
rename ox_confirmed_cases ox_cc
rename ox_confirmed_deaths ox_cd
rename ox_stringency_index ox_si
rename ox_m1_wildcard ox_wildcard
rename ox_stringency_legacy_index ox_sli
rename ox_stringency_legacy_index_for_d ox_slid
rename ox_government_response_index ox_gri
rename ox_government_response_index_for ox_grid
rename ox_containment_health_index ox_chi
rename ox_containment_health_index_for_ ox_chid
rename ox_economic_support_index ox_esi
rename ox_economic_support_index_for_di ox_esid

rename sdsn_new_cases_per_million_smoot ncpm_avg
rename sdsn_new_deaths_per_million_smoo ndpm_avg
rename sdsn_effective_reproduction_rate ERR_avg
rename sdsn_overall_transmission transmission_class

drop ERR_ci_65_u-ERR_ci_95_l
drop ox_c1_flag ox_c2_flag ox_c3_flag ox_c4_flag ox_c5_flag ox_c6_flag ox_c7_flag ox_e1_flag ox_h1_flag ox_wildcard

rename v26 wem_pscore_0_14
rename v27 wem_pscore_15_64
rename v28 wem_pscore_65_74
rename v29 wem_pscore_75_84
rename owid_weekly_excess_mortality_p_s wen_p_s
rename owid_weekly_deaths_2020 weekly_deaths_2020
rename owid_weekly_deaths_2019 weekly_deaths_2019
rename owid_weekly_deaths_2018 weekly_deaths_2018
rename owid_weekly_deaths_2017 weekly_deaths_2017
rename owid_weekly_deaths_2016 weekly_deaths_2016
rename owid_weekly_deaths_2015 weekly_deaths_2015
rename owid_avg_weekly_deaths_2015_2019 avg_weekly_deaths_2015_2019

drop if iso3 == ""
sort iso3 day

*fill in missing data for yougov
generate yg_fcfill = yg_fc 
order yg_fcfill, after(yg_fc)
bysort iso3: replace yg_fcfill = yg_fcfill[_n-1] if yg_fcfill == . & yg_fcfill[_n-1] ~= .

generate yg_cpfill = yg_cp 
order yg_cpfill, after(yg_cp)
bysort iso3: replace yg_cpfill = yg_cpfill[_n-1] if yg_cpfill == . & yg_cpfill[_n-1] ~= .

generate yg_ghfill = yg_gh 
order yg_ghfill, after(yg_gh)
bysort iso3: replace yg_ghfill = yg_ghfill[_n-1] if yg_ghfill == . & yg_ghfill[_n-1] ~= .

generate yg_mipfill = yg_mip 
order yg_mipfill, after(yg_mip)
bysort iso3: replace yg_mipfill = yg_mipfill[_n-1] if yg_mipfill == . & yg_mipfill[_n-1] ~= .

generate yg_awfill = yg_aw 
order yg_awfill, after(yg_aw)
bysort iso3: replace yg_awfill = yg_awfill[_n-1] if yg_awfill == . & yg_awfill[_n-1] ~= .

generate yg_armfill = yg_arm 
order yg_armfill, after(yg_arm)
bysort iso3: replace yg_armfill = yg_armfill[_n-1] if yg_armfill == . & yg_armfill[_n-1] ~= .

generate yg_scsfill = yg_scs 
order yg_scsfill, after(yg_scs)
bysort iso3: replace yg_scsfill = yg_scsfill[_n-1] if yg_scsfill == . & yg_scsfill[_n-1] ~= .

generate yg_phfill = yg_ph
order yg_phfill, after(yg_ph)
bysort iso3: replace yg_phfill = yg_phfill[_n-1] if yg_phfill == . & yg_phfill[_n-1] ~= .

generate yg_rtofill = yg_rto
order yg_rtofill, after(yg_rto)
bysort iso3: replace yg_rtofill = yg_rtofill[_n-1] if yg_rtofill == . & yg_rtofill[_n-1] ~= .

generate yg_actfill = yg_act
order yg_actfill, after(yg_act)
bysort iso3: replace yg_actfill = yg_actfill[_n-1] if yg_actfill == . & yg_actfill[_n-1] ~= .

generate yg_sfcfill = yg_sfc
order yg_sfcfill, after(yg_sfc)
bysort iso3: replace yg_sfcfill = yg_sfcfill[_n-1] if yg_sfcfill == . & yg_sfcfill[_n-1] ~= .

generate yg_qfcfill = yg_qfc
order yg_qfcfill, after(yg_qfc)
bysort iso3: replace yg_qfcfill = yg_qfcfill[_n-1] if yg_qfcfill == . & yg_qfcfill[_n-1] ~= .

generate yg_ssiffill = yg_ssif
order yg_ssiffill, after(yg_ssif)
bysort iso3: replace yg_ssiffill = yg_ssiffill[_n-1] if yg_ssiffill == . & yg_ssiffill[_n-1] ~= .

generate yg_sqiffill = yg_sqif
order yg_sqiffill, after(yg_sqif)
bysort iso3: replace yg_sqiffill = yg_sqiffill[_n-1] if yg_sqiffill == . & yg_sqiffill[_n-1] ~= .

generate yg_sqctfill = yg_sqct
order yg_sqctfill, after(yg_sqct)
bysort iso3: replace yg_sqctfill = yg_sqctfill[_n-1] if yg_sqctfill == . & yg_sqctfill[_n-1] ~= .

generate yg_sqapfill = yg_sqap
order yg_sqapfill, after(yg_sqap)
bysort iso3: replace yg_sqapfill = yg_sqapfill[_n-1] if yg_sqapfill == . & yg_sqapfill[_n-1] ~= .

generate yg_sqalfill = yg_sqal
order yg_sqalfill, after(yg_sqal)
bysort iso3: replace yg_sqalfill = yg_sqalfill[_n-1] if yg_sqalfill == . & yg_sqalfill[_n-1] ~= .

generate yg_sfmfill = yg_sfm
order yg_sfmfill, after(yg_sfm)
bysort iso3: replace yg_sfmfill = yg_sfmfill[_n-1] if yg_sfmfill == . & yg_sfmfill[_n-1] ~= .

generate yg_swfhfill = yg_swfh
order yg_swfhfill, after(yg_swfh)
bysort iso3: replace yg_swfhfill = yg_swfhfill[_n-1] if yg_swfhfill == . & yg_swfhfill[_n-1] ~= .

generate yg_stcsfill = yg_stcs
order yg_stcsfill, after(yg_stcs)
bysort iso3: replace yg_stcsfill = yg_stcsfill[_n-1] if yg_stcsfill == . & yg_stcsfill[_n-1] ~= .

generate yg_sclefill = yg_scle
order yg_sclefill, after(yg_scle)
bysort iso3: replace yg_sclefill = yg_sclefill[_n-1] if yg_sclefill == . & yg_sclefill[_n-1] ~= .

generate yg_schrfill = yg_schr
order yg_schrfill, after(yg_schr)
bysort iso3: replace yg_schrfill = yg_schrfill[_n-1] if yg_schrfill == . & yg_schrfill[_n-1] ~= .

generate yg_pcifill = yg_pci
order yg_pcifill, after(yg_pci)
bysort iso3: replace yg_pcifill = yg_pcifill[_n-1] if yg_pcifill == . & yg_pcifill[_n-1] ~= .

generate yg_pgifill = yg_pgi
order yg_pgifill, after(yg_pgi)
bysort iso3: replace yg_pgifill = yg_pgifill[_n-1] if yg_pgifill == . & yg_pgifill[_n-1] ~= .

generate yg_ihfill = yg_ih
order yg_ihfill, after(yg_ih)
bysort iso3: replace yg_ihfill = yg_ihfill[_n-1] if yg_ihfill == . & yg_ihfill[_n-1] ~= .

generate yg_phffill = yg_phf
order yg_phffill, after(yg_phf)
bysort iso3: replace yg_phffill = yg_phffill[_n-1] if yg_phffill == . & yg_phffill[_n-1] ~= .

generate yg_ffhfill = yg_ffh
order yg_ffhfill, after(yg_ffh)
bysort iso3: replace yg_ffhfill = yg_ffhfill[_n-1] if yg_ffhfill == . & yg_ffhfill[_n-1] ~= .

generate yg_fffill = yg_ff
order yg_fffill, after(yg_ff)
bysort iso3: replace yg_fffill = yg_fffill[_n-1] if yg_fffill == . & yg_fffill[_n-1] ~= .

generate yg_jlffill = yg_jlf
order yg_jlffill, after(yg_jlf)
bysort iso3: replace yg_jlffill = yg_jlffill[_n-1] if yg_jlffill == . & yg_jlffill[_n-1] ~= .

generate yg_effill = yg_ef
order yg_effill, after(yg_ef)
bysort iso3: replace yg_effill = yg_effill[_n-1] if yg_effill == . & yg_effill[_n-1] ~= .

generate yg_siffill = yg_sif
order yg_siffill, after(yg_sif)
bysort iso3: replace yg_siffill = yg_siffill[_n-1] if yg_siffill == . & yg_siffill[_n-1] ~= .

*merge to masterfile

save "~/Dropbox/JDS_Data/Global Daily COVID-19 Data/Build/Inputs/Processed Data/New_COVID_Data.dta", replace
use "~/Dropbox/JDS_Data/Global Daily COVID-19 Data/Masterfiles/Global COVID-19 Data.dta"
merge m:m iso3 using "~/Dropbox/JDS_Data/Global Daily COVID-19 Data/Build/Inputs/Processed Data/New_COVID_Data.dta", nogenerate update replace

*save
sort iso3 day
drop if iso3 == "-"
save "~/Dropbox/JDS_Data/Global Daily COVID-19 Data/Masterfiles/Global COVID-19 Data.dta", replace
