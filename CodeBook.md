# Description of Data: Human Activity Recognition Using Smartphones

The here reported steps of data cleaning were performed according to the assignment for 
the Coursera Getting and Cleaning Data Course Project.



## Source

The original data for this project was retrieved from the UC Irvine Machine Learning 
Repository. A full description is available at the site the data was obtained:

* <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones" 
target=_blank>http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones</a>

The data was downloaded here:

* <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
k>https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</a>

---  
<sub>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
A Public Domain Dataset for Human Activity Recognition Using Smartphones. 
21th European Symposium on Artificial Neural Networks, Computational Intelligence and 
Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.</sub>


## Information on Original Data Set

Note: This information was adapted from the 
<a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones" 
target=_blank>original web site</a>.  


### Variables

**30 volunteers** (19-48 years of age) performed **six activities** (walking, walking upstairs, 
walking downstairs, sitting, standing, laying) wearing a smartphone (Samsung Galaxy S II) 
on the waist.

Using the phone's embedded accelerometer and gyroscope, the **3-axial linear acceleration** 
(tAcc-XYZ) and **3-axial angular velocity** (tGyro-XYZ) were captured at a constant rate of 
50Hz (the prefix "t" denotes that these are **time domain** signals). These signals were 
pre-processed by applying noise filters (Butterworth low pass filter with 20 Hz cutoff 
frequency) and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap 
(128 readings/window). The acceleration signal was further separated into 
**body** acceleration (tBodyAcc-XYZ) and **gravity** (tGravityAcc-XYZ) using a Butterworth 
low-pass filter. Since the gravitational force is assumed to have only low frequency 
components, a 0.3 Hz cutoff frequency used. The resulting variables are: `tBodyAcc-XYZ`, 
`tGravityAcc-XYZ`, and `tBodyGyro-XYZ` (&rarr; **9 measurements**, one for each X, Y, and Z).

Next, to obtain **Jerk** signals, the body linear acceleration (tBodyAcc-XYZ) and angular 
velocity (tBodyGyro-XYZ) were derived in time: `tBodyAccJerk-XYZ` and `tBodyGyroJerk-XYZ` 
(&rarr; **6 measurements**, one for each X, Y, and Z).

Also, the **magnitude** of all these three-dimensional signals (-XYZ) were calculated using 
the Euclidean norm: `tBodyAccMag`, `tGravityAccMag`, `tBodyGyroMag`, `tBodyAccJerkMag`, 
and `tBodyGyroJerkMag` (&rarr; **5 measurements**).

Finally, a Fast Fourier Transform (FFT) was applied to some of these signals to obtain 
**frequency domain** signals (as indicated by prefix "f" in name): `fBodyAcc-XYZ`, `fBodyAccJerk-XYZ`, 
`fBodyGyro-XYZ`, `fBodyAccMag`, `fBodyAccJerkMag`, `fBodyGyroMag`, and `fBodyGyroJerkMag` 
(&rarr; **13 measurements**).

For each of the above mentioned measurements, a set of variables were estimated including 
the mean value `mean()` and standard deviation `std()`. There were 15 additional types of 
estimations that were disregarded in the current project (see original data for more 
information). Thus, of the original 561 (33 x 17) variables, only **66 variables** were 
extracted (i.e., the mean and standard deviation of each of the 33 measurements described 
above) in the current project. Note that all measurement variables were **normalized and 
bounded within [-1, 1]** and there were **no missing values**. For each subject and activity, 
there was more than one observation of the measurement variables collected (not the same 
number of observations for each subject/activity).


### Data files

The original dataset has been randomly partitioned into two sets, where 70% of the 
subjects were assigned to the **training** data set and 30% to the **test** data set. The 
data used in this project is split up into eight data files:

- **features.txt**: lists all measurement variable names in the same order as they are 
ordered as columns in the data files (X\_\*.txt) (561x2 matrix: 1st column indicates 
the corresponding column number in the data files, 2nd columns indicates the corresponding 
measurement variable name)

