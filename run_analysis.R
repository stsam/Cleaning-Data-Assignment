run_analysis <- function()
{
    library(plyr)
    library(reshape2)
    
    destfldr <- "./data"
    ## Create data folder if it does not exist
    if(!file.exists(destfldr)){
        dir.create(destfldr)
    }
    
    ## Download file if it does not exist
    dest <- paste(destfldr, "dataset.zip", sep="/")
    if(!file.exists(dest)){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, dest)
    }
    
    ## Unzip the zip file
    unzip(dest, exdir="data")
    
    ## change path 
    dest <- setdiff(dir("data"), destfldr)
    destfldr <- paste(destfldr, dest[2], sep="/")
    
    ## read Lables
    labels <- read.table(paste(destfldr,"activity_labels.txt", sep="/"), sep="")[,2]

    ## read features
    features <- read.table(paste(destfldr,"features.txt", sep="/"), sep="")
    
    ##extract for mean and std
    ##2. helps in extracts only the measurements on the mean and standard deviation for each measurements
    measures <- grep("mean|std", features[,2])
    
    ## Merge data in test folder
    folder <- paste(destfldr,"test", sep="/")
    subject_data <- read.table(paste(folder, "subject_test.txt", sep="/"), col.names="subject")
    x_data <- read.table(paste(folder, "X_test.txt", sep="/"), col.names=features[,2])
    x_data <- x_data[,measures]
    y_data <- read.table(paste(folder, "y_test.txt", sep="/"))
    ##3. Uses descriptive activity names to name the activities in the data set
    y_data[,2] = labels[y_data[,1]]
    names(y_data) = c("ActivityID", "ActivityLabel")
    test <- cbind(subject_data, y_data, x_data)
    
    ## Merge data in training folder
    folder <- paste(destfldr,"train", sep="/")
    subject_data <- read.table(paste(folder, "subject_train.txt", sep="/"), col.names="subject")
    ## 4. Appropriately labels the data set with descriptive variable names
    x_data <- read.table(paste(folder, "X_train.txt", sep="/"), col.names=features[,2])
    x_data <- x_data[,measures]
    y_data <- read.table(paste(folder, "y_train.txt", sep="/"))
    ##3. Uses descriptive activity names to name the activities in the data set
    y_data[,2] = labels[y_data[,1]]
    names(y_data) = c("ActivityID", "ActivityLabel")
    train <- cbind(subject_data, y_data, x_data)
    
    ##Single data set
    ## 1. Merges the training and the test sets to create one data set
    data<-rbind(test,train)
    
    ids   = c("subject", "ActivityID", "ActivityLabel")
    
    ## 5. Creates a second, independent tidy data set with the average of each variable for each
    ## activity and each subject
    meltedData      = melt(data, id = ids, measure.vars = setdiff(colnames(data), ids))
    # Apply mean function to dataset using dcast function
    tidy_data   = dcast(meltedData, subject + ActivityLabel + ActivityID ~ variable, mean)
    
    ## write tidy data to file
    write.table(tidy_data, file = "./data/tidy_data.txt", row.names=FALSE)
    
    ## write codebook to file
    write.table(paste("", names(tidy_data), sep=" "), file="./data/CodeBook.md")
}
