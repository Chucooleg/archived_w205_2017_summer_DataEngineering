import sys

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()

if len(sys.argv) != 3:

	print('Incorrect Usage')
	print('Usage: $python histogram.py [numeric lower bound] [numeric upper bound]')
	exit(1)

else:

	k1 = sys.argv[1]
	k2 = sys.argv[2]

	# WIP
	cur.execute("SELECT word, count FROM tweetwordcount WHERE count>=%s AND count<=%s ",(str(k1),str(k2)))

	if cur.rowcount ==0 :
		print('No words found between range %d and %d' % (int(k1),int(k2)))
	else:
		records = cur.fetchall()
		pairs = sorted((rec[0],rec[1]) for rec in records)
		for pair in pairs:
			print pair[0],":",pair[1]

conn.commit()
conn.close()
