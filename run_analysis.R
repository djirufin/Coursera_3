#Create a dataframe per analysis
folder_list <- c('test', 'train')

features <- read.table("features.txt", colClasses = "character")
activity_label <- read.table("activity_labels.txt")

#Load tidyverse library
library(dplyr)


#Dealing with test files
x_test <- read.table(paste(folder_list[[1]], '/X_', folder_list[[1]], '.txt', sep = ''))
y_test <- read.table(paste(folder_list[[1]], '/y_', folder_list[[1]], '.txt', sep = ''))
sub_test <- read.table(paste(folder_list[[1]], '/subject_', folder_list[[1]], '.txt', sep = ''))

colnames(x_test) <- features$V2
colnames(sub_test) <- "SubjectID"
x_test <- cbind(y_test, sub_test, x_test)
act_y_test <- merge(x_test, activity_label, by="V1", all = TRUE, sort = FALSE)
act_y_test <- act_y_test[, !duplicated(colnames(act_y_test))]
dftest <- act_y_test %>% rename("Activity" = V2) %>% select(SubjectID, Activity, everything()) %>%select(-V1)


#Dealing with train files
x_train <- read.table(paste(folder_list[[2]], '/X_', folder_list[[2]], '.txt', sep = ''))
y_train <- read.table(paste(folder_list[[2]], '/y_', folder_list[[2]], '.txt', sep = ''))
sub_train <- read.table(paste(folder_list[[2]], '/subject_', folder_list[[2]], '.txt', sep = ''))

colnames(x_train) <- features$V2
colnames(sub_train) <- "SubjectID"
x_train <- cbind(y_train, sub_train, x_train)
act_y_train <- merge(x_train, activity_label, by="V2", all = TRUE, sort = FALSE)
act_y_train <- act_y_train[, !duplicated(colnames(act_y_train))]
dftrain <- act_y_train %>% rename("Activity" = V2) %>% select(SubjectID, Activity, everything()) %>%select(-V2)


dffinal <- rbind(dftest, dftrain)

df_mean_std <- dffinal %>% select(matches("(SubjectID|Activity|.mean.|.std.)", ignore.case = FALSE))

library(stringr)

#Last dataframe set
df_mean_std <- df_mean_std %>% rename_all(funs(str_remove_all(., "\\(\\)")))

#Summarize variable mean
cdf <- df_mean_std %>% group_by(Activity, SubjectID) %>% summarise_all(funs(mean))


