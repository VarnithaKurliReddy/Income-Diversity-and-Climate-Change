   * ******************************************************************** *
   *                                                                      *
   *               Net Revenue Project                                    *
   *               Running Preliminary regressions                                       *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

       /*
       ** PURPOSE:      The pupose of the do-file is to use the merged data set and clean it.  
       ** OUTLINE:      PART 0:  clean
                        PART 1:generate variables for climate
						
						
                      

       ** IDS VAR:     vds_id     
       ** NOTES:

       ** WRITEN BY:    Varnitha Kurli

       ** Last date modified:  Dec 9 2018
       */

*******************************
*PART 0: use the original expenditure, climate, income diversity, and crop diversity datasets.
******************************** 
*generating a varible to merge all the five files
use "$Finalfiles/merged.dta" ,clear

destring year,replace

replace tehsil_name=proper(tehsil_name)

drop    hhid HHID

rename  pre_hh_no  household_no

rename  pre_farm_size farm_size

replace caste=proper(caste)

