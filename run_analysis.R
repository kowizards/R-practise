# q1
featureName <- read.csv('UCI HAR Dataset/features.txt', header=FALSE, sep=' ', stringsAsFactor=FALSE)[, 2]

readDataSet <- function(fileName){
  lines <- readLines(fileName)
  lstOfVec <- lapply(lines, function(line){
    sp <- unlist(strsplit(line, " "))
    sp <- sp[sp != ""]
    sp <- as.numeric(sp)
    sp
  })
  mat <- do.call(rbind, lstOfVec)
  df <- data.frame(mat)
  names(df) <- featureName
  df
}

trainingSet <- readDataSet('UCI HAR Dataset/train/X_train.txt')
testSet <- readDataSet('UCI HAR Dataset/test/X_test.txt')

mergedData <- rbind(trainingSet, testSet)

# q2
selectedFeatureNameIndicator <- grepl('mean\\(\\)', featureName) | grepl('std\\(\\)', featureName)
selectedFeatureName <- featureName[selectedFeatureNameIndicator]
selectedData <- mergedData[,selectedFeatureNameIndicator]

# q3
descriptiveActivityName <- read.csv('UCI HAR Dataset/activity_labels.txt', header=FALSE, sep=' ',
                                    col.names=c('label', 'descriptiveLabel'))

# q4
trainingLabel <- as.numeric(readLines('UCI HAR Dataset/train/y_train.txt'))
testLabel <- as.numeric(readLines('UCI HAR Dataset/test/y_test.txt'))
mergedLabel <- c(trainingLabel, testLabel)

trainingSubject <- as.numeric(readLines('UCI HAR Dataset/train/subject_train.txt'))
testSubject <- as.numeric(readLines('UCI HAR Dataset/test/subject_test.txt'))
mergedSubject <- c(trainingSubject, testSubject)

selectedData$label <- mergedLabel
selectedData$subject <- mergedSubject
cookedData <- merge(selectedData, descriptiveActivityName, by.x='label', by.y='label')

# q5
cookedData$label <- NULL

output <- aggregate(. ~ subject + descriptiveLabel, data=cookedData, mean)
write.table(output, 'output.txt', row.name=FALSE)
