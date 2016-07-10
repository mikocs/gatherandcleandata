## Coursera Getting and Cleaning Data course assignment

## the following script downloads a zipped dataset for the project from the URL
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## tidies the dataset, run several analysis steps, and saves a tidy dataset with the name
## "final_dataset.csv".

## Explanation of the tidied dataset are in the Code Book available in this Project.

## the script generates a 'data' folder and several subfolders. It is recommended
## to run in an empty folder.
library(data.table)
library(dplyr)

run_analysis <- function() {
        
        ## the repository with all data is available at:
        ## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        
        ## create a data folder if it doesn't exist
        if (!file.exists('./data')) {
                dir.create('./data')
        }
        
        ## download the zip file to the data folder, if it doesn't alredy exist
        ## since we are downloading from a network source, this step can take some time\
        if (!file.exists('./Dataset.zip')) {
                download.file(fileURL, destfile = "./Dataset.zip")
        }
        
        ## unzip the dataset to our data folder
        ## this will create a new folder called "UCI HAR Dataset".
        ## it will also overwrite any already extracted data.
        unzip('./Dataset.zip', exdir = './data', overwrite = TRUE)
        
        ## load the required datasets
        activity_labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt')
        features <- read.table('./data/UCI HAR Dataset/features.txt')
        
        subject_test <- read.table('./data/UCI HAR Dataset/test/subject_test.txt')
        X_test <- read.table('./data/UCI HAR Dataset/test/X_test.txt')
        y_test <- read.table('./data/UCI HAR Dataset/test/y_test.txt')
        
        subject_train <- read.table('./data/UCI HAR Dataset/train/subject_train.txt')
        X_train <- read.table('./data/UCI HAR Dataset/train/X_train.txt')
        y_train <- read.table('./data/UCI HAR Dataset/train/y_train.txt')
        
        ##################################################################
        ##
        ## 1) Merge the training and the test sets to create one dataset
        ##
        ##
        ## 4) Appropriately label data set with descriptive labels 
        ##
        ##################################################################
        
        
        ## merge the test and train datasets
        subject <- rbind(subject_test, subject_train) ## list of subjects
        y <- rbind(y_test, y_train) ## list of activities
        X <- rbind(X_test, X_train) ## list of measures
        
        names(subject) <- 'subject'
        names(y) <- 'activity_id'
        
        ## to make the identification of the measures easier, we replace the 
        ## column names based on the feature_info.txt file
        names(X) <- features$V2
        
        ## generate the one set
        one_set <- cbind(subject, y, X)

        ##################################################################
        ##
        ## 2) Extract only the measurements on the mean and standard 
        ##    deviation for each measurement.
        ##
        ##    According to the features_info file this means these items:
        ##
        ##    mean(): Mean value
        ##    std(): Standard deviation
        ##
        ##################################################################
        
        ## keep the first two columns in the set (subjects and activities)
        ## and keep any column that has mean() or std() in the name
        keep_columns <- grep("subject|activity_id|mean[^F]|std", names(one_set), value = FALSE)
        one_set_mean_std <- one_set[, keep_columns]
        
        ##################################################################
        ##
        ## 3) Use descriptive names for the activities in the data set. 
        ##
        ##################################################################
        
        ## explain the activity set
        one_set_mean_std_explained <- merge(x = activity_labels, y = one_set_mean_std, by.x = 'V1', by.y = 'activity_id')
        
        ## tidy up the dataset for analysis.
        ## please read the README.md file for explanation why the below format was used.
        
        ## load the data.table library

        tidy1 <- melt(one_set_mean_std_explained, id = c('V1', 'V2', 'subject'))
        tidy2 <- tidy1[, 2:5]
        names(tidy2) <- c('activity', 'subject', 'input.variable', 'result')
        tidy2$subject <- as.factor(tidy2$subject)
        
        ## change data format to data.table for easier transformation
        tidy2 <- tbl_df(tidy2)
        
        tidy_data <- tidy2 %>% group_by(activity, subject, input.variable) %>% summarize(average = mean(result))
        
        
        ## save data table to the data folder. Before saving we are coercing it back
        ## to data.frame format
        write.table(as.data.frame(tidy_data), file = './tidy_data.txt', row.name = FALSE)

}