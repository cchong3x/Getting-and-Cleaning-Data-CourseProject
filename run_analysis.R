setwd("C:/Users/user/Documents/PRJ_GetCleanData")

## Step 1: Merges the training and the test sets to create one data set
## Reads a file in table format and creates a data frame from it
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
test.data <- read.table("UCI HAR Dataset/test/x_test.txt")
test.activity <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Activity")

## Reads a file in table format and creates a data frame from it
train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
train.data <- read.table("UCI HAR Dataset/train/x_train.txt")
train.activity <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Activity")


## Combine data frame by rows / add rows to the bottom
## data.all <- rbind(train.combine, test.combine)
all.subject <- rbind(train.subject, test.subject)
all.data <- rbind(train.data, test.data)
all.activity <- rbind(train.activity, test.activity)

## Step 2: Extracts the measurements on the mean and standard deviation for each measurement. 
features <- read.table("UCI HAR Dataset/features.txt")

## Subset only measurements for the mean and standard deviation.
indices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
all.data <- all.data[, indices]
names(all.data) <- features[indices, 2]
names(all.data) <- gsub("\\(|\\)", "", names(all.data))
names(all.data) <- tolower(names(all.data))


## Step 3: Uses descriptive activity names to name the activities in the data set
activity.label <- read.table("UCI HAR Dataset/activity_labels.txt")
all.activity[,1] = activity.label[all.activity[,1], 2]

## Step 4: Appropriately labels the data set with descriptive variable names. 
all.combine <- cbind(all.subject, all.activity, all.data)

## Step 5: Tidy data set with the average of each variable for each activity and each subject
library(plyr)
tidy.data <- aggregate(all.combine$Subject + all.combine$Activity, all.combine, mean)
write.table(tidy.data, file = "tidydata.txt",row.name=FALSE)

