* ******************************************************************** *
   * ******************************************************************** *
   *                                                                      *
   *               Net Revenue Analysis                                     *
   *               MASTER DO_FILE                                         *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

       /*
       ** PURPOSE:      The purpose of the project is to Measure the effect of long term climate variability on net revenue for farmers in Semi Arid tropics of India

       ** OUTLINE:      
                        PART 1: Set globals for dynamic file paths
                        
                        PART 3: Call the task specific master do-files 
                               that call all do-files needed for that 
                               tas. Do not include Part 0-2 in a task
                               specific master do-file


       ** IDS VAR:      list_ID_var_here         

       ** NOTES:

       ** WRITEN BY:    Varnitha Kurli
	   
	   

       ** Last date modified:  6 Aug 2018
       */

*
   * Users
   * -----------

   *User Number:
   * You                     1    //Replace "You" with your name
   * Next User               2    //Assign a user number to each additional collaborator of this code

   *Set this value to the user currently using this file
   global user  1

   * Root folder globals
   * ---------------------

   if $user == 1 {
       global projectfolder  "/Users/varnithakurli/Dropbox/Revenue_diversification_climatechange"
   }

   if $user == 2 {
       global projectfolder "C:/Users/WB538005/Dropbox/Rwanda Feeder Roads/data/admin/Establishment_census_data/creating_dataset"
   }
  
	
	
	 * Project folder globals
   * ---------------------

   global MergedData         "$projectfolder/MergedData"
