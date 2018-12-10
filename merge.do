   * ******************************************************************** *
   *                                                                      *
   *               Net Revenue Project                                    *
   *               Running Preliminary regressions                                       *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

       /*
       ** PURPOSE:      The pupose of the do-file is to use the merged data set and run some preliminary regressions.  
       ** OUTLINE:      PART 0:  Merge the five datasets
                        
						
                      

       ** IDS VAR:     vds_id     
       ** NOTES:

       ** WRITEN BY:    Varnitha Kurli

       ** Last date modified:  Dec 1 2018
       */

*******************************
*PART 0: use the original expenditure, climate, income diversity, and crop diversity datasets.
******************************** 
*generating a varible to merge all the five files
use "$Finalfiles/climate.dta" ,clear

tostring                village_code                 vds_year,         replace

gen                     temp=                        vds_year+         village_code

save "$Finalfiles/climate.dta" ,replace

use "$Finalfiles/income_diversity.dta" ,clear

tostring                village                      year,           replace

gen                     temp=                        year+           village

save "$Finalfiles/income_diversity.dta" ,replace

use "$Finalfiles/expenditute.dta" ,clear

gen    year=            "20" +                      substr(vds_id,4,2)

tostring               village_code,                replace

gen                     temp=                        year+           village_code

save                    "$Finalfiles/expenditute.dta" ,replace

*keep only the required variables 
use                    "$Finalfiles/crop_diversity.dta" ,clear

keep                    vds_id    Year      hh_id     hh_id_code   crop_diversity

save                    "$Finalfiles/crop_diversity.dta" ,replace


*Merge climate data that is available at village level with income_diversity data.
*merge1 provides summary of merging climate income diversity data with expenditure data.
*merge2 provides summary of merging climate income diversity-expenditure data with crop_diversity data.

use                    "$Finalfiles/climate.dta" ,clear

merge                   1:m                       temp                 using            "$Finalfiles/income_diversity.dta",force

keep                    if                        _merge==             3

tempfile                climate_income_diversity

save                    `climate_income_diversity'

drop                     _merge

merge                    1:1                     vds_id                using            "$Finalfiles/expenditure.dta",force

rename                   _merge                  merge1

merge                    1:1                     vds_id                using            "$Finalfiles/crop_diversity.dta",force
 
rename                   _merge                 merge2

save                    "$Finalfiles/merged.dta" ,replace 

drop                     merge1

rename                   merge2      dummy_crop_diversity

label                    define       dummy_crop_diversity    1 "no_crop_diversity"   3 "yes_crop_diversity"

label                    value        dummy_crop_diversity    dummy_crop_diversity

save                    "$Finalfiles/merged.dta" ,replace 


*
*******************************
*PART 1: use the restrcited merged dataset
********************************
use                    "$Finalfiles/merged_restricted.dta" ,clear


     gen                rainfall_variability=1  if    z_prep_anomaly_30<-1.5
	 
	 replace            rainfall_variability=2  if    inrange(z_prep_anomaly_30,-1.5,-1)
	 
	 replace            rainfall_variability=3  if    inrange(z_prep_anomaly_30,-1,-.5)
	 
	 replace            rainfall_variability=0  if    rainfall_variability==.
	 
	 
	 gen                temp_variability=1  if    mean_maxt_anomaly_z_30<1.5
	 
	 replace            temp_variability=2  if    inrange(mean_maxt_anomaly_z_30,1.5,1)
	 
	 replace            temp_variability=3  if    inrange(mean_maxt_anomaly_z_30,1,.5)
	 
	 replace            temp_variability=0  if    temp_variability==.
	 
	 
	 gen                 weather_variability= 1 if (rainfall_variability==1)| (rainfall_variability==2) | (rainfall_variability==3)  & temp_variability==1
	 
	 replace             weather_variability= 0 if rainfall_variability==0 | temp_variability==0
	 
	 

save                    "$Finalfiles/merged_restricted.dta" ,replace 
	 
