The zip file named "UCI HART Dataset" contain the following files:
  ## 'train/X_train.txt': Training set.
  ## 'train/y_train.txt': Training labels.
  ## 'test/X_test.txt': Test set.
  ## 'test/y_test.txt': Test labels.
  ## 'features_info.txt': Shows information about the variables used on the feature vector.
  ## 'features.txt': List of all features.
  ## 'activity_labels.txt': Links the class labels with their activity name.

I used this and produced the following sets:

activitylabels: contains the description of activities and the identifier number for those activities. Rows=6, Columns=2
features: contains the variable names of the features measured.  Rows=561   Columns=2

trainfeat : X_train, contains all the features and measurements for training.  Rows=7352, Columns=561
trainactivity: y_train, contains the row identifier of activities for training, is numerical from 1-6.  Rows=7352, Columns=1
trainsubjects: subject_train, contains the row identifier of subjects for training, is numerical from 1-30.  Rows=7352, Columns=1

testfeat : X_train, contains all the features and measurements for test.  Rows=7352, Columns=561
testactivity: y_train, contains the row identifier of activities for test, is numerical from 1-6.  Rows=7352, Columns=1
testsubjects: subject_train, contains the row identifier of subjects for test, is numerical from 1-30.  Rows=7352, Columns=1

activitylabels can be matched with the test/train activity data and features can be matched with the names of train/test feat data.

Once we have all the information loaded in our environment, we can bind the rows of the data pairing the matching test and train data:

allfeat: row binding of trainfeat and testfeat.  Rows=10299, Columns=561
allactivity: row binding of trainactivity and testactivity. Rows=10299, Columns=561
allsubjects: row binding of trainsubjects and testsubjects. Rows=10299, Columns=561

I changed the names of the variables from Vn to descriptive names using:
## Change the features variables for actual labels
names(allfeat) <- features[,2]

## Rename the variables for the subjects and activity sets
names(allsubjects) <- "subject"
names(allactivity) <- "activity"

complete.data: column binding of the allfeat, allactivity and allsubjects. Rows=10299, Columns=563

mydata: data set that contains only the variables that have information about the mean or the standard deviation, the subject id and the activity id.
Rows=10299, Columns= 88


I changed the names of the variables for features to make them more user friendly:
According to the information found in 'features_info.txt'
I changed:

  t for Time
  f for Frequency
  -mean() for Mean
  -std() for STD
  Acc for Accelerometer
  Mag for Magnitude
  GYro for Gyroscope

The variable names are the following:

## names(mydata)
 [1] "subject"                                          
 [2] "activity"                                         
 [3] "TimeBodyAccelerometerMean-X"                      
 [4] "TimeBodyAccelerometerMean-Y"                      
 [5] "TimeBodyAccelerometerMean-Z"                      
 [6] "TimeBodyAccelerometerSTD-X"                       
 [7] "TimeBodyAccelerometerSTD-Y"                       
 [8] "TimeBodyAccelerometerSTD-Z"                       
 [9] "TimeGravityAccelerometerMean-X"                   
