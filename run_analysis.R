# run_analysis.R
# This script performs data cleaning and tidying for the UCI HAR Dataset

# Load required library
library(dplyr)

# Step 1: Download and unzip the dataset
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
destfile <- "UCI_HAR_Dataset.zip"
download.file(url, destfile, method = "auto")
unzip(destfile)

# Step 2: Load the data
data_path <- "UCI HAR Dataset"

features <- read.table(file.path(data_path, "features.txt"), col.names = c("index", "feature"))
activities <- read.table(file.path(data_path, "activity_labels.txt"), col.names = c("code", "activity"))

subject_train <- read.table(file.path(data_path, "train", "subject_train.txt"), col.names = "subject")
x_train <- read.table(file.path(data_path, "train", "X_train.txt"))
y_train <- read.table(file.path(data_path, "train", "y_train.txt"), col.names = "activity")

subject_test <- read.table(file.path(data_path, "test", "subject_test.txt"), col.names = "subject")
x_test <- read.table(file.path(data_path, "test", "X_test.txt"))
y_test <- read.table(file.path(data_path, "test", "y_test.txt"), col.names = "activity")

# Assign column names to x_train and x_test
colnames(x_train) <- features[, 2]
colnames(x_test) <- features[, 2]

# Step 3: Merge the training and test sets
train_data <- cbind(subject_train, y_train, x_train)
test_data <- cbind(subject_test, y_test, x_test)
merged_data <- rbind(train_data, test_data)

# Step 4: Extract only the measurements on the mean and standard deviation
selected_features <- grep("mean\(\)|std\(\)", features$feature)
selected_columns <- c(1, 2, selected_features + 2)
extracted_data <- merged_data[, selected_columns]

# Step 5: Use descriptive activity names
extracted_data$activity <- factor(extracted_data$activity,
                                  levels = activities$code,
                                  labels = activities$activity)

# Step 6: Label the dataset with descriptive variable names
names <- colnames(extracted_data)
names <- gsub("^t", "Time", names)
names <- gsub("^f", "Frequency", names)
names <- gsub("Acc", "Accelerometer", names)
names <- gsub("Gyro", "Gyroscope", names)
names <- gsub("Mag", "Magnitude", names)
names <- gsub("BodyBody", "Body", names)
names <- gsub("-mean\(\)", "Mean", names)
names <- gsub("-std\(\)", "STD", names)
names <- gsub("-", "", names)
colnames(extracted_data) <- names

# Step 7: Create a tidy dataset with the average of each variable for each activity and each subject
tidy_data <- extracted_data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

# Save the tidy dataset
write.table(tidy_data, "tidy_dataset.txt", row.name = FALSE)
