import sys

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()

if len(sys.argv) == 2:

	word = sys.argv[1]

	cur.execute("SELECT count FROM tweetwordcount WHERE word=%s", (word,))
	if cur.rowcount ==0 :
		print('Total number of occurrences of of "%s": %d' % (word,0))
	else:
		record = cur.fetchall()[0]       
		print('Total number of occurrences of of "%s": %d' % (word,record[0]))

elif len(sys.argv) == 1:

	cur.execute("SELECT word, count from tweetwordcount")
	records = cur.fetchall()
	pairs = sorted((rec[0],rec[1]) for rec in records)
	for pair in pairs:
		print pair[0],pair[1]

else:
	print('Incorrect Usage')
	print('Usage: $python finalresults.py [optional word]')
	exit(1)

conn.commit()
conn.close()
