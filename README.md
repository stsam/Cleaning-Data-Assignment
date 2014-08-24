Cleaning-Data-Assignment
========================
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. Files submitted: 

1) a tidy data 

2) a R file with the codes

3) a code book that describes the variables

4) a Readme with the description

The R script called run_analysis.R that does:

1) Merges the training and the test sets to create one data set.

2) Extracts only the measurements on the mean and standard deviation for each measurement. 

3) Uses descriptive activity names to name the activities in the data set

4) Appropriately labels the data set with descriptive variable names. 

5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Process used

1) First connect to the URL and download the file if it does not exist

2) Unzip the file and store the files

3) Combine the test files: x_test, y_test and subject_test

4) Combine the train files: x_test, y_test and subject_train

5) Combine the test and trian file

6) read the activity labels and features

7) subset the features to match std and mean

8) subset the data set to match std and mean

9) use the activity labels and modify the data file to have labels

10) create a second independent tidy data set with the average of each variable for each

11) write tidy data to file

12) write codebook to file