library(dplyr)

# This run_analysis_R script does the following in order:
# 1. Creates File Paths for each of the data files
# 2. Reads each file into its own table, and merged the related data sets
#   together.
# 3. Uses the 'activity_labels' dataset to replace the numeric values found in
#   the "Y" data sets with a more descriptive label.
# 4. Uses the 'features' data set in order to determine which columns of the 
#   'X' data sets correspond to Means or STDs. These are then selected using the
#   indices found within the 'features' data set, and the description associated
#    to that index within 'features' is saved for future use in labeling the col
#    of the final table.
# 5. Creates more descriptive variable/column names for the data set by 
#    utilizing the values stored previously from 'features' data set.
# 6. Takes this newly formed and newly named data to create a new tidy data set
#    that contains the average of each variable for each subject/activity 
#    combination.


# File Paths for the data files

activity_labels_file <- "./DSC/UCI HAR Dataset/activity_labels.txt"
features_file <- "./DSC/UCI HAR Dataset/features.txt"
x_test_file <- "./DSC/UCI HAR Dataset/test/X_test.txt"
y_test_file <- "./DSC/UCI HAR Dataset/test/Y_test.txt"
subject_test_file <- "./DSC/UCI HAR Dataset/test/subject_test.txt"
x_train_file <- "./DSC/UCI HAR Dataset/train/X_train.txt"
y_train_file <- "./DSC/UCI HAR Dataset/train/Y_train.txt"
subject_train_file <- "./DSC/UCI HAR Dataset/train/subject_train.txt"

# Read the data from the Files in the UCI HAR Dataset and Combine the related
# datasets together.

# Combine the two X Data Files into one dataset

x_train_data <- read.table(x_train_file)
x_test_data <- read.table(x_test_file)
x_data <- rbind(x_train_data, x_test_data)

# Combine the two Y Data Files into one dataset

y_train_data <- read.table(y_train_file)
y_test_data <- read.table(y_test_file)
y_data <- rbind(y_train_data, y_test_data)

# Combine the two Subject Files into one dataset

subject_train_data <- read.table(subject_train_file)
subject_test_data <- read.table(subject_test_file)
subject_data <- rbind(subject_train_data, subject_test_data)

# Read the Activity Label File and Read the Features file

activity_labels_data <- read.table(activity_labels_file)
features_data <- read.table(features_file)

# Match the values in activity_labels_data with the values in y_data.

matched_labels <- match(y_data[,1],activity_labels_data[,1])


# Use the Activity Labels Data to replace the data in the Y Data Files 
# with more descriptive data. This is saved as new value "y_data_labeled"

y_data_labeled <- activity_labels_data[matched_labels, 2]


# Since the second column in the features file contains the descriptive names, 
# we will select and save only this column for future use. This information 
# will serve as the column names for the x_data portion of the combined
# dataset.

features <- features_data[,2]


# Find the columns which contain any type of Mean or STD. These columns are 
# found within the features file, and thus we will search the features data 
# in order to find both the column indices and values for Mean and STD data.
# We use tolower() in order to account for case sensitivity in the values
# of features.

col_indices <- grep("mean|std", tolower(features))
col_values <- features[col_indices]

# Per Best Practices, Remove the special characters from the column valuse
col_values <- gsub("[,()-]", "", col_values)


# Use the col_indices to determine which data from x_data fits our criteria
# of being either a mean or std.

mean_std_x_data <- x_data[col_indices]

# Combining all of the Data Files (X,Y,Subject) to create one dataset to work 
# with. This uses the base subject_data, the y_data updated with activity
# labels, and the X_data that corresponds to Means and STDs only.

combined_data <- cbind(subject_data, y_data_labeled, mean_std_x_data)

# Use the column values found from features to label the columns of the
# combined data set appropriately. Also name the activity label and the
# subject data columns appropriately.

names(combined_data) <- c("Subject", "Activity", col_values)

# Grouping the output combined dataset by the activity label and the subject
# in order to make the dataset more tidy. This is then piped to the
# summarize_all funtion which is ran with argument mean in order to calculate
# the average of each of the data elements.

avg_comb_data <- combined_data %>% group_by(Subject,Activity) %>% 
    summarise_all(mean)

# Output the Tidy Data Set
avg_comb_data














