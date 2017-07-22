# Getting and Cleaning Data Course Project

###### Getting and clean data from data sets of accelerometer and gyroscope studies


###### The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

###### The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


R-script with one function "GetAndCleanSets" doing next:
* 1. Collect all nessesary data in variable "data"
* 2. Edit and renaming it
* 3. Make "tidy_data" massive to consolidate global data and writing it in "tidy_data.txt" file 
* 4. Return tidy_data

Incoming variable for function "directory" is character vector that describing global directory of studies files. File "tidy_data.txt" is making in the same directory.

Originally task for this r-script was:

*Merges the training and the test sets to create one data set.
*Extracts only the measurements on the mean and standard deviation for each measurement.
*Uses descriptive activity names to name the activities in the data set
*Appropriately labels the data set with descriptive variable names.
*From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The repository consist of the next files:
* README.md
* Codebook.md - describes the variables, the data, and transformations that was performed to clean up the data
* run_analysis.R - basic r-script for collecting data.