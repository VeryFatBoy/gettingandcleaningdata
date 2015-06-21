Introduction
------------

This file is the codebook and describes the input data, transformations and output data for the R file [run_analysis.R](\run_analysis.R). The basis of this project is described in [README.md](\README.md).

The input data set used for this project can be obtained from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The input data consists of a number of files. These are listed in the README.txt file that accompanies the above data set. These files are as follows:

* **features_info.txt**: Shows information about the variables used on the feature vector.
* **features.txt**: List of all features.
* **activity_labels.txt**: Links the class labels with their activity name.
* **train/X_train.txt**: Training set.
* **train/y_train.txt**: Training labels.
* **train/subject_train.txt**: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* **test/X_test.txt**: Test set.
* **test/y_test.txt**: Test labels.
* **test/subject_train.txt**: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

Using run_analysis.R
--------------------

The R file **run_analysis.R** will first download the input data set, mentioned above, into the same directory that it is running from. It will then unzip the data set into a directory called **UCI HAR Dataset**.

The steps performed by the R file **run_analysis.R** are as follows:

1. **Merges the training and the test sets to create one data set.**

    Data from the following files are read into **run_analysis.R** and merged together:

    * **train/X_train.txt**
    * **train/y_train.txt**
    * **train/subject_train.txt**
    * **test/X_test.txt**
    * **test/y_test.txt**
    * **test/subject_train.txt**

    Suitable column names for the merged data are added using data from the file **features.txt**.

2. **Extracts only the measurements on the mean and standard deviation for each measurement.**

    This is achieved by selecting only columns from the original data set that contain **mean()** and **std()** in the column name. The assumption is that where brackets "**()**" are used is more likely to correspond to actual data measurements. This reduces the original data set to just mean and standard deviation measurements. Appendix A lists the column names at the end of step 2.

3. **Uses descriptive activity names to name the activities in the data set.**

    The data from the file **activity_labels.txt** are used to replace numeric activity values with actual descriptions.

4. **Appropriately labels the data set with descriptive variable names.**

    Following-on from step 2, improved label names can be used in several cases, as follows:

    * Column names beginning with "t" are replaced with "Time"
    * Column names beginning with "f" are replaced with "Frequency"
    * Column names containing "Acc" are replaced with "Accelerometer"
    * Column names containing "Mag" are replaced with "Magnitude"
    * All occurrences of "mean()" are replaced with "Mean"
    * All occurrences of "std()" are replaced with "StandardDeviation"

    Appendix B lists the final column names.

5. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

    This is achieved by aggregating the data using the mean, and writing the data out to a file called **tidy_data.txt**. The data are written out as 180 rows x 68 columns. The first column is the Subject identifer. The second column is the activity name. The remaining 66 columns are the means. There are 6 activities and 30 subjects, which gives 180 rows.
    The data are written to this file using a wide row format. Quotation marks from column names are stripped out before the data are written. The file **read_tidy_data.R** can be used to read the tidy_data.txt file. Sample output is shown in Appendix C.

Appendix A
----------

The column names from step 2 are as follows:

* Subject
* Activity
* tBodyAcc-mean()-X
* tBodyAcc-mean()-Y           
* tBodyAcc-mean()-Z           
* tBodyAcc-std()-X           
* tBodyAcc-std()-Y            
* tBodyAcc-std()-Z            
* tGravityAcc-mean()-X        
* tGravityAcc-mean()-Y       
* tGravityAcc-mean()-Z
* tGravityAcc-std()-X
* tGravityAcc-std()-Y
* tGravityAcc-std()-Z        
* tBodyAccJerk-mean()-X
* tBodyAccJerk-mean()-Y
* tBodyAccJerk-mean()-Z
* tBodyAccJerk-std()-X       
* tBodyAccJerk-std()-Y
* tBodyAccJerk-std()-Z
* tBodyGyro-mean()-X
* tBodyGyro-mean()-Y         
* tBodyGyro-mean()-Z
* tBodyGyro-std()-X
* tBodyGyro-std()-Y
* tBodyGyro-std()-Z          
* tBodyGyroJerk-mean()-X
* tBodyGyroJerk-mean()-Y
* tBodyGyroJerk-mean()-Z
* tBodyGyroJerk-std()-X      
* tBodyGyroJerk-std()-Y
* tBodyGyroJerk-std()-Z
* tBodyAccMag-mean()
* tBodyAccMag-std()          
* tGravityAccMag-mean()
* tGravityAccMag-std()
* tBodyAccJerkMag-mean()
* tBodyAccJerkMag-std()      
* tBodyGyroMag-mean()
* tBodyGyroMag-std()
* tBodyGyroJerkMag-mean()
* tBodyGyroJerkMag-std()     
* fBodyAcc-mean()-X
* fBodyAcc-mean()-Y
* fBodyAcc-mean()-Z
* fBodyAcc-std()-X           
* fBodyAcc-std()-Y
* fBodyAcc-std()-Z
* fBodyAccJerk-mean()-X
* fBodyAccJerk-mean()-Y      
* fBodyAccJerk-mean()-Z
* fBodyAccJerk-std()-X
* fBodyAccJerk-std()-Y
* fBodyAccJerk-std()-Z       
* fBodyGyro-mean()-X
* fBodyGyro-mean()-Y
* fBodyGyro-mean()-Z
* fBodyGyro-std()-X          
* fBodyGyro-std()-Y
* fBodyGyro-std()-Z
* fBodyAccMag-mean()
* fBodyAccMag-std()          
* fBodyBodyAccJerkMag-mean()
* fBodyBodyAccJerkMag-std()
* fBodyBodyGyroMag-mean()
* fBodyBodyGyroMag-std()     
* fBodyBodyGyroJerkMag-mean()
* fBodyBodyGyroJerkMag-std()

