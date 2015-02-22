################################################################

## Title: Coursera - Getting and Cleaning Data Course Project
## Author: Reid McGregor

## You should create one R script called run_analysis.R that does the following.
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each 
##    measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.

################################################################

## Set working directory to where UCI HAR Dataset was saved.
## This reduces having to go up and down the folder structure
setwd('./UCI HAR Dataset')

## Load required libraries
library(dplyr)

################################################################
## STEP 1: Merge the train and test data sets to create one data set
################################################################

## Read the data from root folder
activity <- read.table('./activity_labels.txt')
features <- read.table('./features.txt')

## Read the data from the test folder and combine into one test table
subjectTest <- read.table('./test/subject_test.txt', header = FALSE) # Subject data read from subject_test.txt [dim = 2947 x 1]
xTest <- read.table('./test/X_test.txt', header = FALSE) # Data read from X_text.txt [dim = 2947 x 561]
yTest <- read.table('./test/y_test.txt', header = FALSE) # Data read from y_test [dim = 2947 x 1]

## Read the data from the train folder and merge into one training table
subjectTrain <- read.table('./train/subject_train.txt', header = FALSE) # Subject data read from subject_train.txt [dim = 7352 x 1]
xTrain <- read.table('./train/X_train.txt', header = FALSE) # Data read from X_train.txt [dim = 7352 x 561]
yTrain <- read.table('./train/y_train.txt', header = FALSE) # Data read from y_train.txt [dim = 7352 x 1]

## Create combined versions of the subject, x, and y tables
subjectCombined <- rbind(subjectTest, subjectTrain)
xCombined <- rbind(xTest, xTrain)
yCombined <- rbind(yTest, yTrain)

## Add column headers to the combined tables
colnames(subjectCombined) = "subjectID" # Only one column called subjectID
colnames(xCombined) = features[,2] # 561 columns based on features.txt
colnames(yCombined) = "activityID" # Only one column called activityID
colnames(activity) = c('activityID', 'activity') # 2 columns

## Create the final data frame
final <- cbind(subjectCombined, xCombined, yCombined)

################################################################
## STEP 2: Extracts only the measurements on the mean and standard deviation
##         for each measurement.
################################################################

## Create a list of header names in order to filter for mean and stdev columns
headers = names(final)

## Create column filter using grepl command
colFilter = (grepl("-mean\\(\\)", headers) | grepl("-std\\(\\)", headers) | grepl("subjectID", headers) | grepl("activityID", headers))

## Filter the dataset for just those columns in the column filter
final <- final[colFilter == TRUE]

################################################################
## Step 3: Uses descriptive activity names to name the activities in the data set
################################################################

## Required merge command on the data frame to bring in the activity type
final <- merge(final, activity, by = 'activityID', all.x = TRUE)
# all.x adds activityType column to the dataframe

################################################################
## Step 4: Appropriately labels the data set with descriptive variable names.
################################################################

## In order to minimize the amount of code, and repitition required
## we want to create a set of renaming rules. We can then loop through
## each column header one at a time and check to see if any of the 
## renaming rules apply. If they do, the variable name is updated.

for (i in 1:ncol(final)) { # start of the for loop
        names(final)[i] = gsub("\\()", "", names(final)[i]) # removes the parentheses ()
        names(final)[i] = gsub("^t", "time", names(final)[i]) # changes t to time
        names(final)[i] = gsub("^f", "frequency", names(final)[i]) # changes f to frequency
        names(final)[i] = gsub("Acc", "Acceleration", names(final)[i]) # changes Acc to Acceleration
        names(final)[i] = gsub("mean", "Mean", names(final)[i]) # changes mean to Mean
        names(final)[i] = gsub("std", "StDev", names(final)[i]) # changes std to StDev
        names(final)[i] = gsub("Gyro", "Gyroscope", names(final)[i]) # changes Gyro to Gyroscope
        names(final)[i] = gsub("Mag", "Magnitude", names(final)[i]) # changes Mag to Magnitude
        names(final)[i] = gsub("BodyBody", "Body", names(final)[i]) # changes BodyBody to Body
}

## Update the column names
colnames(final) = names(final)

################################################################
## Step 5: From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
################################################################

finaladj = final[,names(final) != 'activity']

tidy <- aggregate(finaladj[,names(finaladj)], by = list (finaladj$activityID, finaladj$subjectID), FUN = mean)
tidy <- merge(tidy, activity, by = 'activityID', all.x = TRUE)
tidy <- tidy[c(1, 4, 71, 5:70, 2, 3)]
tidy <- arrange(tidy, subjectID, activityID)

write.table(tidy, './tidy.txt', row.name = FALSE, sep = '\t')