library(dplyr)

GetAndCleanSets <- function (directory)
{
  activities <- read.table(paste(directory,"/activity_labels.txt",sep=""),as.is = TRUE)
  activities <- unlist(activities$V2)
  
  features <- read.table(paste(directory,"/features.txt",sep=""),as.is = TRUE)
  features <- unlist(features$V2)
  features <- make.unique(features)
  
  test_data <- read.table(paste(directory,"/test/X_test.txt",sep=""))
  names(test_data) <- features
  test_data <- select(test_data,matches("-(mean|std)\\(\\)\\-"))
  
  subj_test <- read.table(paste(directory,"/test/subject_test.txt",sep=""))
  test_data["subject"] <- NA
  test_data["subject"] <- subj_test$V1
  
  activ_test <- read.table(paste(directory,"/test/y_test.txt",sep=""))
  test_data["activity"] <- NA
  test_data["activity"] <- activ_test$V1
  
  train_data <- read.table(paste(directory,"/train/X_train.txt",sep=""))
  names(train_data) <- features
  train_data <- select(train_data,matches("-(mean|std)\\(\\)\\-"))
  
  subj_train <- read.table(paste(directory,"/train/subject_train.txt",sep=""))
  train_data["subject"] <- NA
  train_data["subject"] <- subj_train$V1
  
  activ_train <- read.table(paste(directory,"/train/y_train.txt",sep=""))
  train_data["activity"] <- NA
  train_data["activity"] <- activ_train$V1
  
  data <- rbind(train_data,test_data)
  
  data$activity <- factor(data$activity)
  levels(data$activity) <- activities
  
  data
}
