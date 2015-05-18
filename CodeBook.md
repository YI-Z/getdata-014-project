This is the code book describes the variables and the data of final data set.

Original data was read in from both training and test data set. Only the values with mean() and std() functions were extracted. Data with axis information was gather together and separated into feature column, calculation type column, axis column and value column. And data without axis information was tided similarly with axis column set to NA.

The data set contains 11880 observations with 6 variables. And the variables are as follows:

subject: identifier of the volunteer subject
activity: activity type of this record
feature: the feature of measurement, each option is listed below.
type: the calculation method/type, mean() is the mean value and std() is the standard deviation
axis: the direction of signal recorded, can be X, Y or Z. Measurements without axis information is recorded as NA.
value: the value of measurement

Feature list:
tBodyAcc
tGravityAcc
tBodyAccJerk
tBodyGyro
tBodyGyroJerk
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc
fBodyAccJerk
fBodyGyro
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag