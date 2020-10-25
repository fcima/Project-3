This Codebook contains the description of variables and calculations performed as described in the instructions

1. Download and open the database called UCI HAR Dataset. It contains (assigned variable names in paranthesis):
  - features.txt = from the accelerometer and gyroscope (features)
  - activitiy_labels.txt = activies measured (activities_labels)
  - test/subject_test.txt = data of subjects (subject_test)
  - test/X_test.txt = features recorded (x_test)
  - test/y_test.txt = data of activities (y_test)
  - test/subject_train.txt = train data of subjects (subject_train)
  - test/X_train.txt = features of train data (x_train)
  - test/y_train.txt = train data of activities (y_train)

2. Merges the training and the test sets to create one data set.
  - X <- combines x_train and x_test using rbind()
  - Y <- combines y_train and y_test using rbind ()
  - subject <- combines subject_train and subject_test using rbind()
  - dataset <- combines X, Y and subject using cbind()

3. Extracts only the measurements on the mean and standard deviation for each measurement.
  - in a new set called tidydata, SD and mean are extracted from subject data contained in dataset using tidyverse

4. Uses descriptive activity names to name the activities in the data set
  - numbers contained in the num column of tidydata are replaced by activity data from the activities_labels variable

5. Appropriately labels the data set with descriptive variable names.
  - columns in tidydata were renamed as follows:
   "Acc" to "Accelerometer"
  "Gyro" to "Gyroscope""
  "BodyBody" to "Body"
  "Mag" to "Magnitude"
  "^t" to "Time"
  "^f" to "Frequency"
  "tBody" to "TimeBody"
  "-mean()" to "Mean"
  "-std()" to "STD"
  "-freq()" to "Frequency"
  "angle" to "Angle"
  "gravity" to "Gravity"


6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  - submission summarizes tidydata
  - Submission is exported as SubmissionData.txt

