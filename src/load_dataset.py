import json

def yield_dataset():
    PATH = r'C:\danbooru_dump\metadata.json.tar\metadata'
    # to later get all jsons recursively, refer to https://stackoverflow.com/questions/954504/how-to-get-files-in-a-directory-including-all-subdirectories
    FILENAME = '2017000000000000.json'

    with open(rf'{PATH}\2017\{FILENAME}') as f:
        for line in f:  # testing with first 5 lines. Later replace with 'in f:'
            yield json.loads(line)
