# CODEBOOK

This codebook provides a description of the different data, variables, and 
transformations used in the R Script: run_analysis.R

## Data / File Names

 - activity_labels_file: File containing labels for the different activities found in the data (activity_labels.txt)
 - features_file: File containing the names of the different features (features.txt)
 - x_test_file: File containing test data (x_test.txt)
 - y_test_file: File containing numeric test labels (y_test.txt)
 - subject_test_file: File containing the numbers for subjects observed in test (subject_test.txt).
 - x_train_file: File containing training data (x_train.txt)
 - y_train_file: File containing numeric training labels (y_train.txt)
 - subject_train_file: File containing the numbers for subjects observed in training (subject_train.txt)

## Transformations and Variables in R Script
 - x_train_data: Table read from x_train_file
 - x_test_data: Table read from x_test_file
 - x_data: The combination via rbind of the two x data tables.
 - y_train_data: Table read from y_train_file
 - y_test_data: Table read from y_test_file
 - y_data: The combination via rbind of the two y data files.
 - subject_train_data: Table read from subject_train_file
 - subject_test_data: Table read from subject_test_file
 - subject_data: The combination via rbind of the two subject data files.
 - activity_label_data: Table read from activity_labels_file
 - features_data: Table read from features_file
 - matched_labels: Vector of integers associated with the matching of the numeric labels found in the y_data with the paired description in activity labels
 - y_data_labeled: Updated y_data with the numeric label replaced by paired description from activity labels
 - features: Subset of features_data. Contains only the 2nd column which has the description of the feature.
 - col_indices: Uses grep to find values in features that contain either "mean" or "std". Vector of integers as indices of features.
 - tolower(features): Used in col_indices to handle case sensitivity in the grep function's lookup.
 - col_names: The value found at the associated index in features in col_indices
 - mean_std_x_data: The subset of x_data containing mean or std measurements. Found with col_indices
 - combined_data: The combination via cbind of the subject_data, y_data_labeled, and mean_std_x_data.
 - names(combined_data): Updated the column names of the new data set to be "Subject" for subject_data row, "Activity" for y_data_labeled row, and col_names for the mean_std_x_data.
 - avg_comb_data: The result of piping combined_data with group_by of 'Activity' and 'Subject'and piping that to summarise_all(mean) to obtain the tidy data set of the averages of each Activity/Subject combination (180 rows)
 
## Variables in Tidy Data Set Output
 - Subject: The number associated for each subject (1-10 subjects).
 - Activity: One of 6 Activities that each subject was observed doing. (Laying,Sitting, Standing, Walking, Walking Upstairs, Walking Downstairs)
 - Mean/STD variables: Different columns from the original X_test/X_train data sets that were pulled due to them containing measurements of Mean or STD.