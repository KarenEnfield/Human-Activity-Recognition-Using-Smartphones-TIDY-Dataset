
# run_analysis.R      
# Getting and Cleaning Data Course Project
# Final Course Project
# By Karen Enfield
#
# The final assignment has 5 parts:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Step 1 
# Merge the training and the test sets to create one data set.

#   Step 1a: Get the feature columns to name the columns of the training and testing measurements
#     and use to create the test and training tables, then combine the tables

#   Get column names from features file './UCI Har Dataset/features.txt'
featureColumns = read.table("./UCI Har Dataset/features.txt", col.names = c("Number","Name"))

#   Get training data 'train/X_train.txt' and create a table of data with named columns.
trainData <- read.table("./UCI Har Dataset/train/X_train.txt",col.names = featureColumns$Name, check.names = FALSE)

#   Get test data 'test/X_test.txt' and create a table of data with named columns.
testData <- read.table("./UCI Har Dataset/test/X_test.txt", col.names = featureColumns$Name, check.names = FALSE)

#   Bind the two data sets
allMeasurements <- rbind(trainData, testData)


#   Step 1b: Get and merge all of the test and training activity

#   Get training data activity labels 'train/y_train.txt'.
trainData <- read.table("./UCI Har Dataset/train/y_train.txt", col.names=c("Activity"))

#   Get test data activity labels 'test/y_test.txt'.
testData <- read.table("./UCI Har Dataset/test/y_test.txt", col.names=c("Activity"))

#   Bind the two data sets
allActivity <- rbind(trainData, testData)


#   Step 1c Subject data needs to be read from test and training areas and combined

#   Get training subjects 'train/subject_train.txt': Test labels.
trainData <- read.table("./UCI Har Dataset/train/subject_train.txt", col.names=c("Subject"))

#   Get testing subjects 'test/subject_test.txt': Test labels.
testData <- read.table("./UCI Har Dataset/test/subject_test.txt", col.names = c("Subject"))

#   Bind the two data sets into one Subjects table
allSubjects <- rbind(trainData, testData)


rm(testData) # remove temporary data sets
rm(trainData) # remove temporary data sets

# Combine all the subject, activity, and measurement data into one data source "allData"
allData <- cbind(allSubjects,allActivity,allMeasurements)


# Step 2 
# Extract only the mean and standard deviation columns from the data set.

# Extract all the  mean and standard deviation column numbers 
# by searching for "-mean()" or "-std()" in their column names 
# From the featureColumns created in Step 1, search in featureColumns$Name
# There should be 66 extracted feature columns of means and standard deviations
meanStdCols <- featureColumns[ grepl("-mean\\(\\)",featureColumns$Name) | grepl("-std\\(\\)",featureColumns$Name),c("Number")]
# Add columns 1 and 2 (Subject and Activity), increment all other rows by 2 to adjust,
# to create a new list of columns to be extracted from "allData", of 68 columns.
subsetDataCols <- c(1,2,meanStdCols +2) # Keep Subject and Activities and adjust column numbers

# Create the subset of "allData", the master list, by extracting a subset of
# the desired mean and standard deviation columns above, using subsetDataCols.
# There will be 10,299 rows and 68 columns.
subsetData <- allData[,subsetDataCols] 


# Step 3
# Use descriptive activity names to name the activities in the data set

#   Get the activity names from the file:."/UCI Har Dataset/activity_labels.txt"
activityLabels <- read.table("./UCI Har Dataset/activity_labels.txt")

#   Replace all Activity labels with descriptive activity names:

# newActivty is all the activity numbers replaced by corresponding activity labels 
newActivity <- apply(allActivity,1,function(x,y) y[x],activityLabels$V2) #Remember allActiviyNames for later
# Delete the old activities
subsetData$Activity = NULL
# Replace with the new activities labels
library(tibble)
subsetData <- add_column(subsetData, Activity = newActivity , .after=1)


# Step 4: Appropriately label the data set with descriptive variable names.
library(memisc)

# Give a description to Subject and Activity columns
description(subsetData$Subject)<-"Subject ID number"
wording(subsetData$Subject)<-"Subjects being tested are each given an id number."
annotation(subsetData$Subject)["Remark"] <- "The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. "
description(subsetData$Activity)<-"Activity Type"
wording(subsetData$Activity)<-"Activity the subjects were performing while being measured."
annotation(subsetData$Activity)["Remark"]<-"Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz."

# Now lets create meaningful descriptions for all the mean and std columns 
# by parsing each measurement column name and making it more readable,
# and storing the new description with the column name in the data set.

