## Cleaning Data Project - Coursera
## Author: Cecilia Escalante
## Date: April 18th, 2016

## Clean
rm(list = ls())

## download data

library(foreign)

## Download the zipped data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Unzip

## The data is in the UCI Har Dataset folder

setwd("~/2.EDUCATION/DataScience/UCI HAR Dataset")

## This folder contains information about training and test for 30 subjects.
## According to the information found in "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones" site, we know that:
  ## 'train/X_train.txt': Training set.
  ## 'train/y_train.txt': Training labels.
  ## 'test/X_test.txt': Test set.
  ## 'test/y_test.txt': Test labels.
  ## 'features_info.txt': Shows information about the variables used on the feature vector.
  ## 'features.txt': List of all features.
  ## 'activity_labels.txt': Links the class labels with their activity name.


## In this first part I am aiming to : Merge the training and the test sets to create one data set.

## We read first the data that it is common for the training and test sets, that is features
## and activities labels

## read activities' labels
activitylabels <- read.table("activity_labels.txt", header = FALSE)

## look at what we have in activities:
head(activitylabels)
## this is link between activities coded with numbers and with names

## read features' data
features <- read.table("features.txt", header = FALSE)

## take a look at what we have:
head(features)
## the names for the features


## Work first with the training sets:

trainfeat <- read.table("./train/X_train.txt")
trainactivity<- read.table("./train/y_train.txt", header = FALSE)
trainsubjects <- read.table("./train/subject_train.txt", header = FALSE)

## Now work with the test data:

testfeat <- read.table("./test/X_test.txt")
testactivity <- read.table("./test/y_test.txt", header = FALSE)
testsubjects <- read.table("./test/subject_test.txt", header = FALSE)

## Row bind the corresponding test and training data

allfeat <- rbind(trainfeat, testfeat)
allactivity <- rbind(trainactivity, testactivity)
allsubjects <- rbind(trainsubjects, testsubjects)

## Change the names of the 'allfeat' variables from the current form (v1-v561) to be descriptive
## We do this changing the names of the columns using the features data we downloaded

names(allfeat) <- features[,2]

## Rename the variables for the subjects and activity sets

names(allsubjects) <- "subject"
names(allactivity) <- "activity"

## Complete Data

complete.data <- cbind(allsubjects, allactivity, allfeat)

## Extract only the columns with measurements on the mean and standard deviation for each measurement.
## With this code I extract the subject, the activity and the columns that have the measurements for meand and standard deviation
## the first part grabs the columns for subject and activity
## I used the grep command from dplyr to grab the columns that have data for mean or standard deviation


library(dplyr)
mydata <- complete.data[,c(1,2,grep(".*[Mm]ean.*|.*[Ss]td.*", names(complete.data)))]


## Now we want to change the activity names to name the activities in the data set
## Right now it looks like only numbers from 1 to 6
## We renamed the variables for 'mydata' then we know that the variable containing the
## activities is called 'activity':

mydata[, "activity"] <- activitylabels[mydata[, "activity"], 2]


## Now I attempt to 'Appropriately label the data set with descriptive variable names'
# Right now our variables look like this:

names(mydata)

## According to the information found in 'features_info.txt'
## The features in this database come from the accelerometer and gyroscope
## Therefore, "Acc" denotes "accelerometer" and "Gyro", "gyroscope"
## "t" denotes "time"
## "f" denotes "frequency"

## First change the beginning of the lines t and f
names(mydata) <- gsub("^t", "Time", names(mydata))
names(mydata) <- gsub("^f", "Frequency", names(mydata))

## Change Acc for accelerometer and Gyro for gyroscope

names(mydata) <- gsub("Acc", "Accelerometer", names(mydata))
names(mydata) <- gsub("Gyro", "Gyroscope", names(mydata))

## change -mean() and -std() for "Mean" and "STD" 
## there are some variables named 'meanFreq()' I'll change that first

names(mydata) <- gsub(".meanFreq..", "MeanFreq", names(mydata))
names(mydata) <- gsub(".mean..", "Mean", names(mydata))
names(mydata) <- gsub(".std..", "STD", names(mydata))

## What is left is Mag which refers to the "Magnitude of these three-dimensional signals"
## Some that repeat the word Body and the variables that start with 'angle'
names(mydata) <- gsub("Mag", "Magnitude", names(mydata))
names(mydata) <- gsub("BodyBody", "Body", names(mydata))

## for the angle variables:

names(mydata) <- gsub("angle", "Angle", names(mydata))
names(mydata) <- gsub("gravity", "Gravity", names(mydata))
names(mydata) <- gsub("tBody", "TimeBody", names(mydata))

write.table(mydata,  file= "./mydata.txt", row.names = FALSE)

## Finally, create a second, independent tidy data set with the average of
## each variable for each activity and each subject.


library(reshape2)

variables <- as.vector(names(mydata[,3:88]))
meltdata <- melt(mydata, id = c("subject", "activity"), measure.vars = variables)
tidydata <- dcast(meltdata, subject + activity ~ variable, mean)

## for submission

write.table(tidydata, file = './tidydata.txt', row.names = FALSE)


