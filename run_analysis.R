library(plyr)
library(reshape2)

# Create the test file by combing the test set, test labels and subject information
TestFile = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
TestFile[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
TestFile[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

# Create the training file by combing the training set, training labels and subject information
TrainingFile = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
TrainingFile[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
TrainingFile[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

# Merge the test and training files
MergedFile = rbind(TestFile, TrainingFile)

# Filter for mean and standard deviation in Features file
FeatureFile = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
MeanStdVals = grep("mean|std", FeatureFile[,2])
FeatureFile = FeatureFile[MeanStdVals,]


# Update Merged file to contain only mean and standard deviation measurements along with subject and activity info.
SelectedCols = c(562, 563, MeanStdVals)
MergedFile = MergedFile[, SelectedCols]

# Add user friendly column names
colnames(MergedFile) = c("activity", "subject", as.character(FeatureFile$V2))

# Substitute activity label for activity number
activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
colnames(activityLabels) = c("activity", "activityDesc")
MergedFile = join(MergedFile, activityLabels, by = "activity")
MergedFile = MergedFile[, c(2, 1, 82, 3:81)]


# Tidy dataset with the avg of each variable for each activity and each subject
MeltData <- melt(MergedFile, id=c("subject", "activity", "activityDesc"))
TidyData <- dcast(MeltData, subject + activity + activityDesc ~ variable, mean)
write.table(TidyData, file="./tidy_data.txt", row.names=FALSE)
