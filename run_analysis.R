# Load all necessary packages into current R session
library(dplyr)

# Download the zipped data file, saving it as 'project_data.zip'
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file_dest<-paste0(getwd(),"/","project_data.zip")
download.file(url,file_dest)

# Unzip the file
unzipped <- unzip("project_data.zip",list = TRUE)
unzip("project_data.zip")

# Read all required files into tables, using file paths stored in 'unzipped'
activity_labels <- read.table(unzipped[1,1], header = FALSE)
features <- read.table(unzipped[2,1], header = FALSE)

subject_test <- read.table(unzipped[16,1], header = FALSE)
x_test <- read.table(unzipped[17,1], header = FALSE)
y_test <- read.table(unzipped[18,1], header = FALSE)

subject_train <- read.table(unzipped[30,1], header = FALSE)
x_train <- read.table(unzipped[31,1], header = FALSE)
y_train <- read.table(unzipped[32,1], header = FALSE)

####################################################################
# QUESTION 1
####################################################################
# Put all the data into one data frame
temp1 <- cbind(subject_test, y_test, x_test)
temp2 <- cbind(subject_train, y_train, x_train)
data <- rbind(temp1, temp2)

# Find all the 'features' that measure mean or std (excluding meanFreq)
features$V2<- as.character(features$V2)
count <- grep("mean[^Ff]|std", features$V2)
for (i in count){features[i,1] <- features[i,2]}

# Rename the columns
names(data) <- c("subject.id", "activity", as.character(features$V1))

# Turn the data frame into a tibble
data <- as.tbl(data)

####################################################################
# QUESTION 2
####################################################################
# Extract only the measurements on the mean and std
data <- select(data, -(matches("[0-9]")))

####################################################################
# QUESTION 3
####################################################################
# Use descriptive activity names in the data set
data$activity <- activity_labels$V2[data$activity]

# Make the descriptions lower-case, and remove underscores
data$activity <- tolower(data$activity)
data$activity <- gsub("_", " ", data$activity)

####################################################################
# QUESTION 4
####################################################################
# Label data set with descriptive variable names
names(data) <- gsub("tBodyAcc-", "Time.Domain.Body.Acceleration.", names(data))
names(data) <- gsub("tGravityAcc-", "Time.Domain.Gravity.Acceleration.", names(data))
names(data) <- gsub("tBodyAccJerk-", "Time.Domain.Body.Acceleration.Jerk.", names(data))
names(data) <- gsub("tBodyGyro-", "Time.Domain.Body.Acceleration.Gyroscope.", names(data))
names(data) <- gsub("tBodyGyroJerk-", "Time.Domain.Body.Acceleration.Gyroscope.Jerk.", names(data))
names(data) <- gsub("tBodyAccMag-", "Time.Domain.Body.Acceleration.Magnitude.", names(data))
names(data) <- gsub("tGravityAccMag-", "Time.Domain.Gravity.Acceleration.Magnitude.", names(data))
names(data) <- gsub("tBodyAccJerkMag-", "Time.Domain.Body.Acceleration.Jerk.Magnitude.", names(data))
names(data) <- gsub("tBodyGyroMag-", "Time.Domain.Body.Gyroscope.Magnitude.", names(data))
names(data) <- gsub("tBodyGyroJerkMag-", "Time.Domain.Body.Gyroscope.Jerk.Magnitude.", names(data))
names(data) <- gsub("fBodyAcc-", "Frequency.Domain.Body.Acceleration.", names(data))
names(data) <- gsub("fBodyAccJerk-", "Frequency.Domain.Body.Acceleration.Jerk.", names(data))
names(data) <- gsub("fBodyGyro-", "Frequency.Domain.Body.Gyroscope.", names(data))
names(data) <- gsub("fBodyAccMag-", "Frequency.Domain.Body.Acceleration.Magnitude.", names(data))
names(data) <- gsub("fBodyBodyAccJerkMag-", "Frequency.Domain.Body.Acceleration.Jerk.Magnitude.", names(data))
names(data) <- gsub("fBodyBodyGyroMag-", "Frequency.Domain.Body.Gyroscope.Magnitude.", names(data))
names(data) <- gsub("fBodyBodyGyroJerkMag-", "Frequency.Domain.Body.Gyroscope.Jerk.Magnitude.", names(data))

names(data) <- gsub("mean\\(\\)", "Mean", names(data))
names(data) <- gsub("std\\(\\)", "Std", names(data))
names(data) <- gsub("-", ".", names(data))

####################################################################
# QUESTION 5
####################################################################
# Create tidy data set with avg of each variable for each activity/subject
tidy_data <- data %>% group_by(subject.id, activity) %>% summarise_all(mean)

# Save the tidy data as a .txt file
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)