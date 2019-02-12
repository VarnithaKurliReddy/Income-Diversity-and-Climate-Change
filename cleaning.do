   * ******************************************************************** *
   *                                                                      *
   *               Income Diversity and Climate Change                    *
   *               Cleaning variables from census data                    *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

       /*
       ** PURPOSE:      The pupose of the do-file is to use the merged data set and clean it.  
       ** OUTLINE:      PART 0: use the original census data and clean it
                        PART 1: use the original temperature and rainfall data and clean it
						PART 2: use the  income diversity data and clean it
						
						
                      

       ** IDS VAR:     vds_id     
       ** NOTES:

       ** WRITEN BY:    Varnitha Kurli

       ** Last date modified:  Jan 29 2018
       */

*******************************
*PART 0: use the original census data and clean it
******************************** 
use "$Finalfiles/control_variables.dta" ,clear

* Keeping only variables that are of interest to us

drop IND_SCH TR_SCH ADLT_LT_CT OTH_SCH CULT_WASTE AREA_NA_CU COLLEGE RANG_COLL APP_NAVRIV APP_NAVCAN APP_NW NEAR_TOWN DIST_TOWN SOU_SUMM RANG_SS SS_CODE  ///
CensusVillage_Code SID DID TID VILL_CODE C_CODE01 NAME UID CENSUS_COD STATE DISTRICT SUB_DIST TOWN_VILL LEVEL NAME_1 TRU ST_CODE DIST_CODE THSIL_CODE BLOCK_CODE V_CT_CODE AREA VDSATehsil_Code EDU_FAC DRNK_WAT_F RANG_WAT_F 
*Renaming all the education indicators
rename ///
		(P_SCH                   RANG_P_SCH           M_SCH                   RANG_M_SCH           S_SCH                        S_S_SCH) ///
		(number_primary_schools  dist_primary_school  number_middle_schools  dist_middle_school   number_secondary_school      number_senior_secondary_school)
*Renaming all the water supply indicators		
rename ///
		(TAP               WELL              TANK              TUBEWELL              HANDPUMP              RIVER                  CANAL              LAKE              SPRING              OTHER) ///
		(water_source_tap  water_source_well water_source_tank water_source_tubewell water_source_handpump water_source_river  water_source_canal water_source_lake water_source_spring water_source_other)
*Renaming roads variables		
rename ///
		(APP_PR                    APP_MR                       APP_FP) ///
		(Approach_Paved_Road     Approach_Mud_Road          Approach_Foot_Path)
*Renaming  variables for Land area(Hectares) irrigated by diff sources

rename  ///
        (CANAL_GOVT      CANAL_PVT            WELL_WO_EL                WELL_W_EL  TW_WO_EL           TW_W_EL            TANK_IRR  RIVER_IRR  LAKE_IRR  W_FALL         OTH_IRR   TOT_IRR  UN_IRR) ///
		(irri_govt_canal irri_private_canal   irri_well_no_elect  irri_well_elect  tube_well_no_elect tube_well_elect irr_tank  irr_river  irr_lake  irr_waterfall  other_irr irr_tot  irr_not) 
		

*Value labels for categorical variables		


lab def cat 1 "Yes/Available"  2 "No/NotAvailable" 0 "Nil_Info", replace
		foreach var of varlist  water_source_tap  water_source_well water_source_tank water_source_tubewell water_source_handpump water_source_river  water_source_canal water_source_lake water_source_spring water_source_other  ///
		                        Approach_Paved_Road Approach_Mud_Road Approach_Foot_Path ///
		                        {
								  lab val `var' cat
		                         }
lab def range 1 "Less than 5 km"  2 "5-10km" 3 "Morethan 10km", replace
		  foreach var of varlist dist_primary_school dist_middle_school ///
		                                {
										  lab val `var' range
										}
										

*Save the cleaned control_variables data
 
	 save           "$Finalfiles/cleaned_control.dta",replace
*******************************
*PART 1:Add demographic data
******************************** 	
use "$Finalfiles/additional_control.dta" ,clear

replace caste=proper(caste)
replace caste=subinstr(caste," ","",.)

 save           "$Finalfiles/additional_control.dta",replace
 
 *******************************
*PART 2:Add climate data and 
******************************** 
use "$Finalfiles/temperature.dta" ,clear

rename   ///
           (rain_jjas cv_jjas mad_jjas rain_jjaso cv_jjaso mad_jjaso rain_yearly cv_yearly mad_yearly)
		   ()