# The information for obtaining detailed sensor descriptions can be found in
# the "Data Set Information" section at 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Initialize our find and replace string constants for searching in the features columns.
cFeatureFind <- c("tBodyAcc-",
           "tGravityAcc-",
           "tBodyAccJerk-",
           "tBodyGyro-",
           "tBodyGyroJerk-",
           "fBodyAcc-",
           "fBodyAccJerk-",
           "fBodyGyro-",
           "tBodyAccMag-",
           "tGravityAccMag-",
           "tBodyAccJerkMag-",
           "tBodyGyroMag-",
           "tBodyGyroJerkMag-",
           "fBodyAccMag-",
           "fBodyBodyAccJerkMag-",
           "fBodyBodyGyroMag-",
           "fBodyBodyGyroJerkMag-",
           "mean\\(\\)-",
           "std\\(\\)-",
           "mean\\(\\)",
           "std\\(\\)")

cFeatureReplace <- c(
  "Accelerometer Body Acceleration, 3-axial (Time)",
  "Accelerometer Gravity, 3-axial (Time)",
  "Accelerometer Angular Velocity, 3-axial (Time)",
  "Gyroscope Body Acceleration, 3-axial (Time)",
  "Gyroscope Angular Velocity, 3-axial (Time)",
  "Accelerometer Body Acceleration, 3-axial (Frequency)",
  "Accelerometer Angular Velocity, 3-axial (Frequency)",
  "Gyroscope Body Acceleration, 3-axial (Frequency)",
  "Accelerometer Body Acceleration, Filtered (Time)",
  "Accelerometer Gravity, Filtered (Time)",
  "Accelerometer Angular Velocity, Filtered (Time)",
  "Gyroscope Body Acceleration, Filtered (Time)",
  "Gyroscope Angular Velocity, Filtered (Time)",
  "Accelerometer Body Acceleration, Filtered (Frequency) ",
  "Accelerometer Angular Velocity, Filtered (Frequency) ",
  "Gyroscope Body Acceleration, Filtered (Frequency) ",
  "Gyroscope Anglar Velocity Filtered (Frequency)",
  ": Mean ",
  ": Standard Deviation ",
  ": Mean",
  ": Standard Deviation"
)


# Retrieve column names from featureColumns$Name that contain "-mean()" and "-std()".    
# There should be 66 entries
meanStdColNames <- featureColumns[ grepl("-mean\\(\\)",featureColumns$Name) | grepl("-std\\(\\)",featureColumns$Name),c("Name")]
# Make sure these are strings and not factors for our manipulation
meanStdColNames<-as.character(meanStdColNames)

# Create Description Strings, first initializing them with the original column names
descMeanStdColNames = as.character(meanStdColNames)

# Find and replace trying all entries cFeatureFind and cFeatureReplace for
# each description string
for (i in 1:length(cFeatureFind))
{
  descMeanStdColNames <- gsub(cFeatureFind[i],cFeatureReplace[i],descMeanStdColNames)
}

# No longer are we renaming the column names with the descriptions
# colnames(subsetData) <- c("Subject","Activity",descMeanStdColNames)

# Assign each description we have created, to it's column description. 
# optional wording and annotation may be added here as well.
for (i in 1:length(descMeanStdColNames))
{
     description(subsetData[[i+2]])<- descMeanStdColNames[i]
     wording(subsetData[[i+2]])<-"Sensor measurement features are normalized and bounded within [-1,1]"
     if (grepl("Accelerometer",descMeanStdColNames[i]))
     {
       if(grepl("Gravity",descMeanStdColNames[i]))
       {
         annotation(subsetData[[i+2]])["Remark"]<-"The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. To account for low frequency gravitational force, a filter with 0.3 Hz cutoff frequency was used"
       }
       else
        annotation(subsetData[[i+2]])["Remark"]<-"The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. "
     }
     else
      annotation(subsetData[[i+2]])["Remark"]<-"The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). "
}


# Step 5
# From the subset data subsetData in step 4, create a second, independent tidy data set 
# with the average of each variable for each Activity and each Subject.


# Return a tidy data set, tidyData, containing the mean of each column in our subset,
# subsetData, grouped by Subject and Activity,
# There will 180 records of 68 columns 
library("dplyr")

# a table.data.frame is needed for the dplyr "group_by" functionality.
tidyData <- tbl_df(subsetData) %>% 
  group_by(Subject, Activity) %>%
  summarize_all(mean)

# Create a codebook and a data file of "tidyData".
library(memisc)

# We need a data.set for this
dsTidy<-data.set(tidyData, check.names = FALSE)

# write tidyTable data to a text file
write.table(dsTidy, "TidyData.txt", row.names = FALSE)
# write a description file (not used)
Write(description(dsTidy), file="TidyData-desc.txt")
# generate the codebook
Write(codebook(dsTidy), file="CodeBook.md")



