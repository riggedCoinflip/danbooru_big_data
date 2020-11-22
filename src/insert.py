import psycopg2
from connect import connect

conn = connect()
cursor = conn.cursor()
cursor.execute("select * from tag_category")
for row in cursor:
    print(row[1])
conn.close()
