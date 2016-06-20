## GETTING AND CLEANING DATA COURSE PROJECT
## LIZ WOELFEL


#________________________________________________________________________________
##1. MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET
#READING IN THE TRAINING & TEST DATA SETS & LABELS COLUMNS
feature.names <- read.table('./features.txt')

#READ TEST DATA
test <- read.table('./test/X_test.txt')
        colnames(test) <- feature.names$V2
test.subject <- read.table('./test/subject_test.txt', col.names="subject")
test.activity <- read.table('./test/y_test.txt', col.names="activity")
test.data <- cbind(test,test.subject,test.activity)

#READ TRAIN DATA
train <- read.table('./train/X_train.txt')
        colnames(train) <- feature.names$V2
train.subject <- read.table('./train/subject_train.txt', col.names="subject")
train.activity <- read.table('./train/y_train.txt', col.names="activity")
train.data <- cbind(train,train.subject,train.activity)

#MERGE TRAINING & TEST DATA SETS BY SUBJECT
        #choosing rbind as opposed to merge because we want to join the two data sets vertically
        #They have the same variables, and each is a subset of the total subjects
merged.data <- rbind(train.data,test.data)


#________________________________________________________________________________
##2. EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
names <- names(merged.data)
filtered.names <- grepl("subject|activity|mean|meanFreq|std", names)
filtered.names
filtered.merged.data = merged.data[, filtered.names]
names(filtered.merged.data)


#________________________________________________________________________________
##3. USES ONLY DESCRIPTIVE NAMES FOR THE ACTIVITIES IN THE DATA SET
library(plyr)
filtered.merged.data$activity <- mapvalues(filtered.merged.data$activity, 
                                           from = c(1:6), 
                                           to = c("walking", 
                                                  "walking_upstairs",
                                                  "walking_downstairs",
                                                  "sitting",
                                                  "standing",
                                                  "laying"))
table(filtered.merged.data$activity)



#_______________________________________________________________________________
##4. APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
filtered.names.relabel <- names(filtered.merged.data)
filtered.names.relabel <- gsub("\\(\\)", "", filtered.names.relabel)
filtered.names.relabel <- gsub("Gyro", "-gyroscope", filtered.names.relabel)
filtered.names.relabel <- gsub("Acc", "-accelerometer", filtered.names.relabel)
filtered.names.relabel <- gsub("Jerk", "-jerk", filtered.names.relabel)
filtered.names.relabel <- gsub("Mag", "-magnitude", filtered.names.relabel)
filtered.names.relabel <- gsub("BodyBody", "body", filtered.names.relabel)
filtered.names.relabel <- gsub("^t", "time", filtered.names.relabel)
filtered.names.relabel <- gsub("^f", "freq", filtered.names.relabel)
filtered.names.relabel <- tolower(filtered.names.relabel)
filtered.names.relabel

colnames(filtered.merged.data) <- filtered.names.relabel




#_______________________________________________________________________________
##5. FROM THE DATA SET IN STEP 4, CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH
        ##AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
filtered.merged.data$subject <- as.factor(filtered.merged.data$subject)
tidy.data <- aggregate(. ~subject + activity, filtered.merged.data, mean)
tidy.data <- tidy.data[order(tidy.data$subject,tidy.data$activity),]
write.csv(tidy.data, file = "tidy.data.csv", row.names = FALSE)

