# statswales-reference-data
repository for ref data and associated code

# Adding tables to the postgres db
 In pgAdmin:

 Connect to the db (details of how to do so are on Azure)

 Run the create table code in the 'Query tool' (changing 'table_name' to the relevant table), it may be necessary to adjust the list of fields to match those in the source
 In the PSQL tool, run the following: '\copy table_name FROM 'G:/StatsWales/table_name.csv' WITH DELIMITER ',' CSV HEADER' adjusting the table name and source directory as necessary, to load the data into the newly created table

# Creating the time based tables
 The R script can be run in Rstudio or in the R terminal.

 In Rstudio, just open the script, then Ctrl+A to select all and hit run (Ctrl+Enter)

 In command line (cmd) navigate to R's bin directory (using 'setwd("C:/R/R-4.3.3/bin")'), adjust details of the directory as necessary
 Then run 'Rscript "C:/Users/owain/Documents/SW_ref_data.R" "G:/StatsWales/"' Adjusting the code directory and the output directory as necessary




 

