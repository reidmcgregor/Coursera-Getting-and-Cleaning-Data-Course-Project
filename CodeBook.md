#CodeBook

##Getting and Cleaning Data - Course Project 

###Description of the raw data

The raw data used in this analysis was obtained from the University of California Irvine Machine Learning Repository. The researchers carried out experiements that captured 3-axial accelerometer and gyroscope data for 30 participants as they completed 6 different activities while wearing a Samsung Galaxy S II smartphone.

The participants in the experiments were broken into two different groups: a test group, and a training group. A total of 561 different variables were collected while participants were:

- Walking
- Walking upstairs
- Walking downstairs
- Sitting
- Standing
- Laying down

For a more detailed description visit the UCI Machine Learning Site <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">here</a>

###How the data was processed

The intent of this analysis was to process the data to create a second, independent tidy data set with the average of each mean and standard deviation variable for each activity and each subject.

In order to accomplish this, an R script called run_analysis.R was created, which:

- 1. Merges the training and the test sets to create one data set.
- 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
- 3. Uses descriptive activity names to name the activities in the data set
- 4. Appropriately labels the data set with descriptive variable names. 
- 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###What is the final output

The final output of this script is a tiny.txt data file that contains average acceleration and angular velocity measurements for each of the 30 participants as they did the six activities listed above.
