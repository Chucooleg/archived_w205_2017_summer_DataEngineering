#! /bin/bash


cd /home/w205/w205_2017_summer/exercise_1/loading_and_modeling
chmod u+x,g+x *

# Drop duplicate data
./CLEAN_load_data_lake.sh
# Load data
./load_data_lake.sh
# Drop all duplicate tables
hive -f CLEAN_all_tables.sql 
# Load raw tables
hive -f hive_base_ddl.sql


cd /home/w205/w205_2017_summer/exercise_1/transforming
chmod u+x,g+x *

# Transform into 3NF tables
cat 3nf_transform.sql | spark-sql
# Transform into Intermediate and Analytical tables
cat analytical_transform.sql | spark-sql

