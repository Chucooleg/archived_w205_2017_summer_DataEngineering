Exercise 1 Instructions


Step 1: Loading Tables

$ chmod u+x,g+x *

$./loading_and_modeling.sh


Step 2: Transforming Tables

$cd /home/w205/w205_2017_summer/exercise_1/transforming

$ chmod u+x,g+x *

$spark-sql

>> source 3nf_transform.sql;

>> source analytical_transform.sql;

>> exit;



Step 3: Examine 3NF, intermediate and analytical tables with ERD diagrams

Note: In metastore, you will see all 3NF tables named with prefix 3nf_, all intermediate tables named with prefix intermediate_, and all analytical tables named with prefix analytical_

Note: All diagrams are stored in the transforming directory

$cd /home/w205/w205_2017_summer/exercise_1/transforming

Note: A description of the 3nf transformation can be found in same directory

$cd /home/w205/w205_2017_summer/exercise_1/transforming/3nf_description.txt


Step 4: Examine Queries and Answers

$cd /home/w205/w205_2017_summer/exercise_1

For question 1, run:

$./question_1.sh

For question 1 text, read:

$cat /home/w205/w205_2017_summer/exercise_1/investigations/best_hospitals/best_hospitals.txt

For question 1 appendix, read:

$cat /home/w205/w205_2017_summer/exercise_1/investigations/best_hospitals/best_hospitals_appendix.txt

For question 2, run:

$./question_2.sh

For question 2 text, read:

$cat /home/w205/w205_2017_summer/exercise_1/investigations/best_states/best_states.txt

For question 3, run:

$./question_3.sh

For question 3 text, read:

$cat /home/w205/w205_2017_summer/exercise_1/investigations/hospital_variability/hospital_variability.txt

For question 4 run:

$./question_4.sh

For question 4 text, read:

$cat /home/w205/w205_2017_summer/exercise_1/investigations/hospitals_and_patients/hospitals_and_patients.txt
