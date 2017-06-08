#! /bin/bash

# save my current directory
MY_CWD=$(pwd)

# create staging directories
mkdir ~/staging
mkdir ~/staging/exercise_1
cd ~/staging/exercise_1

# get file from data.medicare.gov
MY_URL="https://data.medicare.gov/views/bg9k-emty/files/0a9879e0-3312-4719-a1db-39fd114890f1?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"
wget "$MY_URL" -O medicare_data.zip
unzip medicare_data.zip

# remove first line and rename each file
OLD_FILE="Hospital General Information.csv"
NEW_FILE="hospitals.csv"
tail -n +2 "$OLD_FILE" > $NEW_FILE 

OLD_FILE="Timely and Effective Care - Hospital.csv"
NEW_FILE="effective_care.csv"
tail -n +2 "$OLD_FILE" > $NEW_FILE 

OLD_FILE="Readmissions and Deaths - Hospital.csv"
NEW_FILE="readmissions.csv"
tail -n +2 "$OLD_FILE" > $NEW_FILE 

OLD_FILE="Measure Dates.csv"
NEW_FILE="measures.csv"
tail -n +2 "$OLD_FILE" > $NEW_FILE 

OLD_FILE="hvbp_hcahps_11_10_2016.csv"
NEW_FILE="surveys_responses.csv"
tail -n +2 "$OLD_FILE" > $NEW_FILE 

# create our main hospital compare hdfs directory
hdfs dfs -mkdir /user/w205/hospital_compare

# create hdfs directory for each file and copy each file to hdfs
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -put hospitals.csv /user/w205/hospital_compare/hospitals

hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/effective_care

hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -put readmissions.csv /user/w205/hospital_compare/readmissions

hdfs dfs -mkdir /user/w205/hospital_compare/measures
hdfs dfs -put measures.csv /user/w205/hospital_compare/measures

hdfs dfs -mkdir /user/w205/hospital_compare/surveys_responses
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/surveys_responses

# change directory back to the original
cd $MY_CWD

# clean exit
exit
