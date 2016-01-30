#script for data science course project on getting and cleaning data

#1. and 3. merging the data & activity labels
features = read.table("./UCI HAR Dataset/features.txt")
act_labels = read.table("./UCI HAR Dataset/activity_labels.txt")

#creating test set for merge: getting variable names, activity names, subject IDs
test_set = read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
colnames(test_set) <- features[,2]
tst_labs = read.table("./UCI HAR Dataset/test/y_test.txt")
merged_tst = merge(tst_labs, act_labels, by.x = "V1", by.y = "V1", all=TRUE)
test_set = cbind(test_set, merged_tst)
subject_test = read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
test_set = cbind(test_set, subject_test)

#creating train set for merge: getting variable names, activity names, subject IDs
train_set = read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
colnames(train_set) <- features[,2]
tr_labs = read.table("./UCI HAR Dataset/train/y_train.txt")
merged_tr = merge(tr_labs, act_labels, by.x = "V1", by.y = "V1", all=TRUE)
train_set = cbind(train_set, merged_tr)
subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
train_set = cbind(train_set, subject_train)

#mergin the sets
all_set = rbind(test_set, train_set)
names(all_set)[563] = "activitylabel"
names(all_set)[564] = "subject"

# 2. extracting mean and standart deviation only
needed = c("mean()", "std()")
features = cbind(features, grepl(needed[1], features[,2]))
features = cbind(features, grepl(needed[2], features[,2]))
features = cbind(features, grepl("Freq", features[,2]))

# this function will check variable names for mean and std, and will get rid of frequency measureament
mean_std = function(frame)
{
  for(i in 1:length(frame[,3]))
  {
    x[i] = frame[i,3]=="TRUE"&frame[i,5]=="FALSE" | frame[i,4]=="TRUE"&frame[i,5]=="FALSE"
    
  }
  x
}

features[,6] = mean_std(features)

# checking for a bug, if the result is 1/0 instead of TRUE/FALSE (happened several times on my machine)
# getting the number of rows of variable names list to use it for mean and std extraction
if (features[1,6] =="TRUE"|features[1,6]=="FALSE")
{
  mnstd_cols = subset(features, features[,6]=="TRUE")
}  else
  {
    mnstd_cols = subset(features, features[,6]==1) 
  }

#finally getting the number of collumns of the set to extract (and not forgetting columns with activity label and subect ID)
mnstd_num = mnstd_cols[,1]
needed_set = all_set[,c(mnstd_num,563,564)]

# 4. getting descriptive names for variables: lower case, no "()" and "_" 
names(needed_set) = tolower(names(needed_set))
names(needed_set) = gsub("-","", names(needed_set))
names(needed_set) = gsub("(","", names(needed_set), fixed = TRUE)
names(needed_set) = gsub(")","", names(needed_set), fixed = TRUE)

# 5. loop for creating new tidy set called "new_tidy"
# first level of loop - activities, second level of loop - subjects;
# for each actvity, count average on each variable and each subect
new_tidy = data.frame()
labls = character()

for (n in 1:6)
{
  for (x in 1:30)
  {
    avg = subset(needed_set, needed_set[,67]==act_labels[n,2] & needed_set[,68]==x)
    
    new_tidy = rbind(new_tidy,sapply(avg, mean))
    labls = c(labls, paste(act_labels[n,2]))
  }
}
new_tidy[,67] = labls
names(new_tidy) = names(needed_set)

#get rid of NAs
tidynona1 = new_tidy[!is.na(new_tidy[,2]),]

tidynona = tidynona1[,c(67,68)]
tidynona = cbind(tidynona, tidynona1[,1:66])

write.table(tidynona, "tidy_data_wearables.txt", row.names = FALSE)
#write.table(new_tidy, "tidy_data_with_na.txt", row.names = FALSE)
