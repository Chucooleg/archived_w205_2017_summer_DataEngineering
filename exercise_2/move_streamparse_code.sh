#! /bin/bash

rm /home/w205/extweetwordcount/src/bolts/wordcount.py
cp /home/w205/w205_2017_summer/exercise_2/streamparse_code/src/bolts/parse.py /home/w205/extweetwordcount/src/bolts
cp /home/w205/w205_2017_summer/exercise_2/streamparse_code/src/bolts/wordcount.py /home/w205/extweetwordcount/src/bolts

rm /home/w205/extweetwordcount/src/spouts/words.py
cp /home/w205/w205_2017_summer/exercise_2/streamparse_code/src/spouts/tweets.py /home/w205/extweetwordcount/src/spouts

rm /home/w205/extweetwordcount/topologies/wordcount.clj
cp /home/w205/w205_2017_summer/exercise_2/streamparse_code/topologies/tweetwordcount.clj /home/w205/extweetwordcount/topologies

