import psycopg2

def connect():
    dbname = 'danbooru'
    user = 'postgres'
    with open('password.txt') as f:
        secret = f.read()

    return psycopg2.connect(dbname=dbname, user=user, password=secret)