- **activity\_labels.txt**: links the six activity levels with activity labels (6x2 matrix: 
 1st column indicates activity level, 2nd column indicates corresponding activity name)

- **test/subject\_test.txt**: vector that indicates the corresponding subject IDs in the 
observation rows in the test data file (X\_test.txt)

- **train/subject\_train.txt**: vector that indicates the corresponding subject IDs in the 
observation rows in the training data file (X\_train.txt)

- **test/X\_test.txt**: test data set (2947x561 matrix) with observations as rows and 
measurement variables in columns (as indicated in features.txt)

- **train/X\_train.txt**: training data set (7352x561 matrix) with observations as rows and 
measurement variables in columns (as indicated in features.txt)

- **y\_test.txt**: vector that indicates the corresponding activity category in the 
observation rows in the test data file (X\_test.txt)

- **y\_train.txt**: vector that indicates the corresponding activity category in the 
observation rows in the training data file (X\_train.txt) 



## Data Cleaning

The original data set was tidied up using the **run_analysis.R** script (see README.md for 
more details on the script). The following transformations were applied on the original 
data:

1. In each the training and test data sets, **only mean and standard deviation** of each of the 
33 measurements were **extracted** (i.e., 66 of the 561 measurement variables). Thus, all 
variables with "**-mean()-**" or "**-std()-**" in their name were selected. Since the assignment 
requested to extract "only the measurements on the mean and standard deviation for each 
measurement", I did not extract any other variables containing not-straightforward/mixed 
calculated means such as those with "-meanFreq()-" (weighted average of the frequency components to 
obtain a mean frequency) or "Mean" (averaged signals in a signal window used on angle() variable) 
in their name. The README.md indicates the line of code to change of more variables should be included.

2. The extracted training and test data sets from Step. 1 were **merged**.

3. Meaningful **variable names** were assigned to the extracted data. These names consisted of 
the original names (as indicated by features.txt), except that the "-" were replaced by "." 
and the "()" were removed from the names. Also, some variable names in features.txt had 
the word "Body" twice in their name which is an error (according to features_info.txt), 
the double "Body" was removed.

4. A variable indicating the **subject ID** for each observation was added.

5. A variable indicating the **activity category** for each observation was added, using 
meaningful labels (as indicated by activity\_labels.txt)

6. A new independent **tidy data set** was created from the data set in Step 5. that contains 
that **average** across all observations of a variable **for each subject and activity**. This tidy 
data set can be found in **TidyData.txt**.



## Data Dictionary

The tidy data set is stored in **TidyData.txt** and contains 180 rows and 68 variables:

* `1` `SubjectID`: unique subject identifier  
    integers ranging from 1 to 30

* `2` `Activity`: type of activity  
    1 = WALKING  
    2 = WALKING\_UPSTAIRS  
    3 = WALKING\_DOWNSTAIRS  
    4 = SITTING  
    5 = STANDING  
    6 = LAYING
    
* `3` `tBodyAcc.mean.X`: linear body acceleration along x-axis  
    average normed mean per subject and activity

* `4` `tBodyAcc.mean.Y`: linear body acceleration along y-axis  
    average normed mean per subject and activity

* `5` `tBodyAcc.mean.Z`: linear body acceleration along z-axis  
    average normed mean per subject and activity

* `6` `tBodyAcc.std.X`: variability of linear body acceleration along x-axis  
    average normed standard deviation per subject and activity

* `7` `tBodyAcc.std.Y`: variability of linear body acceleration along y-axis  
    average normed standard deviation per subject and activity

* `8` `tBodyAcc.std.Z`: variability of linear body acceleration along z-axis  
    average normed standard deviation per subject and activity

* `9` `tGravityAcc.mean.X`: linear gravity acceleration along x-axis  
    average normed mean per subject and activity

