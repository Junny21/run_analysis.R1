CodeBook.md

#Here I used preprocessed data that was obtained from a study were the six human activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING), were measured using smartphones. There were 30 participants in these study.
## Step 1: I downloaded the files containing the preprocessed data from (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 
### The files contain data that have been splitted into test and train datasets. 
### I read the subject, activity and features data for these two groups into tables
### I pull that data for the 3 categories (subject, activity and features) into one data frame using rbind
### I named the respective columns with appropriate names
### Next I did column bind to combine the test and train data sets
#### I computed the mean and stdev for the respective measurements using the select function in the "dplyr" package

### I created a second, independent tidy data set with the average of each variable for each activity and each subject. 
