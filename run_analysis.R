## This is the original code for get and clean data project.
## Author: Yi Zhou
## This file reads in and cleans the data set from Human Activity Recognition Using Smartphones Dataset.

## The current working directory is set to be the data set folder.


## Part 1: Merges the training and the test sets to create one data set.

## Read in data
features <- read.table("features.txt", stringsAsFactors = F)  ## col names for data set

## Read in data function for read in test and training data separately
## path: the data set to read in, "test" or "train"
## Return: return a data frame with all the data in that group
read_data <- function(path) {
    setwd(paste0("./", path))  ## set working directory to relative folder
    subject <- read.table(paste0("subject_", path, ".txt"), stringsAsFactors = F, col.names = "subject")  ## subject varibale
    X <- read.table(paste0("X_", path, ".txt"), stringsAsFactors = F)  ## X variables
    names(X) <- features$V2  ## set col names for each variable
    y <- read.table(paste0("y_", path, ".txt"), stringsAsFactors = F, col.names = "activity")  ## y varibales
    data <- cbind(subject, X, y)
    setwd("..")  ## reset the working directory to parent
    return(data)
}
## Read in data using the read_data function
test_data <- read_data("test")
train_data <- read_data("train")
## Merge the data 
data <- rbind(test_data, train_data)  ## the final dataset


## Part 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

require(dplyr)
## the names of data contains duplicates and the duplicates are not needed variables
## select varibles contain mean(), std()
data2 <- select(data[,unique(names(data))], subject, activity, contains("mean()"), contains("std()"))



## Part 3: Uses descriptive activity names to name the activities in the data set

## Read in activity_labels
labels <- read.table("activity_labels.txt")

## Substitute function to change the labels
label_sub <- function(x) {labels$V2[x]}
data3 <- mutate(data2, activity = label_sub(activity))


## Part 4: Appropriately labels the data set with descriptive variable names. 
## Varibale names are already stored with feature names
names(data3)


## Part 5: From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

data5 <- group_by(data3, subject, activity) %>% summarise_each(funs(mean))

## The following is to tide the data in data5
## There are two types of data in the data set, separate them by XYZ
data6<- select(data5, subject, activity, contains("X", ignore.case = F), contains("Y", ignore.case = F),contains("Z", ignore.case = F))
data7<- select(data5,-contains("X", ignore.case = F), -contains("Y", ignore.case = F), -contains("Z", ignore.case = F))

## organize by X,Y,Z
data6 <- data6 %>% gather(index, value, -subject, -activity) 
## separate into variable name, calculation type, axis
data6 <- separate(data6, index, into = c("variable", "type", "axis"), sep = "[-]")

## tide the data without axis infomation
data7 <- data7 %>% gather(index, value, -subject, -activity) %>% separate(index, into = c("variable", "type"), sep = "[-]")
## add additional column of axis to NA
data7 <- mutate(data7, axis = NA)

## merge these two data set together
data_out <- rbind(data6, data7)


## write the data set into a txt file
write.table(data_out, "output.txt", row.name=FALSE)
