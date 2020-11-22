import psycopg2
from connect import connect
from load_dataset import yield_dataset

if __name__ == '__main__':
    with connect() as conn:
        cursor = conn.cursor()
        cursor.execute("select * from tag_category")
        for row in cursor:
            print(row[1])
