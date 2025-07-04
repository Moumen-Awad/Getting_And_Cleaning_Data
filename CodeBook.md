# CodeBook

This code book describes the variables, data, and transformations performed to clean up the UCI HAR Dataset.

## Source Data

Original dataset: [UCI HAR Dataset](https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones)

## Data Description

The dataset includes accelerometer and gyroscope measurements from a Samsung Galaxy S smartphone worn by 30 subjects performing 6 activities.

## Variables

- `subject`: Identifier of the subject (1 to 30)
- `activity`: Activity performed (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
- Measurement variables: Averages of mean and standard deviation features extracted from the original dataset. Examples include:
  - `TimeBodyAccelerometerMeanX`
  - `TimeBodyAccelerometerSTDY`
  - `FrequencyBodyGyroscopeMeanZ`
  - ...

## Transformations

1. Merged training and test datasets.
2. Extracted only measurements on the mean and standard deviation.
3. Replaced activity codes with descriptive names.
4. Cleaned variable names for clarity.
5. Created a tidy dataset with the average of each variable for each activity and each subject.
