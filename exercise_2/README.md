### 1. Start up Postgres database and tweetwordcount table

```
$cd /home/w205/w205_2017_summer/exercise_2
$python create_database_table.py
```

### 2. Create streamparse directory and replace code

```
$cd ~
$sparse quickstart extweetwordcount
$cd /home/w205/w205_2017_summer/exercise_2
$chmod u+x,g+x move_streamparse_code.sh
$./move_streamparse_code.sh
```


### 3. Run streamparse for roughly a minute or two

```
$cd ~/extweetwordcount/
$sparse run
```

### 4. Examine list of stop words

```
$cat ~/w205_2017_summer/exercise_2/stopwords.txt
```

### 5. Examine finalresults.py and verify with postgres queries

```
$cd ~/w205_2017_summer/exercise_2/
$python finalresults.py > sample_finalresults.txt
$less sample_finalresults.txt
$psql -U postgres -d tcount -c 'SELECT word, count FROM tweetwordcount ORDER BY word LIMIT 50'
$python finalresults.py trump
$psql -U postgres
$\c tcount
$SELECT word, count FROM tweetwordcount WHERE word LIKE 'trump';
$\q
```


### 5.1 Examine finalresults output in screenshots directory

```
/home/w205/w205_2017_summer/exercise_2/screenshots/screenshot-finalresults-demo.png
```


### 6. Examine histogram.py and verify with postgres queries

```
$cd ~/w205_2017_summer/exercise_2/
$python histogram.py 50 100
$psql -U postgres
$\c tcount
$SELECT word, count FROM tweetwordcount WHERE count>=50 and count<=100 ORDER BY word;
$\q
```


### 6.1 Examine finalresults output in screenshots directory

```
/home/w205/w205_2017_summer/exercise_2/screenshots/screenshot-histogram-demo.png
```


### 7.Examine bar chart.

```
/home/w205/w205_2017_summer/exercise_2/barcharts/plot.png
```


### 7.1 Bar chart data that is exported from postgres and fed into tableau

```
$less /home/w205/w205_2017_summer/exercise_2/sample_output/histogram_sample.csv
```


### 8. Examine Screenshots

```
$cd /home/w205/w205_2017_summer/exercise_2/screenshots
```
```
screenshot-twitterStream.png
screenshot-stopwords-filter.png
screenshot-stormComponents.png
screenshot-finalresults-demo.png
screenshot-histogram-demo.png
screenshot-tableau-barchart.png
```

### 9. Application Extension : Get daily wordcount to observe any change in tweeter word usages

```
$chmod u+x,g+x /home/w205/w205_2017_summer/exercise_2/write_barchart_data_clear_table.sh
```

Run the following daily on EC2 instance:

```
$cd ~/extweetwordcount/
$sparse run
$/home/w205/w205_2017_summer/exercise_2/write_barchart_data_clear_table.sh
```

Examine the daily produced data for barchart on EC2 instance:

```
$cd /home/w205/w205_2017_summer/exercise_2/sample_output/
$ls -l
$cat /home/w205/w205_2017_summer/exercise_2/sample_output/histogram_sample_20170729.csv
```

Then git push changes to master branch, git pull changes to local computer. Import new daily file to Tableau for daily barchart. 


### 9.1 Examine Collection of daily barcharts in pdfs

```
$cd /home/w205/w205_2017_summer/exercise_2/barcharts
```

### 10. Examine Architecture Diagram

```
/home/w205/w205_2017_summer/exercise_2/architecture.pdf
```
