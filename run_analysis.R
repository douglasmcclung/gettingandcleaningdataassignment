library(dataMaid)
library(dplyr)

originalWorkingDirectory <- "c:\\Users\\doug.mcclung\\Documents"

##
# Read in Test data
setwd(".\\UCI HAR Dataset\\test")

xTest <- read.table("X_Test.txt", header = FALSE, sep = "", dec = ".")
yTest <- read.table("y_Test.txt", header = FALSE, sep = "", dec = ".")
subjectTest <- read.table("subject_test.txt", header = FALSE, sep = "", dec = ".")
#str(xTest)
#str(yTest)
#str(subjectTest)


##
# Read in Train data
setwd(originalWorkingDirectory)
setwd(".\\UCI HAR Dataset\\train")

xTrain <- read.table("X_Train.txt", header = FALSE, sep = "", dec = ".")
yTrain <- read.table("y_Train.txt", header = FALSE, sep = "", dec = ".")
subjectTrain <- read.table("subject_train.txt", header = FALSE, sep = "", dec = ".")
# str(xTrain)
# str(yTrain)
# str(subjectTrain)


##
# Merge Test sets into one set by combining columns
test <- bind_cols(subjectTest, yTest, xTest)
#str(test)

# Merge Train sets into one set by combining columns
train <- bind_cols(subjectTrain, yTrain, xTrain)
#str(train)

# Merge Test and Train sets into one set by combining rows
allData <- bind_rows(test, train)
#str(allData)


## Filter columns to only Mean and STD columns and adjust column numbers in V1 by +2 because we added two columns in the binding step above
setwd(originalWorkingDirectory)
setwd(".\\UCI HAR Dataset")

columns <- read.table("features.txt", header = FALSE, sep = "") %>%
    filter(grepl("mean()", V2, fixed = TRUE) | grepl("std()", V2, fixed = TRUE)) %>%
    mutate(V1 = V1 + 2)
#columns

# Select only the columns identified in step above in the allData data set (plus the first two "key" columns) 
filteredData <- bind_cols(allData[1:2], allData[paste("V", columns$V1, sep = "")])
#str(filteredData)


## Assign appropriate activity names
activityNames <- read.table("activity_labels.txt", header = FALSE, sep = "")

filteredData <- inner_join(filteredData, activityNames, by = c("V1100" = "V1"))
#str(filteredData)


##
# Rename variables/columns
filteredData <- filteredData %>%
    rename(Subject = V1
           , Activity = V2
           , "tBodyAcc-mean()-X" = V3
           , "tBodyAcc-mean()-Y" = V4
           , "tBodyAcc-mean()-Z" = V5
           , "tBodyAcc-std()-X" = V6            
           , "tBodyAcc-std()-Y" = V7
           , "tBodyAcc-std()-Z" = V8
           , "tGravityAcc-mean()-X" = V43
           , "tGravityAcc-mean()-Y" = V44
           , "tGravityAcc-mean()-Z" = V45
           , "tGravityAcc-std()-X" = V46
           , "tGravityAcc-std()-Y" = V47
           , "tGravityAcc-std()-Z" = V48
           , "tBodyAccJerk-mean()-X" = V83
           , "tBodyAccJerk-mean()-Y" = V84
           , "tBodyAccJerk-mean()-Z" = V85
           , "tBodyAccJerk-std()-X" = V86
           , "tBodyAccJerk-std()-Y" = V87
           , "tBodyAccJerk-std()-Z" = V88
           , "tBodyGyro-mean()-X" = V123
           , "tBodyGyro-mean()-Y" = V124
           , "tBodyGyro-mean()-Z" = V125
           , "tBodyGyro-std()-X" = V126
           , "tBodyGyro-std()-Y" = V127
           , "tBodyGyro-std()-Z" = V128
           , "tBodyGyroJerk-mean()-X" = V163
           , "tBodyGyroJerk-mean()-Y" = V164
           , "tBodyGyroJerk-mean()-Z" = V165
           , "tBodyGyroJerk-std()-X" = V166
           , "tBodyGyroJerk-std()-Y" = V167
           , "tBodyGyroJerk-std()-Z" = V168
           , "tBodyAccMag-mean()" = V203
           , "tBodyAccMag-std()" = V204
           , "tGravityAccMag-mean()" = V216
           , "tGravityAccMag-std()" = V217
           , "tBodyAccJerkMag-mean()" = V229
           , "tBodyAccJerkMag-std()" = V230
           , "tBodyGyroMag-mean()" = V242
           , "tBodyGyroMag-std()" = V243
           , "tBodyGyroJerkMag-mean()" = V255
           , "tBodyGyroJerkMag-std()" = V256
           , "fBodyAcc-mean()-X" = V268
           , "fBodyAcc-mean()-Y" = V269
           , "fBodyAcc-mean()-Z" = V270
           , "fBodyAcc-std()-X" = V271
           , "fBodyAcc-std()-Y" = V272
           , "fBodyAcc-std()-Z" = V273
           , "fBodyAccJerk-mean()-X" = V347
           , "fBodyAccJerk-mean()-Y" = V348
           , "fBodyAccJerk-mean()-Z" = V349
           , "fBodyAccJerk-std()-X" = V350
           , "fBodyAccJerk-std()-Y" = V351
           , "fBodyAccJerk-std()-Z" = V352
           , "fBodyGyro-mean()-X" = V426
           , "fBodyGyro-mean()-Y" = V427
           , "fBodyGyro-mean()-Z" = V428
           , "fBodyGyro-std()-X" = V429
           , "fBodyGyro-std()-Y" = V430
           , "fBodyGyro-std()-Z" = V431
           , "fBodyAccMag-mean()" = V505
           , "fBodyAccMag-std()" = V506
           , "fBodyBodyAccJerkMag-mean()" = V518
           , "fBodyBodyAccJerkMag-std()" = V519
           , "fBodyBodyGyroMag-mean()" = V531
           , "fBodyBodyGyroMag-std()" = V532
           , "fBodyBodyGyroJerkMag-mean()" = V544
           , "fBodyBodyGyroJerkMag-std()" = V545)

#str(filteredData)


## summarize data by subject and activity.  Calculate mean and standard dev.
summarizedData <- filteredData %>%
    group_by(Subject, Activity) %>%
    summarise_all(funs(mean, sd))
#str(summarizedData)


##
# Output data sets to .csv files
write.table(filteredData, file = "Combined Data.csv", row.names = FALSE, na = "", col.names = FALSE, sep = ",")
write.table(summarizedData, file = "Summarized Data.csv", row.names = FALSE, na = "", col.names = FALSE, sep = ",")


##
# Generate codebooks
makeCodebook(filteredData, replace = TRUE)
makeCodebook(summarizedData, replace = TRUE)