* `10` `tGravityAcc.mean.Y`: linear gravity acceleration along y-axis  
    average normed mean per subject and activity

* `11` `tGravityAcc.mean.Z`: linear gravity acceleration along z-axis  
    average normed mean per subject and activity

* `12` `tGravityAcc.std.X`: variability of linear gravity acceleration along x-axis  
    average normed standard deviation per subject and activity

* `13` `tGravityAcc.std.Y`: variability of linear gravity acceleration along y-axis  
    average normed standard deviation per subject and activity

* `14` `tGravityAcc.std.Z`: variability of linear gravity acceleration along z-axis  
    average normed standard deviation per subject and activity

* `15` `tBodyAccJerk.mean.X`: linear body jerks along x-axis  
    average normed mean per subject and activity

* `16` `tBodyAccJerk.mean.Y`: linear body jerks along y-axis  
    average normed mean per subject and activity

* `17` `tBodyAccJerk.mean.Z`: linear body jerks along z-axis  
    average normed mean per subject and activity

* `18` `tBodyAccJerk.std.X`: variability of linear body jerks along x-axis  
    average normed standard deviation per subject and activity

* `19` `tBodyAccJerk.std.Y`: variability of linear body jerks along y-axis  
    average normed standard deviation per subject and activity

* `20` `tBodyAccJerk.std.Z`: variability of linear body jerks along z-axis  
    average normed standard deviation per subject and activity

* `21` `tBodyGyro.mean.X`: angular body velocity about x-axis  
    average normed mean per subject and activity

* `22` `tBodyGyro.mean.Y`: angular body velocity about y-axis  
    average normed mean per subject and activity

* `23` `tBodyGyro.mean.Z`: angular body velocity about z-axis  
    average normed mean per subject and activity

* `24` `tBodyGyro.std.X`: variability of angular body velocity about x-axis  
    average normed standard deviation per subject and activity

* `25` `tBodyGyro.std.Y`: variability of angular body velocity about y-axis  
    average normed standard deviation per subject and activity

* `26` `tBodyGyro.std.Z`: variability of angular body velocity about z-axis  
    average normed standard deviation per subject and activity

* `27` `tBodyGyroJerk.mean.X`: angular body jerks about x-axis  
    average normed mean per subject and activity

* `28` `tBodyGyroJerk.mean.Y`: angular body jerks about y-axis  
    average normed mean per subject and activity

* `29` `tBodyGyroJerk.mean.Z`: angular body jerks about z-axis  
    average normed mean per subject and activity

* `30` `tBodyGyroJerk.std.X`: variability of angular body jerks about x-axis  
    average normed standard deviation per subject and activity

* `31` `tBodyGyroJerk.std.Y`: variability of angular body jerks about y-axis  
    average normed standard deviation per subject and activity

* `32` `tBodyGyroJerk.std.Z`: variability of angular body jerks about z-axis  
    average normed standard deviation per subject and activity

* `33` `tBodyAccMag.mean`: magnitude of linear body acceleration  
    average normed mean per subject and activity

* `34` `tBodyAccMag.std`: variability of the magnitude of linear body acceleration  
    average normed standard deviation per subject and activity

* `35` `tGravityAccMag.mean`: magnitude of gravity acceleration  
    average normed mean per subject and activity

* `36` `tGravityAccMag.std`: variability of the magnitude of gravity acceleration  
    average normed standard deviation per subject and activity

* `37` `tBodyAccJerkMag.mean`: magnitude of linear body jerks  
    average normed mean per subject and activity

* `38` `tBodyAccJerkMag.std`: variability of the magnitude of linear body jerks  
    average normed standard deviation per subject and activity

* `39` `tBodyGyroMag.mean`: magnitude of angular body velocity  
    average normed mean per subject and activity
    
* `40` `tBodyGyroMag.std`: variability of the magnitude of angular body velocity  
    average normed standard deviation per subject and activity

