# First download the data set

file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file, destfile = "UCI_HAR_Dataset.zip", method = "curl")

# The data will be unzipped into a directory called "UCI HAR Dataset"

unzip("UCI_HAR_Dataset.zip")

print("Completed Download and Unzip", quote = FALSE)

# Begin in the root directory with the files "features.txt" and "activity_labels.txt"
# "features.txt" is the list of all features
# "activity_labels.txt" links the class labels with their activity name

features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

# The data are contained in 2 directories: "test" and "train"
# Each directory contains 3 files

# 1. "train/subject_train.txt" contains rows where each row identifies the subject who performed the activity for each window sample
# 2. "train/X_train.txt" is the training set
# 3. "train/y_train.txt" contains the training labels

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)

# 1. "test/subject_train.txt" contains rows where each row identifies the subject who performed the activity for each window sample
# 2. "test/X_test.txt" is the test set
# 3. "test/y_test.txt" contains the test labels

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)

print("Completed reading all the data", quote = FALSE)

# There are 5 steps to perform:
# 1. Merge the training and the test sets to create one data set
# 2. Extract only the measurements on the mean and standard deviation for each measurement 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names 
# 5. From the data set in step 4, create a second, independent tidy data set
#    with the average of each variable for each activity and each subject

# ---------------------------------------------------------------------+
# Step 1 - Merge the training and the test sets to create one data set |
# ---------------------------------------------------------------------+

merged_subject <- rbind(subject_train, subject_test)
merged_X <- rbind(X_train, X_test)
merged_y <- rbind(y_train, y_test)

# Add column names

colnames(merged_subject) <- "Subject"
colnames(merged_X) <- features$V2
colnames(merged_y) <- "Activity"

# Combine all the data

merged_all <- cbind(merged_subject, merged_y, merged_X)

print("Completed Step 1", quote = FALSE)

# -----------------------------------------------------------------------------------------------+
# Step 2 - Extract only the measurements on the mean and standard deviation for each measurement |
# -----------------------------------------------------------------------------------------------+

# Assumption: anywhere mean() and std() appear in the label name
# Start by getting the list of columns

merged_all_mean_std_columns <- grep("*mean\\(\\)*|*std\\(\\)*", names(merged_all), value = TRUE)

# Now use the column list to reduce the data to just the columns we need and include the Subject and Activity

merged_all <- merged_all[, c("Subject", "Activity", merged_all_mean_std_columns)]

print("Completed Step 2", quote = FALSE)

# -------------------------------------------------------------------------------+
# Step 3 - Use descriptive activity names to name the activities in the data set |
# -------------------------------------------------------------------------------+

# Replace the numeric activity values with their descriptions

merged_all$Activity <- factor(merged_all$Activity, levels = activity_labels$V1, labels = activity_labels$V2)

print("Completed Step 3", quote = FALSE)

# --------------------------------------------------------------------------+
# Step 4 - Appropriately label the data set with descriptive variable names |
# --------------------------------------------------------------------------+

# Start with any columns beginning with "t" and "f" and replace with suitable names

names(merged_all) <- gsub("^t", "Time", names(merged_all))
names(merged_all) <- gsub("^f", "Frequency", names(merged_all))

# Substiture more descriptive names in some other columns

names(merged_all) <- gsub("Acc", "Accelerometer", names(merged_all), fixed = TRUE)
names(merged_all) <- gsub("Mag", "Magnitude", names(merged_all), fixed = TRUE)

# Finally, clean-up mean() and std()

names(merged_all) <- gsub("mean()", "Mean", names(merged_all), fixed = TRUE)
names(merged_all) <- gsub("std()", "StandardDeviation", names(merged_all), fixed = TRUE)

print("Completed Step 4", quote = FALSE)

# ---------------------------------------------------------------------------------+
# Step 5 - From the data set in step 4, create a second, independent tidy data set |
#          with the average of each variable for each activity and each subject    |
# ---------------------------------------------------------------------------------+

# There are two ways to prepare the tidy data set: wide row or wide column

# 1. Wide row approach is ths simplest
# Skip the first two columns and use columns 3 to 66

tidy_data <- aggregate(merged_all[, 3:66], by = list(merged_all$Subject, merged_all$Activity), FUN = mean)

# Restore Subject and Activity column names

names(tidy_data) <- gsub("Group.1", "Subject", names(tidy_data), fixed = TRUE)
names(tidy_data) <- gsub("Group.2", "Activity", names(tidy_data), fixed = TRUE)

# 2. Wide column approach requires the "reshape2" package
# Code commented out as we will use the wide row approach

# melt_data <- melt(merged_all, id.vars = c("Activity", "Subject"))
# tidy_data <- dcast(melt_data, Activity + Subject ~ variable, mean)

# Write the data out to file

write.table(tidy_data, file = "tidy_data.txt", sep = ",", row.names = FALSE, quote = FALSE)

print("Completed Step 5", quote = FALSE)
