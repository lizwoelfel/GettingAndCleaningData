---
title: "CodeBook"
author: "Liz Woelfel"
date: "June 19, 2016"
output: html_document

###GETTING AND CLEANING DATA
---
#CODE BOOK
The purpose of this code book is to describe the variables, the data, and transformations
performed to complete the Getting and Cleaning Data Course Project

#VARIABLES & DATA
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The following data sets and variables within are leveraged:
        1. 'features.txt': List of all features. (561 variable names)
        
        2. 'train/X_train.txt': Training set. (7352 observations, 561 variables)
        
        3. 'train/y_train.txt': Training labels.  (6 labels for activities)
        
        4. 'test/X_test.txt': Test set.  (2947 observations, 561 variables)
        5. 'test/y_test.txt': Test labels. (6 labels for activities)
        6. 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. (1:30 label for subject)
        7. 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. (1:30 label for subject)


#DATA PROCESSING IN R SCRIPT
1. Training and test data sets read in individually and columns labeled appropriately.
2. Data sets merged to create one data set representing all 30 subjects
3. There were 561 measurement variables in the train/test datasets. The merged data was subset to only include measurement variables that calculate the mean or standard deviation.
4. There are six activity types in the data set, originally coded as a numeric vector.  The levels of this variable were edited to represent descriptive names for the six activities performed.
5. Measurement variable names within the data set included many abbreviations and did not follow tidy principals. Code includes redefining more interpretable, descriptive variable names.
6. Finally, a tidy data set is created that includes the average calculation of each measurement variable for each activity and each subject.
