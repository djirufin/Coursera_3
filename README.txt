To perform the analysis of the files, i dealed with each part separately: test and train

firstable, i loaded the features and activity label as part of global dataframe to append later on both test and train dataframe.

the feature df had to be loaded as character colname du to commas, dashes and numbers in the files. This will be helpfull to use it as set headers.

the test set is loaded into df x_test, the activity IDs are loaded as numbers into y_test and the subject ID are loaded into sub_test df. This is done from line 12 to 14.
all those 3 df will be merge into 1 bigger df but, first, we need to set headers (colnames).
this is done from line 16 to line 21.

Finally, we remove duplicate from generated df, remove activity ID and keep only activity label (select(-V1)).

Train set is having the same configuration to test set.We only replay the same action from line 12 to 21 by changing and pointing to train folder and files.

When it's finish, we only merge both, cleaning variable for more readability and extract summary mean for remaining variables.