Appendix B
----------

The final column names are as follows:

* Subject
* Activity
* TimeBodyAccelerometer-Mean-X
* TimeBodyAccelerometer-Mean-Y
* TimeBodyAccelerometer-Mean-Z
* TimeBodyAccelerometer-StandardDeviation-X
* TimeBodyAccelerometer-StandardDeviation-Y
* TimeBodyAccelerometer-StandardDeviation-Z
* TimeGravityAccelerometer-Mean-X
* TimeGravityAccelerometer-Mean-Y
* TimeGravityAccelerometer-Mean-Z
* TimeGravityAccelerometer-StandardDeviation-X
* TimeGravityAccelerometer-StandardDeviation-Y
* TimeGravityAccelerometer-StandardDeviation-Z
* TimeBodyAccelerometerJerk-Mean-X
* TimeBodyAccelerometerJerk-Mean-Y
* TimeBodyAccelerometerJerk-Mean-Z
* TimeBodyAccelerometerJerk-StandardDeviation-X
* TimeBodyAccelerometerJerk-StandardDeviation-Y
* TimeBodyAccelerometerJerk-StandardDeviation-Z
* TimeBodyGyro-Mean-X
* TimeBodyGyro-Mean-Y
* TimeBodyGyro-Mean-Z
* TimeBodyGyro-StandardDeviation-X
* TimeBodyGyro-StandardDeviation-Y
* TimeBodyGyro-StandardDeviation-Z
* TimeBodyGyroJerk-Mean-X
* TimeBodyGyroJerk-Mean-Y
* TimeBodyGyroJerk-Mean-Z
* TimeBodyGyroJerk-StandardDeviation-X
* TimeBodyGyroJerk-StandardDeviation-Y
* TimeBodyGyroJerk-StandardDeviation-Z
* TimeBodyAccelerometerMagnitude-Mean
* TimeBodyAccelerometerMagnitude-StandardDeviation
* TimeGravityAccelerometerMagnitude-Mean
* TimeGravityAccelerometerMagnitude-StandardDeviation
* TimeBodyAccelerometerJerkMagnitude-Mean
* TimeBodyAccelerometerJerkMagnitude-StandardDeviation
* TimeBodyGyroMagnitude-Mean
* TimeBodyGyroMagnitude-StandardDeviation
* TimeBodyGyroJerkMagnitude-Mean
* TimeBodyGyroJerkMagnitude-StandardDeviation
* FrequencyBodyAccelerometer-Mean-X
* FrequencyBodyAccelerometer-Mean-Y
* FrequencyBodyAccelerometer-Mean-Z
* FrequencyBodyAccelerometer-StandardDeviation-X
* FrequencyBodyAccelerometer-StandardDeviation-Y
* FrequencyBodyAccelerometer-StandardDeviation-Z
* FrequencyBodyAccelerometerJerk-Mean-X
* FrequencyBodyAccelerometerJerk-Mean-Y
* FrequencyBodyAccelerometerJerk-Mean-Z
* FrequencyBodyAccelerometerJerk-StandardDeviation-X
* FrequencyBodyAccelerometerJerk-StandardDeviation-Y
* FrequencyBodyAccelerometerJerk-StandardDeviation-Z
* FrequencyBodyGyro-Mean-X
* FrequencyBodyGyro-Mean-Y
* FrequencyBodyGyro-Mean-Z
* FrequencyBodyGyro-StandardDeviation-X
* FrequencyBodyGyro-StandardDeviation-Y
* FrequencyBodyGyro-StandardDeviation-Z
* FrequencyBodyAccelerometerMagnitude-Mean
* FrequencyBodyAccelerometerMagnitude-StandardDeviation
* FrequencyBodyBodyAccelerometerJerkMagnitude-Mean
* FrequencyBodyBodyAccelerometerJerkMagnitude-StandardDeviation
* FrequencyBodyBodyGyroMagnitude-Mean
* FrequencyBodyBodyGyroMagnitude-StandardDeviation

Appendix C
----------

The sample output from the file **read_tidy_data.R** is as follows:

[read_tidy_data.jpg](https://cloud.githubusercontent.com/assets/11927397/8272480/e67b9a0a-183b-11e5-824e-a9de9d48236b.jpg)
