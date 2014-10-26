## This R script processes the UCI HAR Dateset
## The process includes:
## 1. The train dataset and the test dataset (excluding raw data) are merged
## into one data frame "dataMerge".
## 2. The measurements on the mean and standard deviation for each measurement
## are extracted into another data frame "dataSet1" (this includes the features
## with mean() and std()).
## 3. Activity labels are properly assigned with descriptive names in "dataSet1"
## 4. feature names (i.e. variable names of the data frame "dataSet1") are
## replaced with descriptive names.
## 5. The average of each variable in "dataSet1" for each activity and each
## subject is calculated and stored in a new data frame "dataSet2". This data
## frame is printed in file "submit.txt"

# directories of data files
dirTrain <- "./UCI HAR Dataset/train"
dirTest <- "./UCI HAR Dataset/test"

# read in train dataset
x_train <- read.table(paste(dirTrain, "X_train.txt", sep="/"))
y_train <- read.table(paste(dirTrain, "y_train.txt", sep="/"), col.names = "activityLabels", colClasses = "factor")
subject_train <- read.table(paste(dirTrain, "subject_train.txt", sep="/"), col.names = "subjectID", colClasses = "integer")

# read in test dataset
x_test <- read.table(paste(dirTest, "X_test.txt", sep="/"))
y_test <- read.table(paste(dirTest, "y_test.txt", sep="/"), col.names = "activityLabels", colClasses = "factor")
subject_test <- read.table(paste(dirTest, "subject_test.txt", sep="/"), col.names = "subjectID", colClasses = "integer")

# read in feature names and activity labels
featureNames <- read.table("./UCI HAR Dataset/features.txt", col.names = c("featureIndex", "featureNames"))
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activityIndex", "activityLabels"))

# apply feature names to both train and test datasets
names(x_train) <- featureNames$featureNames
names(x_test) <- featureNames$featureNames

# add activity labels and subject IDs into both datasets and merge them
train <- cbind(x_train, subject_train, y_train)
test <- cbind(x_test, subject_test, y_test)
dataMerge <- rbind(train, test)

# extract mean() and std() related variables
dataSet1 <- dataMerge[, grepl("mean\\(\\)|std\\(\\)", featureNames$featureNames)]

# apply descriptive activity names
levels(dataSet1$activityLabels) <- activityLabels$activityLabels

# define string patterns and their corresponding replacements
pattern <- c("tBody", "tGravity", "Acc", "-", "mean\\(\\)", "std\\(\\)", "X", "Y", "Z", "Gyro", "Mag", "fBody|fBodyBody")
replacement <- c("timeDomainBody", "timeDomainGravity", "Accelerometer", "", "MeanValue", "StandardDeviation", "XAxis", "YAxis", "ZAxis", "Gyroscope", "Magnitude", "frequencyDomainBody")

# replace the original variable names with descriptive names
for (i in 1:length(pattern)) {
    names(dataSet1) <- gsub(pattern[i], replacement[i], names(dataSet1))
}

# calculate the average of each variable in "dataSet1" for each activity and 
# each subject
library(reshape2)
dataMelt <- melt(dataSet1, id = c("subjectID", "activityLabels"))
dataSet2 <- dcast(dataMelt, subjectID + activityLabels ~ variable, mean)

# modify variable names accordingly
names(dataSet2) <- gsub("time", "meanOfTime", names(dataSet2))
names(dataSet2) <- gsub("frequency", "meanOfFrequency", names(dataSet2))

# print dataSet2 into a text file
write.table(dataSet2, "./submit.txt", quote = F, row.name=F)