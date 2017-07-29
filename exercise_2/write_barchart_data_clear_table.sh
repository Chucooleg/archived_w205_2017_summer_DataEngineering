#! /bin/bash

psql -U postgres -d tcount -c "Copy (Select * From tweetwordcount) To STDOUT With CSV HEADER DELIMITER ',';" > "/home/w205/w205_2017_summer/exercise_2/sample_output/histogram_sample_$(date +%Y%m%d).csv"

psql -U postgres -d tcount -c "DELETE FROM tweetwordcount;"

