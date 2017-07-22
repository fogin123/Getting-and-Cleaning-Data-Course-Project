# Getting and clean data from data sets of accelerometer and gyroscope studies

# initializing library "dplyr" for working with data sets
library(dplyr)

# writing function "GetAndCleanSets" doing next:
# 1. Collect all nessesary data in variable "data"
# 2. Edit and renaming it
# 3. Make "tidy_data" massive to consolidate global data and writing it in "tidy_data.txt" file 
# 4. Return tidy_data
# Incoming variable for function "directory" is character vector that describing global directory of studies files

GetAndCleanSets <- function (directory)
{
  #getting information of activitites to convert it as factors later
  activities <- read.table(paste(directory,"/activity_labels.txt",sep=""),as.is = TRUE)
  activities <- unlist(activities$V2)
  
  #getting information of labels for global studies
  features <- read.table(paste(directory,"/features.txt",sep=""),as.is = TRUE)
  features <- unlist(features$V2)
  #make unique names for labels for correct work of "select" function
  features <- make.unique(features)
  
  #getting data from "test" directory
  test_data <- read.table(paste(directory,"/test/X_test.txt",sep=""))
  names(test_data) <- features
  #selecting only mean and std variables
  test_data <- select(test_data,matches("-(mean|std)\\(\\)\\-"))
  
  #adding corresponding information about subjects and activities for primary data
  subj_test <- read.table(paste(directory,"/test/subject_test.txt",sep=""))
  test_data["subject"] <- NA
  test_data["subject"] <- subj_test$V1
  
  activ_test <- read.table(paste(directory,"/test/y_test.txt",sep=""))
  test_data["activity"] <- NA
  test_data["activity"] <- activ_test$V1
  
  #doing same thing for "train" directory
  train_data <- read.table(paste(directory,"/train/X_train.txt",sep=""))
  names(train_data) <- features
  train_data <- select(train_data,matches("-(mean|std)\\(\\)\\-"))
  
  subj_train <- read.table(paste(directory,"/train/subject_train.txt",sep=""))
  train_data["subject"] <- NA
  train_data["subject"] <- subj_train$V1
  
  activ_train <- read.table(paste(directory,"/train/y_train.txt",sep=""))
  train_data["activity"] <- NA
  train_data["activity"] <- activ_train$V1
  
  #binding global data from "test" and "train" to "data" variable
  data <- rbind(train_data,test_data)
  
  #converting information about activities from indexes to factors
  data$activity <- factor(data$activity)
  levels(data$activity) <- activities
  
  #correcting names of "data" variable - changing them to lower index, change character "-" to "_", deleting "()"
  names(data) <- tolower(names(data))
  names(data) <- gsub("-","_",names(data))
  names(data) <- gsub("\\(\\)","",names(data))
  
  #making tidy data with the average of each variable for each activity and each subject
  tidy_data <- group_by(data,subject,activity)
  tidy_data <- tidy_data %>% summarise_all(funs(mean))
  
  #write tidy data into file "tidy_data.txt" in global directory
  write.table(tidy_data,paste(fileURL,"/tidy_data.txt",sep=""),row.names = FALSE)
  
  tidy_data
}
