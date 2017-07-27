""" Script to create database tcount and create tweetwordcount table"""

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Connect to postgre default
conn = psycopg2.connect(database="postgres", user="postgres", password="pass", host="localhost", port="5432")

# Create the Database
try:
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = conn.cursor()
    cur.execute("CREATE DATABASE tcount")
    cur.close()
    conn.close()
except:
    print "Could not create tcount"


#Connecting to tcount
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

#Create tweetwordcount table
cur = conn.cursor()
cur.execute('''CREATE TABLE tweetwordcount
       (word TEXT PRIMARY KEY     NOT NULL,
       count INT     NOT NULL);''')
conn.commit()


# check if table works
cur.execute("INSERT INTO tweetwordcount (word,count) VALUES ('test', 1)")
cur.execute("SELECT word, count from tweetwordcount where word = %s", ('test',))
assert(cur.fetchall()[0][1] == 1)

conn.commit()
conn.close()
