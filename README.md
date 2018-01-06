
# README.md  
# By Karen Enfield
# Getting and Cleaning Data Course Project FINAL

Human Activity Recognition Using Smartphones TIDY Dataset
Version 1.0

README.md file explains how run_analysis.R script works.      

There is one script file, run_Analysis.R that has five sections:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.


Step 1  Merge the training and the test sets to create one data set.
--------------------------------------------------------------------
  Read the training data 'train/X_train.txt' and testing data 'test/X_test.txt' and merge them to create one table of measurement data with named columns from 'features.txt'.  This is stored in variable "allMeasurements".

  Next, read to tables and merging data from 'train/y_train.txt' and 'test/y_test.txt', the test and training activity files, into one table.  Store in variable "allActivity".

  Again, read the test and training Subject data, 'train/subject_test.txt' and  'test/subject_test.txt' into tables, merge, and store in the variable "allSubjects"

  Finally, we combine the allSubjects, allActivity, and allMeasurements into one data variable called "allData", with labeled column headers for subject, activity, and measurements from features.txt.  "allData" has 563 columns and 10,299 rows.


Step 2: Extract only the mean and standard deviation columns from the data set.
-------------------------------------------------------------------------------
  Extract the  mean and standard deviation column numbers by searching for "-mean()" or "-std()" in the column names. Use the featureColumns data already created in Step 1, by searching in featureColumns$Name variable.  After search and extraction, there should be 66  feature columns of means and standard deviations meeting this criteria stored in "meanStdCols".

  Not forgetting Subject and Activity columns create the final list of columns and extract them from "allData", creating "subsetData", totalling 68 columns and 10,299 rows.


Step 3: Use descriptive activity names to name the activities in the data set
-----------------------------------------------------------------------------
  Read the activity names from the file:."/UCI Har Dataset/activity_labels.txt", and then replace all activity numbers with their descriptive activity labels.  It will require removing "subsetData$Activities" and adding a new "subsetData$Activities"" column in the same position with the labels instead of the numbers.

Step 4: Appropriately label the data set with descriptive variable names.
--------------------------------------------------------------------------
  The CodeBook will eventually contain all the descriptions we add in this section.  So the more descriptions, wording, and annotations we add to the variable names now, the more robust the Codebook will be.
  We will describe all columns in "subsetData",  assign descriptions to the Subject and Activity columns and also subsequently, use a find and replace algorithm to derive human readable descriptions from the featured column names, and assign more wording and annotation to the feature column names gleaned from the README.TXT file and measurement information from this file: 
 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



Step 5: From the "subsetData"" in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
----------------------------------------------------------------------------------------
  From "subsetData" we create a table data frame, in order to create a tidy data set, "tidyData", containing the mean of each column in subsetData, grouped by Subject and Activity.  There will 180 records of 68 columns.  
  
  
FINAL STEP: Create A TidyData CODEBOOK and a tidy data text file
-------------------------------------------------------------
  Then tidyData will be converted into a data set, dsTidyData so that a codebook, "CodeBook.md" can be generated, as well as a tidy output created of tidyData by gathring and flattening the mean data and writing it out in text format to, "TidyData.txt".



