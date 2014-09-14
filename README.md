# Objective - run_analysis.R#
You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set. 
1. Extracts only the measurements on the mean and standard deviation for each measurement. 
1. Uses descriptive activity names to name the activities in the data set. 
1. Appropriately labels the data set with descriptive variable names. 
1. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# How it works #

1. Create the test file by combing the test set, test labels and subject information.
2. Create the training file by combing the training set, training labels and subject information.
3. Merge the test and training files.
4. Filter for mean and standard deviation in Features file.
5. Update Merged file to contain only mean and standard deviation measurements along with subject and activity info.
6. Add user friendly column names.
7. Substitute activity label for activity number.
8. Create a tidy dataset with the avg of each variable for each activity and each subject.