* `41` `tBodyGyroJerkMag.mean`: magnitude of angular body jerks  
    average normed mean per subject and activity
    
* `42` `tBodyGyroJerkMag.std`: variability of the magnitude of angular body jerks  
    average normed standard deviation per subject and activity

* `43` `fBodyAcc.mean.X`: linear body acceleration along x-axis in frequency domain  
    average normed mean per subject and activity  
    
* `44` `fBodyAcc.mean.Y`: linear body acceleration along y-axis in frequency domain  
    average normed mean per subject and activity
    
* `45` `fBodyAcc.mean.Z`: linear body acceleration along z-axis in frequency domain  
    average normed mean per subject and activity

* `46` `fBodyAcc.std.X`: variability of linear body acceleration along x-axis in frequency domain  
    average normed standard deviation per subject and activity

* `47` `fBodyAcc.std.Y`: variability of linear body acceleration along y-axis in frequency domain  
    average normed standard deviation per subject and activity

* `48` `fBodyAcc.std.Z`: variability of linear body acceleration along z-axis in frequency domain  
    average normed standard deviation per subject and activity

* `49` `fBodyAccJerk.mean.X`: linear body jerks along x-axis in frequency domain  
    average normed mean per subject and activity

* `50` `fBodyAccJerk.mean.Y`: linear body jerks along y-axis in frequency domain  
    average normed mean per subject and activity

* `51` `fBodyAccJerk.mean.Z`: linear body jerks along z-axis in frequency domain  
    average normed mean per subject and activity

* `52` `fBodyAccJerk.std.X`: variability of linear body jerks along x-axis in frequency domain  
    average normed standard deviation per subject and activity

* `53` `fBodyAccJerk.std.Y`: variability of linear body jerks along y-axis in frequency domain  
    average normed standard deviation per subject and activity

* `54` `fBodyAccJerk.std.Z`: variability of linear body jerks along z-axis in frequency domain  
    average normed standard deviation per subject and activity

* `55` `fBodyGyro.mean.X`: angular body velocity about x-axis in frequency domain  
    average normed mean per subject and activity
    
* `56` `fBodyGyro.mean.Y`: angular body velocity about y-axis in frequency domain  
    average normed mean per subject and activity
    
* `57` `fBodyGyro.mean.Z`: angular body velocity about z-axis in frequency domain  
    average normed mean per subject and activity

* `58` `fBodyGyro.std.X`: variability of angular body velocity about x-axis in frequency domain  
    average normed standard deviation per subject and activity

* `59` `fBodyGyro.std.Y`: variability of angular body velocity about y-axis in frequency domain  
    average normed standard deviation per subject and activity

* `60` `fBodyGyro.std.Z`: variability of angular body velocity about z-axis in frequency domain  
    average normed standard deviation per subject and activity

* `61` `fBodyAccMag.mean`: magnitude of linear body acceleration in frequency domain  
    average normed mean per subject and activity
    
* `62` `fBodyAccMag.std`: variability of the magnitude of linear body acceleration in frequency domain  
    average normed standard deviation per subject and activity  

* `63` `fBodyAccJerkMag.mean`: magnitude of linear body jerks in frequency domain  
    average normed mean per subject and activity
    
* `64` `fBodyAccJerkMag.std`: variability of the magnitude of linear body jerks in frequency domain  
    average normed standard deviation per subject and activity

* `65` `fBodyGyroMag.mean`: magnitude of angular body velocity in frequency domain  
    average normed mean per subject and activity

* `66` `fBodyGyroMag.std`: variability of the magnitude of angular body velocity in frequency domain  
    average normed standard deviation per subject and activity

* `67` `fBodyGyroJerkMag.mean`: magnitude of angular body jerks in frequency domain  
    average normed mean per subject and activity

* `68` `fBodyGyroJerkMag.std`:variability of the  magnitude of angular body jerks in frequency domain  
    average normed standard deviation per subject and activity

