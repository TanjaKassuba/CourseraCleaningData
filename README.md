# Information

This repository contains the assignment for the Coursera Getting and Cleaning Data Course 
Project:

* **run_analysis.R**: script for performing the data cleaning, returns a data frame of the
 tidy data and writes tidy data to a text file

* **TidyData.txt**: text file containing the tidy data set written out by run_analysis.R, 
variable names are in the header and columns are tab separated, load into R with: 
`read.table("TidyData.txt", header=TRUE, sep="\t")`

* **CodeBook.md**: description of the data, the transformations applied on the data, and 
the final variables in the tidy data set returned by run_analysis.R and written to 
TidyData.txt



## Running run_analysis.R

The script takes no arguments and returns the tidy data set as a data frame (for details 
on the origin of the data and transformations applied, see CodeBook.md). It also writes 
the tidy data set to a text file "TidyData.txt" in the current working directory 
(see details above). Call the script from directory where it is located with:  
`source("run_analysis.R"); tidydata <- run_analysis()`



### Prerequisites

* The script relies on the package **dpylr**. The script will test whether the package 
is installed and if not, throw an error message asking you to install the package and 
then it will abort. In this case, install the package before running the script again: 
`install.packages("dplyr")`

* The scripts expects to find the following input data files in the working directory:
  - **activity\_labels.txt** (from: "UCI HAR Dataset/activity_labels.txt")
  - **features.txt** (from: "UCI HAR Dataset/features.txt")
  - **subject\_test.txt** (from: "UCI HAR Dataset/test/subject_test.txt")
  - **subject\_train.txt** (from: "UCI HAR Dataset/train/subject_train.txt")
  - **X\_test.txt** (from: "UCI HAR Dataset/test/X_test.txt")
  - **X\_train.txt** (from: "UCI HAR Dataset/train/X_train.txt")
  - **y\_test.txt** (from: "UCI HAR Dataset/test/y_test.txt")
  - **y\_train.txt** (from: "UCI HAR Dataset/train/y\_train.txt")  
  
  If the script does not find these files in the working directory, it will call the 
  function `getfiles(files)` which is saved at the end inside the run_analysis.R file. The 
  function getfiles() will download the zipped data folder from
  <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">here</a>,
   unzip it, and copy the relevant files into the working directory, then remove the 
  zipped and unzipped folders again. Note that this function has only been tested on Mac 
  OS X system and if it does not work, please download the data files manually and save 
  them in the working directory.


### What the script does

1. Checks whether package dplyr is installed:    
&rarr; if yes, it will load the package  
&rarr; if not, it will throw a message asking to install the package and then it exit the script

2. Checks whether input data files are in working directory:  
&rarr; if not, it will call the function getfiles() to get the data

3. Prepares the information on the variables:  
&rarr; reads in the variable names from "features.txt"  
&rarr; gets the indices of the variables to include, i.e. those with "mean()" and "std()" 
in their names (see CodeBook.md for rationale) - if want to include other variables, need 
to change line 31:  
`varindex <- which(grepl("mean\\(\\)", features) | grepl("std\\(\\)", features))`   
&rarr; gets the corresponding names of the variables to include and replaces the "-" with 
"." and removes the "()" from these names  
&rarr; some of the variable names have "Body" twice in their name, removes the double "Body"

4. Reads in the activity labels from "activity_labels.txt"

5. Prepares the data from each data type (train vs. test):  
&rarr; reads in the Subject IDs from "subject\_\*.txt" that correspond to data  
&rarr; reads in the Activity assignments from "y\_\*.txt" that correspond to data and adds 
meaningful labels using the activity labels prepared in Step 4.  
&rarr; reads in the data from "X\_\*.txt", selects only the variables to include using the 
indices extracted in Step 3. and assigns the variable names prepared in Step 3.   
&rarr; adds SubjectID, Activity, and data into one data frame  
&rarr; removes any additional temporarily loaded data from workspace

6. Merges the train and test data frames created in Step 5.

7. Creates tidy data set from the merged data created in Step 6. with the average of each 
variable for each subject and activity:  
&rarr; groups the merged data set by SubjectID and Activity  
&rarr; retrieves the mean of all other variables for this grouped data

8. Writes tidy data from Step 7. to text file "TidyData.txt" in working directory, with 
header and tab delimited

9. Returns data frame of tidy data from Step 7.
