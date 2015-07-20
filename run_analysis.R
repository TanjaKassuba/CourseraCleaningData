
run_analysis <- function(){
	
	
	## check if dplyr package is installed, if yes load, else abort script
	if ("dplyr" %in% rownames(installed.packages())){
		suppressMessages(library(dplyr))
		}
	else {stop("Please install package 'dplyr' and try again. Bye bye...")}
	
	
	
	## check if data is in working directory, if not, download it into working directory
	# calls function getfiles() which is at the bottom of this file
	files <- c("activity_labels", "features","subject_test", "subject_train", 
				"X_test", "X_train", "y_test", "y_train")
	if (sum(file.exists(paste(files,"txt",sep="."))) != length(files)){
			message(paste("Data files not found in working directory, will download.\n",
						  "Warning: only tested for Mac OS X, please download files manually ",
						  "if it doesn't work (see README.md).\n\n", sep=""))
			getfiles(files)
		}
	
	
	
	## read in variable names and put into character vector
	features <- read.table("features.txt")
	features <- as.character(features[,2])
	
	# get the indices of the variables with "mean()" and "std()" in their name
	varindex <- which(grepl("mean\\(\\)", features) | grepl("std\\(\\)", features))
	
	# get the names of the included variables and replace "-" with "." and remove "()"
	varnames <- features[varindex]
	varnames <- gsub("-", ".", varnames)
	varnames <- gsub("\\(\\)", "", varnames)
	# the last six variables have 2x "Body" in their name which is an error, remove the first "Body"
	varnames[61:66] <- gsub("^fBody", "f", varnames[61:66])
	
	
	
	## read in activity labels and put into character vector
	activity_labels <- read.table("activity_labels.txt")
	activity_labels <- as.character(activity_labels[,2])
	
	
	
	## for each data type (train vs test):
	# 1. get the subject information and store as factor: tmpsubj
	# 2. get the activity information and store as factor with meaningful labels: tmpactivity
	# 3. get the data, select only the variables I want to include, and assign variable names: tmpdata
	# 4. put all into one data frame and assign to list datain
	# 5. remove all temporary data from workspace (all objects tmp*)
	
	datain = list() #will assign data frame from each train vs test to this list
	for (t in c("train", "test")){
		
		# get subject information as variable "SubjectID and factor class
		tmpsubj <- read.table(sprintf("subject_%s.txt", t), col.names="SubjectID", colClasses="factor")
		
		# get activity information as variable "Activity" and factor class, add meaningful labels
		tmpactivity <- read.table(sprintf("y_%s.txt", t), col.names="Activity", colClasses="factor")
		tmpactivity[,1] <- factor(tmpactivity[,1], labels=activity_labels)
		
		# get data, select only the mean()/std() variables, and add meaningful variable names
		tmpdata <- read.table(sprintf("X_%s.txt", t))
		tmpdata <- select(tmpdata, varindex)
		colnames(tmpdata) <- varnames
		
		# now add subject ID, activity, and data together to datain list
		datain[[t]] <- data.frame(tmpsubj, tmpactivity, tmpdata)
		
		# remove all tmp variables from workspace
		rm(list=ls(pattern="^tmp"))
		
	}
	
	
	
	## merge the train and test data sets
	merged <- merge(datain$train, datain$test, all=TRUE)
	
	# remove datain from workspace
	rm(datain)
	
	
	
	## finally, create average for each subject and activity:
	# group by SubjectID, Activity, and DataType 
	# (DataType has no effect on grouping, but want to exclude from mean function in next step)
	# then get mean for all ungrouped variables
	# assisgn to variable tidydata
	tidydata <- merged %>% group_by(SubjectID, Activity) %>% summarise_each(funs(mean))
	tidydata <- data.frame(tidydata)
	
	
	
	## write cleaned data to file
	write.table(tidydata, "TidyData.txt", sep = "\t", row.name=FALSE)
	# data can be read back in with: read.table("TidyData.txt", header=TRUE, sep="\t")
	
	return(tidydata)	
}
	
	

	
getfiles <- function(files){
	
	## automatically downloads the files into working directory,
	## tested on Mac OS only
	
	url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(url, destfile="temp.zip", method="curl")
	
	unzip("temp.zip", exdir="temp")
	
	# list of all files in temp and subdirectories
	filepaths <- list.files("temp", recursive=TRUE)
	
	# automatically find the files I want without having to write the paths for subdirectories
	for (i in files){
		
		# find the file but not the *_y_test etc (in the Inertia subfolder)
		j <- grepl(sprintf("(%s.txt)$", i), filepaths) & !grepl(sprintf("(_%s.txt)$", i), filepaths)
		
		# copy the file into the working directory
		file.copy(file.path("temp",filepaths[j]),".")
		}
	
	# remove downloaded temp folders
	unlink("temp*", recursive=TRUE)	
}