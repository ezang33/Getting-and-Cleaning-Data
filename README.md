
# README

## General Information and Background

This README contains information about the R Script used for cleaning a data set
containing data collected from accelerometers from the Samsung Galaxy S phone.

A link to the full study description can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

A link to the data used for the project can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Run_Analysis.R

This is the script that takes the original data that was extracted from the 
previously mentioned .zip, and transforms it into another tidy data set per the
instructions of the exercise. In order for the script to work properly, the data
must have already be downloaded and unzipped/extracted into your working
directory. The script makes use of dplyr library.

The script does the following steps in order:

 1. Creates File Paths for each of the data files
 2. Reads each file into its own table, and merged the related data sets
   together.
 3. Uses the 'activity_labels' dataset to replace the numeric values found in
   the "Y" data sets with a more descriptive label.
 4. Uses the 'features' data set in order to determine which columns of the 
   'X' data sets correspond to Means or STDs. These are then selected using the
   indices found within the 'features' data set, and the description associated
    to that index within 'features' is saved for future use in labeling the col
    of the final table.
 5. Creates more descriptive variable/column names for the data set by 
    utilizing the values stored previously from 'features' data set.
 6. Takes this newly formed and newly named data to create a new tidy data set
    that contains the average of each variable for each subject/activity 
    combination.