[10] "TimeGravityAccelerometerMean-Y"                   
[11] "TimeGravityAccelerometerMean-Z"                   
[12] "TimeGravityAccelerometerSTD-X"                    
[13] "TimeGravityAccelerometerSTD-Y"                    
[14] "TimeGravityAccelerometerSTD-Z"                    
[15] "TimeBodyAccelerometerJerkMean-X"                  
[16] "TimeBodyAccelerometerJerkMean-Y"                  
[17] "TimeBodyAccelerometerJerkMean-Z"                  
[18] "TimeBodyAccelerometerJerkSTD-X"                   
[19] "TimeBodyAccelerometerJerkSTD-Y"                   
[20] "TimeBodyAccelerometerJerkSTD-Z"                   
[21] "TimeBodyGyroscopeMean-X"                          
[22] "TimeBodyGyroscopeMean-Y"                          
[23] "TimeBodyGyroscopeMean-Z"                          
[24] "TimeBodyGyroscopeSTD-X"                           
[25] "TimeBodyGyroscopeSTD-Y"                           
[26] "TimeBodyGyroscopeSTD-Z"                           
[27] "TimeBodyGyroscopeJerkMean-X"                      
[28] "TimeBodyGyroscopeJerkMean-Y"                      
[29] "TimeBodyGyroscopeJerkMean-Z"                      
[30] "TimeBodyGyroscopeJerkSTD-X"                       
[31] "TimeBodyGyroscopeJerkSTD-Y"                       
[32] "TimeBodyGyroscopeJerkSTD-Z"                       
[33] "TimeBodyAccelerometerMagnitudeMean"               
[34] "TimeBodyAccelerometerMagnitudeSTD"                
[35] "TimeGravityAccelerometerMagnitudeMean"            
[36] "TimeGravityAccelerometerMagnitudeSTD"             
[37] "TimeBodyAccelerometerJerkMagnitudeMean"           
[38] "TimeBodyAccelerometerJerkMagnitudeSTD"            
[39] "TimeBodyGyroscopeMagnitudeMean"                   
[40] "TimeBodyGyroscopeMagnitudeSTD"                    
[41] "TimeBodyGyroscopeJerkMagnitudeMean"               
[42] "TimeBodyGyroscopeJerkMagnitudeSTD"                
[43] "FrequencyBodyAccelerometerMean-X"                 
[44] "FrequencyBodyAccelerometerMean-Y"                 
[45] "FrequencyBodyAccelerometerMean-Z"                 
[46] "FrequencyBodyAccelerometerSTD-X"                  
[47] "FrequencyBodyAccelerometerSTD-Y"                  
[48] "FrequencyBodyAccelerometerSTD-Z"                  
[49] "FrequencyBodyAccelerometerMeanFreq-X"             
[50] "FrequencyBodyAccelerometerMeanFreq-Y"             
[51] "FrequencyBodyAccelerometerMeanFreq-Z"             
[52] "FrequencyBodyAccelerometerJerkMean-X"             
[53] "FrequencyBodyAccelerometerJerkMean-Y"             
[54] "FrequencyBodyAccelerometerJerkMean-Z"             
[55] "FrequencyBodyAccelerometerJerkSTD-X"              
[56] "FrequencyBodyAccelerometerJerkSTD-Y"              
[57] "FrequencyBodyAccelerometerJerkSTD-Z"              
[58] "FrequencyBodyAccelerometerJerkMeanFreq-X"         
[59] "FrequencyBodyAccelerometerJerkMeanFreq-Y"         
[60] "FrequencyBodyAccelerometerJerkMeanFreq-Z"         
[61] "FrequencyBodyGyroscopeMean-X"                     
[62] "FrequencyBodyGyroscopeMean-Y"                     
[63] "FrequencyBodyGyroscopeMean-Z"                     
[64] "FrequencyBodyGyroscopeSTD-X"                      
[65] "FrequencyBodyGyroscopeSTD-Y"                      
[66] "FrequencyBodyGyroscopeSTD-Z"                      
[67] "FrequencyBodyGyroscopeMeanFreq-X"                 
[68] "FrequencyBodyGyroscopeMeanFreq-Y"                 
[69] "FrequencyBodyGyroscopeMeanFreq-Z"                 
[70] "FrequencyBodyAccelerometerMagnitudeMean"          
[71] "FrequencyBodyAccelerometerMagnitudeSTD"           
[72] "FrequencyBodyAccelerometerMagnitudeMeanFreq"      
[73] "FrequencyBodyAccelerometerJerkMagnitudeMean"      
[74] "FrequencyBodyAccelerometerJerkMagnitudeSTD"       
[75] "FrequencyBodyAccelerometerJerkMagnitudeMeanFreq"  
[76] "FrequencyBodyGyroscopeMagnitudeMean"              
[77] "FrequencyBodyGyroscopeMagnitudeSTD"               
[78] "FrequencyBodyGyroscopeMagnitudeMeanFreq"          
[79] "FrequencyBodyGyroscopeJerkMagnitudeMean"          
[80] "FrequencyBodyGyroscopeJerkMagnitudeSTD"           
[81] "FrequencyBodyGyroscopeJerkMagnitudeMeanFreq"      
[82] "Angle(TimeBodyAccelerometerMean,Gravity)"         
[83] "Angle(TimeBodyAccelerometerJerkMean),GravityMean)"
[84] "Angle(TimeBodyGyroscopeMean,GravityMean)"         
[85] "Angle(TimeBodyGyroscopeJerkMean,GravityMean)"     
[86] "Angle(X,GravityMean)"                             
[87] "Angle(Y,GravityMean)"                             
[88] "Angle(Z,GravityMean)"                             
                    

To generate an independent tidy data set with the average of each variable for each activity and each subject.

First I have to define the measure variables, we want all but the subject and activity, which are our id variables.
I created the vector:
variables <- as.vector(names(mydata[,3:88])) ## contains the names of the measurement variables

meltdata: is the melted data that contains the average for each activity and each subject
tidydata: is the data created for submission, this comes from the meltdata set.   


