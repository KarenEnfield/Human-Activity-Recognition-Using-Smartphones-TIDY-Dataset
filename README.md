
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
  Next, read the training data 'train/X_train.txt' and testing data 'test/X_test.txt' and create one table of data with named columns from 'features.txt'.

Do the same thing, reading to tables and merging data from 'train/y_train.txt' and 'test/y_test.txt', the test and training activity files, which correspond to the test and training measurements

The same for Subject data, what was done for Activity data, in both test and training areas to be merged.

Finally, we combine the Subjects, Activity, and allMeasurements into one data variable called "allData".


Step 2: Extract only the mean and standard deviation columns from the data set.
-------------------------------------------------------------------------------
Extract all the  mean and standard deviation column numbers by searching for "-mean()" or "-std()" in their original column names. Use the featureColumns data already created in Step 1, by looking in featureColumns$Name variable.  After search and extraction, there should be 66 remaining feature columns of means and standard deviations.

Not forgetting Subject and Activity columns create the final list of columns and extract them from "allData", creating "subsetData"", totalling 68 columns and 10,299 rows.


Step 3: Use descriptive activity names to name the activities in the data set
-----------------------------------------------------------------------------
First, read the activity names from the file:."/UCI Har Dataset/activity_labels.txt", and then replace all activity numbers with their descriptive activity labels.  It will require removing and adding a new column.

Step 4: Appropriately label the data set with descriptive variable names.
--------------------------------------------------------------------------
Descriptions we add to subsetData variables will pay off when we generate the codebook later.  Assign descriptions to the Subject and Activity columns in subsetData, and subsequently, use a find and replace algorithm to create meaningful descriptions from the cryptic column names, and assign the description to its column name for more information. Wording and annotation for the columns is optional, but will enhance the codebook later. 

Go to http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
for more information about the measurement data.


Step 5: From the subsetData in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
----------------------------------------------------------------------------------------

Create a tidy data set, "tidyData"", containing the mean of each column in our subset, subsetData, grouped by Subject and Activity.  There will 180 records of 68 columns.  Then tidyData will be convertend into a data set so that a codebook, "CodeBook.md" can be written, as well as a table of it's data in text format, "TidyData.txt" for later useage.



