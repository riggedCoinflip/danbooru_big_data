import psycopg2
import time
from connect import connect
from load_dataset import yield_dataset

def main():
    with connect() as conn:
        datasets = yield_dataset()
        for i, dataset in enumerate(datasets):
            if i < 25000:
                continue
            print(f'{i=}, {dataset=}')
            insert(dataset, conn)
            # up
            if i % 100 == 0:
                conn.commit()
            #if i >= 10:
                #return #testing
            #time.sleep(1)  # testing

def insert(ds:dict, conn):
    d = {
        'image_id': int(ds['id']),
        'uploader_id': int(ds['uploader_id']),
        'approver_id': int(ds['approver_id']),
        'created_at': ds['created_at'],
        'updated_at': ds['updated_at'],
        'last_commented_at': ds['last_commented_at'],
        'score': int(ds['score']),
        'up_score': int(ds['up_score']),
        'down_score': int(ds['down_score']),
        'source': ds['source'],
        'rating': ds['rating'],
        'image_width': int(ds['image_width']),
        'image_height': int(ds['image_height']),
        'file_size': int(ds['file_size']),
        'has_children': ds['has_children'],
        'is_note_locked': ds['is_note_locked'],
        'is_status_locked': ds['is_status_locked'],
        'is_pending': ds['is_pending'],
        'is_flagged': ds['is_flagged'],
        'is_deleted': ds['is_deleted'],
        'is_banned': ds['is_banned']
    }
    if int(ds['parent_id']) != 0:
        d['parent_id'] = int(ds['parent_id'])
    # https://stackoverflow.com/questions/29461933/insert-python-dictionary-using-psycopg2

    if 'uploader_id' in d:
        insert_user(d['uploader_id'], conn)
    if 'approver_id' in d:
        insert_user(d['approver_id'], conn)
    insert_image(d, conn)
    for tag in ds['tags']:
        insert_tag(tag, conn)
        insert_tags_image(int(tag['id']), int(d['image_id']), conn)

def insert_user(user_id:int, conn):
    d = {
        'user_id' : user_id
    }
    if not in_db('users', f'user_id = {d["user_id"]}', conn):
        query_insert_one('users', d, conn)
    #else:  # testing
        #print(f'user: {d["user_id"]} already in DB')  # testing


def insert_image(d:dict ,conn):
    if not in_db('image', f'image_id = {d["image_id"]}', conn):
        query_insert_one('image', d, conn)
    #else:  # testing
        #print(f'image: {d["image_id"]} already in DB')  # testing


def insert_tag(tag:dict, conn):
    d = {
        'tag_id': int(tag['id']),
        'name': tag['name'],
        'tag_category_id': int(tag['category'])
    }
    if not in_db('tags', f'tag_id = {d["tag_id"]}', conn):
        query_insert_one('tags', d, conn)
        #else: #testing
            #print(f'tag: {d["tag_id"]} already in DB') #testing

def insert_tags_image(tag_id:int, image_id:int, conn):
    d = {
        'tag_id': tag_id,
        'image_id': image_id
    }
    if not in_db('tags_image', f'tag_id = {d["tag_id"]} AND image_id = {d["image_id"]}', conn):
        query_insert_one('tags_image', d, conn)
    #else:  # testing
        #print(f'tags_image: {d["tag_id"]}, {d["image_id"]} already in DB')  # testing

def in_db(table:str, filter:str, conn):
    with conn.cursor() as cursor:
        #print(cursor.mogrify(f'SELECT EXISTS(SELECT 1 FROM {table} WHERE {filter}'))  # testing
        cursor.execute(f'SELECT EXISTS(SELECT 1 FROM {table} WHERE {filter})')
        row = cursor.fetchone()
        #print(row)  # testing
        return(row[0])

def query_insert_one(table:str, ds:dict, conn):
    # TODO use cursor.executemany as query_insert_many
    columns = ds.keys()
    column_str = ', '.join(columns)
    values = [ds[column] for column in columns]
    vals_str = ", ".join(["%s"] * len(values))

    with conn.cursor() as cursor:
        #print(cursor.mogrify(f'INSERT INTO {table} ({column_str}) VALUES ({vals_str})', values))  # testing
        cursor.execute(f'INSERT INTO {table} ({column_str}) VALUES ({vals_str})', values)




def test():
    # check if connection is established
    with connect() as conn:
        cursor = conn.cursor()
        cursor.execute("select * from tag_category")
        for row in cursor:
            print(row[1])

if __name__ == '__main__':
    main()
