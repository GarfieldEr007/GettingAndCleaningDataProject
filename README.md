# UCI HAR Dataset Preprocessing
#### Coursework project of Getting and Cleaning Data

This project does some preprocessing to the Human Activity Recognition Using Smartphones Data Set. The description of this dataset and its download link can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones .

## Objectives

This project does the following preprocessing to the dataset:

1. The train dataset and the test dataset (excluding raw data) are merged into one data frame `dataMerge`.
2. The measurements on the mean and standard deviation for each measurement are extracted into another data frame `dataSet1` (this includes the features with mean() and std()).
3. Activity labels are properly assigned with descriptive names in `dataSet1`
4. feature names (i.e. variable names of the data frame `dataSet1`) are replaced with descriptive names.
5. The average of each variable in `dataSet1` for each activity and each subject is calculated and stored in a new data frame `dataSet2`. This data frame is printed in file `submit.txt`.

## Description of files

- **run_analysis.r**        the R script file which does the aformentioned preprocessing
- **submit.txt**        the processed dataset, details please refer to CodeBook.md
- **CodeBook.md**       a description of the original dataset, the processed dataset and the processing itself

## How to use

### Before running the R script

Make sure the following items have been done before running the R script:

1. the data file is downloaded and uncompressed
2. the uncompressed data folder **UCI HAR Dataset** should be put in the working directory together with the R script file
3. do not change anything in the data folder
4. the R package `reshape2` should be installed

### Description of important data frames

- `dataMerge`       this data frame contains all the train data and test data including subject IDs and activity labels
- `dataSet1`        this data frame is a subset of `dataMerge` which contains only the measurements related to mean() and std()
- `dataSet2`        this data frame is the final processed data frame which contains the mean of each measurement variable in `dataSet1` for each activity and each subject, details can be found in the codebook