# Getting-And-Cleaning-Data-Final-Project
 A repo for the final project from week four of the Getting and Cleaning Data course

## Files contained in this Repo:
* README.md,
* CodeBook.md,
* run_analysis.R

## run_analysis.R

This R script downloads the zipped file and unzips it in the working directory. 
It reads the data into the current R session, and proceeds to clean the messy data as per the project instructions. 
It accomplishes the following tasks:
1. Merges the data into one data set.
2. Extracts the mean and standard deviation for each measurement.
3. Gives descriptive names to the activities in the data set.
4. Labels the data set with descriptive variable names.
5. Creates a tidy data set with the average of each variable for each activity and each subject.

Finally, it saves the tidy data as a separate text file, "tidy_data.txt"

#### Required Packages:
dplyr

## CodeBook.md
Here you will find an explanation of the data collected, along with a summary explaining all variable names and abbreviations used.
