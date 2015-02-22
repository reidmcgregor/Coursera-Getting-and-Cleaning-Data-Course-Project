#README

##Getting and Cleaning Data - Course Project 

This README file explains how the run_analysis.R script works

###Setting up your working directory

This R script assumes that you have already downloaded the source zip data, which is available at the <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">University of California Irvine Machine Learning Repository site</a>

Once downloaded the R script file should be stored in the same directory as the UCI HAR Dataset folder.

###Library dependencies

The dplyr library is required in order to run the script successfully. In order to install this package run install.packages("dplyr") in R or RStudio.

###Steps of the R script

- The activity_labels.txt and features.txt are read into the script.
- The test and training datasets are read into the script.
- The test and training datasets are combined into one data frame.
- The features file is used to apply column headers to the variables
- The grepl command is used to filter the data for just the mean and standard deviation columns that are required in the output
- The activity_labels are merged to include the more descriptive activityType
- The remaining column names are updated to make them more descriptive
- The data is aggregated in order to calculate an average mean and standard deviation reading for each subject doing each activity
- A tidy.txt file is created with 180 observations containing 71 variables

