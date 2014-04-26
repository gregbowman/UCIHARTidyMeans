library(reshape2)
library(data.table)
##
## 1. ACTIVITY LABELS
## activites data.frame will be used to label the Activity Factor
##  using descriptive names
##
fileActivityLabels <- "UCI HAR Dataset/activity_labels.txt"
activityLabels <- read.table(fileActivityLabels)

##
## 2. FEATURES
## create two vectors:
## featureFields is the column numbers of the measures to be extracted
## featureFieldNames is the list of labels for the extracted measurements
##
fileFeatures <- "UCI HAR Dataset/features.txt"
features <- read.table(fileFeatures,sep=" ")
names(features) <- c("columnNumber", "fieldName")
features <- features[grep("(mean|std)\\(\\)", features$fieldName),]
featureFields <- as.vector(features[,1])
featureFieldNames <- as.vector(features[,2])

##
## 3. SUBJECTS
## combine subject vectors for test subjects and train subjects
##
fileSubjectTest <- "UCI HAR Dataset/test/subject_test.txt"
fileSubjectTrain <- "UCI HAR Dataset/train/subject_train.txt"
subjectTest <- read.table(fileSubjectTest)
subjectTrain <- read.table(fileSubjectTrain)

subject <- rbind(subjectTest,subjectTrain)
names(subject) <- c("Subject")
subject <- factor(subject$Subject)

##
## 4. ACTIVITY
## combine the activity identifiers from the test and train groups
## apply factor labels to make them more descriptive
##
fileActivityTest <- "UCI HAR Dataset/test/Y_test.txt"
fileActivityTrain <- "UCI HAR Dataset/train/Y_train.txt"
activityTest <- read.table(fileActivityTest)
activityTrain <- read.table(fileActivityTrain)

activity <- rbind(activityTest, activityTrain)
names(activity) <- c("Activity")
activity <- factor(activity$Activity,labels = as.character(activityLabels[,2]))

##
## 5. MEASURES
## combine the measurements from the test and train groups
## select only those measures that are means or std.dev
##
fileMeasuresTest <- "UCI HAR Dataset/test/X_test.txt"
fileMeasuresTrain <- "UCI HAR Dataset/train/X_train.txt"
measuresTest <- read.table(fileMeasuresTest)
measuresTrain <- read.table(fileMeasuresTrain)
# apply the feature field names to the measurements
measures <- rbind(measuresTest[,featureFields],measuresTrain[,featureFields])

##
## 6. COMBINE
## combine activity, subject, and measure data
##
measures <- data.frame(activity,subject,measures)
## assign the column names based on the extractd features
names(measures) <- c("Activity","Subject",featureFieldNames)

##
## 7. AGGREGATE
## melt into a data table to streamline mean calculation
##
dtMolten <- as.data.table(melt(measures,id = c("Activity","Subject")))
setkey(dtMolten,Activity,Subject,variable)
## take means of all the extracted measures
dtMoltenMean <- dtMolten[,mean(value),by="Activity,Subject,variable"]

##
## 8. RECAST
## cast feature measurement means back into rows and columns
##
UCIHARTidyMeans <- dcast(dtMoltenMean, formula = Activity + Subject ~ variable, value.var = "V1")

##
## 9. OUTPUT
## save .RData version of dataset
save(UCIHARTidyMeans,file="UCIHARTidyMeans.RData")
## write text version of dataset
write.table(UCIHARTidyMeans,file="UCIHARTidyMeans.txt")

## release memory
rm(measures,dtMolten,dtMoltenMean)