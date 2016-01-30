# wearables
This is a readme file for scritp for course project for Data Cleaning course on Coursera.

First, script reads the files with data on variable names ("features.txt") and activity labels.

Then it preapres test and train set for merging, consequently:
downloads and reads test set, gives it right names from "features" file, reads data on activities, gives activities names and merges with the test set, then reads and "cbind-s" subject id's.
Then it does the same for the train data set.

Then the data sets are marged ("all_set").

To extract only mean and standard deviation measures next steps are taken:
created vector containing strings we need ("mean()" and "std()")
logical vectors based on grepl functions added to features' list as new columns, so we know in which lines there are needed strings,
also is added logical list showing if there's "Freq" string in the measurement name - thus no extra variable is added.

Function mean_std is created and used on "features" to combine 3 logical vectors in one, and let us subset the right measurments from features' list. After that the "TRUE" measurements are being subset, we get their numbers, and thus we know which columns to take from "all_set" data set (the list of number of needed variables is stored in mnstd_num).

The result is "needed_set"

To make variable names more descriptive, the script takes away all "(",")" and "-" symbols, and turns variables lower case.
functions "tolower" and  "gsub" are used for that.

The next step is to reshape the set: it should show mean measurements for each activity, subect anf variable.

To acheve that an empty data frame, empty character vector and a double loop is created, on for activities (with 6 iterations) and one for subjects (30 iterations).
There is just the secnd loop inside the first one, so the main thing is inside the second one.
The variable avg is introduced, and result of a subset on a "needed_set" is inside. The subset takes all lines for the specific activity ("needed_set[,67]==act_labels[n,2]" means that values in 67th columns (activity) that are equal to current needed activity (n) should be subset) and specifir subject (x stands for current calculated subject number).

Then the mean for each variable is calculated using sapply, and row-binded to "new_tidy" dataframe,
and vector with activity labels is updated for further usage (labls).

After all iteration for both loops are done, "labls" vector is added as a new column of new_tidy data frame, and columns names of "needed_set" are passed to "new_tidy" data frame. 

Then NAs are removed. Though, this script can write both data sets, with and without NA - you should just choose which line to "mute" with # symbol.







