# run_analysis.R-

##Download file into a newly created folder called "data"
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

###The file was downloaded as a zip file
###upzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

###Display the files
path <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path, recursive=T)
files

###The train and test files ....

activity_test  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = F)
activity_train <- read.table(file.path(path, "train", "Y_train.txt"),header = F)
subject_train <- read.table(file.path(path, "train", "subject_train.txt"),header = F)
subject_test  <- read.table(file.path(path, "test" , "subject_test.txt"),header = F)
features_test  <- read.table(file.path(path, "test" , "X_test.txt" ),header = F)
features_train <- read.table(file.path(path, "train", "X_train.txt"),header = F)


###Merge files rbind for test and train values for the subject, activity and features
subject <- rbind(subject_train, subject_test)
activity<- rbind(activity_train, activity_test)
features<- rbind(features_train, features_test)

###Names to the columns....
names(subject)<-c("subject")
names(activity)<- c("activity")
features_names <- read.table(file.path(path, "features.txt"),head=F)
names(features)<- features_names$V2

###Merge subject, activity and features into a big dataframe called "Data"
Data <- cbind(subject,activity,features)
head(Data)

### Install the dplyr package which will be use for downstream applications
install.packages("dplyr")
library(dplyr)

###-The mean and standard deviation for each measurement.
Name_MEAN_STDev<-c(as.character(MEAN_STDev), "subject", "activity" )
Data1<-subset(Data,select=Name_MEAN_STDev)
head(Data1)
Data <- Data[, !duplicated(colnames(Data))]
Data2<- select(Data,contains("subject"), contains("Activity"), contains("mean"), contains("std"))
head(Data2)

### Use descriptive activity names as in the original file to name the activities in the data set
activity_labels <- read.table(file.path(path, "activity_labels.txt"),header = F)
Data2$activity<- factor(Data2$activity, labels = activity_labels[,2])


### Independent tidy data set with the average of each variable for each activity and each subject.
Data3<- (Data2%>% group_by(subject,activity) %>% summarize_each(funs( mean)))




