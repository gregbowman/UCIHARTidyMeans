# UCIHARTidyMeans Code Book

A cleaned and summarized version of Human Activity Recognition Using Smartphones data provided by the University of California at Irvine as part of their research.

## Tidy Datasets
- UCIHARTidyMeans.RData --- this is your best bet if you have R, simply load("UCIHARTidyMeans.RDATA")

- UCIHARTidyMeans.txt --- for those without R

## Code Book
Each record in the dataset contains 68 fields.
### The first two fields are identifiers:
- Activity --- 
an identifier of which activity the subject was involved in:
"WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", or "LAYING"
- Subject ---
a numeric identifier to show which individual test subject is associated with the measurement.

### The remaining 66 fields are the means and standard deviations of collected sensor information. In this dataset, the fields contain the mean of each of these measures calculated for each Activity and Subject:
- tBodyAcc-mean()-X
- tBodyAcc-mean()-Y
- tBodyAcc-mean()-Z
- tBodyAcc-std()-X
- tBodyAcc-std()-Y
- tBodyAcc-std()-Z
- tGravityAcc-mean()-X
- tGravityAcc-mean()-Y
- tGravityAcc-mean()-Z
- tGravityAcc-std()-X
- tGravityAcc-std()-Y
- tGravityAcc-std()-Z
- tBodyAccJerk-mean()-X
- tBodyAccJerk-mean()-Y
- tBodyAccJerk-mean()-Z
- tBodyAccJerk-std()-X
- tBodyAccJerk-std()-Y
- tBodyAccJerk-std()-Z
- tBodyGyro-mean()-X
- tBodyGyro-mean()-Y
- tBodyGyro-mean()-Z
- tBodyGyro-std()-X
- tBodyGyro-std()-Y
- tBodyGyro-std()-Z
- tBodyGyroJerk-mean()-X
- tBodyGyroJerk-mean()-Y
- tBodyGyroJerk-mean()-Z
- tBodyGyroJerk-std()-X
- tBodyGyroJerk-std()-Y
- tBodyGyroJerk-std()-Z
- tBodyAccMag-mean()
- tBodyAccMag-std()
- tGravityAccMag-mean()
- tGravityAccMag-std()
- tBodyAccJerkMag-mean()
- tBodyAccJerkMag-std()
- tBodyGyroMag-mean()
- tBodyGyroMag-std()
- tBodyGyroJerkMag-mean()
- tBodyGyroJerkMag-std()
- fBodyAcc-mean()-X
- fBodyAcc-mean()-Y
- fBodyAcc-mean()-Z
- fBodyAcc-std()-X
- fBodyAcc-std()-Y
- fBodyAcc-std()-Z
- fBodyAccJerk-mean()-X
- fBodyAccJerk-mean()-Y
- fBodyAccJerk-mean()-Z
- fBodyAccJerk-std()-X
- fBodyAccJerk-std()-Y
- fBodyAccJerk-std()-Z
- fBodyGyro-mean()-X
- fBodyGyro-mean()-Y
- fBodyGyro-mean()-Z
- fBodyGyro-std()-X
- fBodyGyro-std()-Y
- fBodyGyro-std()-Z
- fBodyAccMag-mean()
- fBodyAccMag-std()
- fBodyBodyAccJerkMag-mean()
- fBodyBodyAccJerkMag-std()
- fBodyBodyGyroMag-mean()
- fBodyBodyGyroMag-std()
- fBodyBodyGyroJerkMag-mean()
- fBodyBodyGyroJerkMag-std()

The following description of the above fields was provided by the UCI Machine Learning Lab:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
> 
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
>
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

> These signals were used to estimate variables of the feature vector for each pattern:  
>'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

## Study Design

This dataset is sourced from the [raw dataset provided by UCI at this link] 
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "source data"). Their description of the data [can be accessed here] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "Human Activity Recognition Using Smartphones").

The program run_analysis.R was used to convert the raw data from UCI into the 'tidy' summarization presented here. It expects te raw data to be unzipped directly into the working directory where the program resides so that the "UCI HAR Dataset" folder is directly under the working directory. NOTE: the Inertial Signals folders were not used in this study.

### The cleanup and summarization of the raw data
Cleanup and summarization was acccomplished in the following manner. Numbered steps correspond to numbered comments in run_analysis.R:

1. ACTIVITY LABELS -- 
Read the activity labels from their associated file, these labels will by applied to the Activity identifier in the dataset later in this process.
2. FEATURES ---
Read the names and column numbers of the features in the raw dataset and select only those referring to mean or standard deviation measures. These will be used to extract specific features and to apply the supplied names to the tidy dataset.
3. SUBJECTS ---
Read the identifiers that relate individual test subjects to their data. There are separate identifier lists for the test and train portions of the raw data these are combined for this study.
4. ACTIVITIES ---
Read the identifiers that relate the subjects activity to the sensor data. Also has separate portions for test and train which are combined here. The Activity Labels collected in step 1 are applied here.
5. MEASURES ---
Read the raw feature measurements, extracting only the desired ones: mean() and std(). There are separate sets for train and test which are combined here. Also, the field names collected in step 2 are applied here.
6. COMBINE ---
The SUBJECTS, ACTIVITIES, and MEASURES are combined here so that the identifiers can be used for aggregation.
7. AGGREGATE ---
Mean is calculated for all measurements summarizing by Activity and Subject.
8. RECAST ---
Reassemble the calculated fields so that one record exists for each Activity and Subject combination.
9. OUTPUT ---
The tidy dataset is written in two formats: RData and text.