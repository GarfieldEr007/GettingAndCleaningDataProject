## Code Book

### The original data set

The description of the original data set can be found in the **README.txt** and the **features_info.txt** files in the original data folder (not this repo). However, there are some flaws in those files. For example, the unit of each variable is not clearly stated and the variable names have poor readability although it is explained in those files what each abbreviation stands for. The second problem is resolved in the processed data set but I am not sure about the units of variables. I would say they follow the units of the original variables.

### The processed data set

The processed data set has 180 observations and 68 variables. The observations are based on 30 subjects and each of them has 6 activites including *WALKING*, *WALKING UPSTAIRS*, *WALKING DOWNSTAIRS*, *SITTING*, *STANDING* and *LAYING*. The IDs of subjects and the indicators of activities are stored in variables `subjectID` and `activityLabels`. The remaining 66 variables are mean values of the mean() and std() related features in the original dataset for each activity and each subject. The name of each variable can be interpreted using the following rules:

- the **meanOf** at the beginning of each variable means this is the mean of the original data variable for each activity and each subject
- **TimeDomain** means the variable is obtained from the orignal time domain measurements
- **FrequencyDomain** means that the variable is transformed from time domain via Fourier transform
- **BodyAccelerometer** stands for the acceleration experienced by human body excluding the effect of gravity
- **GravityAccelerometer** stands for the gravity acceleration
- **BodyGyroscope** stands for the angular velocity of human body captured by the gyroscope
- **Jerk** stands for Jerk signals
- **MeanValue** and **StandardDeviation** simply mean arithmetic "mean value" and "standard deviation", but it should be noted that it is not clearly explained in the original dataset what these two values are calculated over
- **XAxis**, **YAxis** and **ZAxis** mean the data were captured in X, Y, or Z direction
- **Magnitude** is the magnitude of these 3D signals calculated using Euclidean norm

## Study Design

1. the corresponding suject IDs and activity labels of the train dataset and the test dataset are first appended at the end of them respectively using `cbind`;
2. the test dataset is appended at the end of the train dataset using `rbind`, creating a new data frame `dataMerge`;
3. the data variables whose names contain **mean()** or **std()** are extracted to form a new data frame `dataSet1`;
4. activity labels in `dataSet1` are replaced with descriptive names. Note that I use the simplest way `levels` to realise this, therefore, the order of names fed into `levels` must be consistent with the original levels;
5. variable names in `dataSet1` are replaced with descriptive names using `gsub`;
6. the mean of each variable in `dataSet1` for each activity and each subject are calculated using the `melt` and `dcast` functions in the package `reshape2` and the resultant data is stored in `dataSet2`;
7. names of variables in `dataSet2` are modified to show that they are the **mean**;
8. `dataSet2` is printed in a text file **submit.txt**