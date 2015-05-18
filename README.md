# getdata-014-project
The source code for the project of coursera course get and cleaning data

The script is used to create tidy data from the Samsung data set.
To start, the working directory shall be set to the data set folder.

1. Merges the training and the test sets to create one data set.
This part includes data read-in and construct a data frame to contain all data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
The original data set col names contains duplicates, and these duplicates don’t contain the information we need. So data[,unique(names(data))] function subset unique variables columns. Then select() function selects the variables containing mean() and std().
   
3. Uses descriptive activity names to name the activities in the data set
Activity label was read in and applied to the activity column of data set with mutate function.

4. Appropriately labels the data set with descriptive variable names. 
Variable names were already set in step 1 (read_data function). Here just display the names of the variables.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
First the dataset was group by subject and activity. And summarise_each function was applied to calculate the mean function of each variable. %>% is a chaining operator.

For data tidying, since the data set contains two different groups, one with X, Y, Z information, and one without axis information. Thus, original data set was subsetted into two groups. And for each group, all columns except subject and activity were gathered and then separated by “-“ into column c(“feature”, “type”, “axis”). For group without axis information, additional axis column with NAs was added. Then both groups were combined together to obtain the tidy data set.

6. Write the data set with write.table() function.