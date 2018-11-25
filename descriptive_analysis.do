   * ******************************************************************** *
   *                                                                      *
   *               Net Revenue Project                                    *
   *               Running Preliminary regressions                                       *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

       /*
       ** PURPOSE:      The pupose of the do-file is to use the merged data set and run some preliminary regressions.  
       ** OUTLINE:      PART 0:  use DataSets sub-folder globals to get the original data set
                        PART 1:generate variables for climate
						
						
                      

       ** IDS VAR:     vds_id     
       ** NOTES:

       ** WRITEN BY:    Varnitha Kurli

       ** Last date modified:  24 November 2018
       */

*******************************
*PART 0: use the original merged dataset
******************************** 
use "$MergedData/merge1.dta",replace

 
*******************************
*PART 1: use the original merged dataset
********************************
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

     tempfile            merge 
	 
	 save                `merge'
	 
	 regress              yearly_net_income_adj    plot_crop_diversity     simspon_index     i.rainfall_variability  i.temp_variability 

	 
	 regress              yearly_net_income_adj    plot_crop_diversity     simspon_index     i.weather_variability
 
	regress               total_expenditure_adj    plot_crop_diversity     simspon_index     i.rainfall_variability  i.temp_variability 

