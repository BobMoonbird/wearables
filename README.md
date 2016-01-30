# wearables
this is a readme file for scritp for course project for Data Cleaning course on Coursera.

first, script downloads and reads the files with data on variable names ("features.txt") and activity labels.

then it preapres test and train set for merging, consequently:
downloads and reads test set, gives it right names from "features" file, reads data on activities, gives activities names and merges with the test set, then reads and "cbind-s" subject id's.
Then it does the same for the train data set.

Then the data sets are marged ("all_set").

To extract only mean and standard deviation measures next steps are taken:
created vector containing strings we need ("mean()" and "std()")
logical vectors based on grepl functions added to features' list as new columns, so we know in which lines there are needed strings,
also is added logical list showing if there's "Freq" string in the measurement name - thus no extra variable is added.

function mean_std is created and used on "features" to combine 3 logical vectors in one, and let us subset the right measurments from features' list. After that the "TRUE" measurements are being subset, we get their numbers, and thus we know which columns to take from "all_set" data set (the list of number of needed variables is stored in mnstd_num).

The result is "needed_set"

To make variable names more descriptive, the script takes away all "(",")" and "-" symbols, and turns variables lower case.
functions "tolower" and  "gsub" are used for that.

The next step is to reshape the set: it should show mean measurements for each activity, subect anf variable.







