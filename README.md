Coursera - Getting and Cleaning Data
Course Project
==========

## How the script works

###input and output
unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
a folder named "UCI HAR Dataset" will be generated, put it in the same place with the script run_analysis.r,
then the script could be run and generate an output file named "output.txt".

### Script logic
* Merges the training and the test sets to create one data set.<br/>
    This matches the #q1 part of script
    1. Read all feature name using the read.csv function and store the result in variable 'featureName' as character vector
    2. Create a functon 'readDataSet' which take the responsibily to read the X part of data and generate a data.frame as result.<br/>
        the parameter is the data file name.<br/>
        As one record stored in one line and all fields of the each line are seperated by 1 or 2 spaces,using readLine and strsplit to parse the data then filter out all empty strings could bring us all the effective data.<br/>
        Store all data into a data.matrix and reform the data.matrix as data.frame, then assign the feature names to it.<br/>
    3. Read X part of training data and test data seperately then merge toghter into 'mergedData'.
<br/><br/>

* Extracts only the measurements on the mean and standard deviation for each measurement.<br/>
    This matches the #q2 part of script
    1. Using regular expression to justify whether a feature is required (the features' name that contains 'mean()' or 'std()'). Store the indicators (boolean flag) into variable 'selectedFeatureNameIndicator'
    2. Store the selected features' name into variable 'selectedFeatureName'
    3. Extracts only the measurements on the selected features and store the data into variable 'selectedData'
<br/><br/>

* Uses descriptive activity names to name the activities in the data set.<br/>
    This matches the #q3 part of script
    1. Read the label -- descriptive label mapping file using read.csv and store the mapping into 'descriptiveActivityName'
<br/><br/>

* Appropriately labels the data set with descriptive variable names.<br/>
    This matches the #q4 part of script
    1. Read the integer label file (y part of the data) of both training data and test data as numerical vector, concatenate them together.
    2. Do the same thing for subject file. (This step must be done before step 4, because merge may spoil the original order)
    3. Append the numerical label vector and subject vector as column into 'selectedData'
    4. Merge 'selectedData' and 'descriptiveActivityName' by numerical label column inorder to get the descriptive label for each measurement sample, store the result into 'cookedData'
<br/><br/>

* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.<br/>
    This matches the #q5 part of script
    1. Aggregate for each subject and each label, calculate the mean value of each group.
    2. Write the result into file.
<br/><br/>

### Code book describing the variables
The data is the summarization of Human Activity Recognition Using Smartphones Dataset (Version 1.0)<br/>
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. <br/>
A full description of the original data is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones<br/>

* subject<br/>
    This field identifies the subject who performed the activity for each window sample. Its range is from 1 to 30
* descriptiveLabel<br/>
    This field identifies the activities, its range is (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* other fields<br/>
    The average value of original data on mean and standard deviation measurements.
    
    '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.<br/>
    tBodyAcc-XYZ<br/>
    tGravityAcc-XYZ<br/>
    tBodyAccJerk-XYZ<br/>
    tBodyGyro-XYZ<br/>
    tBodyGyroJerk-XYZ<br/>
    tBodyAccMag<br/>
    tGravityAccMag<br/>
    tBodyAccJerkMag<br/>
    tBodyGyroMag<br/>
    tBodyGyroJerkMag<br/>
    fBodyAcc-XYZ<br/>
    fBodyAccJerk-XYZ<br/>
    fBodyGyro-XYZ<br/>
    fBodyAccMag<br/>
    fBodyAccJerkMag<br/>
    fBodyGyroMag<br/>
    fBodyGyroJerkMag<br/>

### Reference
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
