###Final project
filename <- "FinalProject3.zip"

# Saving
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Unzip
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

##Data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","function"))
activities_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("num", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$function.)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "num")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$function.)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "num")

##STEP 1. MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATASET
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
dataset <- cbind(subject, Y, X)

##STEP 2. EXTRACTS ONLY THE MEASUREMENT ON THE MEAN AND SD DEV. FOR EACH MEASUREMENT
library(tidyverse)
tidydata <- dataset %>% select(subject, num, contains("mean"), contains("std"))

##STEP 3. USES DECRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATASET
tidydata$num <- activities_labels[tidydata$num, 2]

##STEP 4. LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
names(tidydata)[2] = "activity"
names(tidydata)<-gsub("Acc", "Accelerometer", names(tidydata))
names(tidydata)<-gsub("Gyro", "Gyroscope", names(tidydata))
names(tidydata)<-gsub("BodyBody", "Body", names(tidydata))
names(tidydata)<-gsub("Mag", "Magnitude", names(tidydata))
names(tidydata)<-gsub("^t", "Time", names(tidydata))
names(tidydata)<-gsub("^f", "Frequency", names(tidydata))
names(tidydata)<-gsub("tBody", "TimeBody", names(tidydata))
names(tidydata)<-gsub("-mean()", "Mean", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-std()", "STD", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-freq()", "Frequency", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("angle", "Angle", names(tidydata))
names(tidydata)<-gsub("gravity", "Gravity", names(tidydata))

##CREATE A SECOND TIDY DATA SET WITH AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY
##AND SUBJECT
submission <- tidydata %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(submission, "SubmissionData.txt", row.name=FALSE)

##VARIABLE NAMES
str(submission)
submission
