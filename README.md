# Gather and Clean Data

This is the Coursera Gather and Clean data course assignment script.

## Contents

This repository contains the following files:

* ```README.md``` - this document, explaining the content and operation of the script.
* ```CodeBook.md``` - the Code Book for the project explaining the clean data.
* ```run_analysis.R``` - the script to reproduce the data gathering, cleanup and analysis
steps.

## Environment

This analysis was run with the following parameters. (run 'sessionInfo()' in your R window to check.)

### R

```
R version 3.2.4 Revised (2016-03-16 r70336)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252    LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                           LC_TIME=English_United States.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] data.table_1.9.6 dplyr_0.5.0      quantmod_0.4-5   TTR_0.23-1       xts_0.9-7        zoo_1.7-13       lubridate_1.5.6 
[8] swirl_2.4.2     

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.5     magrittr_1.5    lattice_0.20-33 R6_2.1.2        stringr_1.0.0   httr_1.2.1      tools_3.2.4    
 [8] grid_3.2.4      DBI_0.4-1       htmltools_0.3.5 yaml_2.1.13     lazyeval_0.2.0  digest_0.6.9    assertthat_0.1 
[15] tibble_1.1      crayon_1.3.2    bitops_1.0-6    RCurl_1.95-4.8  testthat_1.0.2  curl_0.9.7      evaluate_0.9   
[22] rmarkdown_1.0   stringi_1.1.1   chron_2.3-47   
```

## Data Collection

Data for this analysis was gathered from the machine learning database archives
of University of California, Irvine.
The dataset is from an experiment carried out collecting accelerometer data from Samsung Galaxy S II smartphone.

The data gathering methodology and Code Book to the original experiment are available at the below link:

http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names

The dataset gathered and used in this project is available in the following zip file:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Data Cleanup

Definitions on Tidy Data for the assignment was used from this blog:

https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/

Courtesy of David Hood.

### Files used from the dataset for the cleanup and analysis

* UCI HAR Dataset/features.txt: contains the column descriptions for the 'X' files
* UCI HAR Dataset/activity_labels.txt: contains the activity descriptions for the 'Y' files
* UCI HAR Dataset/test/subject_test.txt: the subject IDs who provided the test data
* UCI HAR Dataset/test/X_test.txt: processed raw data (following definitions in README.txt)
* UCI HAR Dataset/test/y_test.txt: the activities the data was gathered for
* UCI HAR Dataset/train/X_train.txt: processed raw data (following definitions in README.txt)
* UCI HAR Dataset/train/y_train.txt: the activities the data was gathered for

## Definition of Tidy Data for the Assignment Project.

Since the assigment does not specify what the tidy data should look like,
my understanding is that each record will be a reading of the different metrics for an individual subject.

Variables are the different activity types.


## How to load the tidy data

(Courtesy of https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/)

```
address <- "https://s3.amazonaws.com/coursera-uploads/user-longmysteriouscode/asst-3/massivelongcode.txt"
address <- sub("^https", "http", address)
data <- read.table(url(address), header = TRUE)
View(data)
```