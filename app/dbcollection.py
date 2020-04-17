import os
import logging 
import sys
import json
from datetime import datetime 

logging.basicConfig(format='%(levelname)s: %(asctime)s => %(message)s', level=logging.INFO, stream=sys.stdout)


PLATFORM_SUPPORT = [
    { 'name' : "MS SQL Server", 'folder' : 'mssql' },
    { 'name' : "PostgreSQL", 'folder' : 'pgsql' },
    { 'name' : "MySQL", 'folder' : 'mysql' },
    { 'name' : "MongoDb", 'folder' : 'mongodb' },
    { 'name' : "Minio", 'folder' : 'minio' }
]

README = "readme.md"
UPDATES = "updates.json"
PROVSIONED = "provisioned"

class DatabaseCollection:
    __schema_base_path__ = ""

    collection = []

    def __init__(self, schema_base_path):
        self.__schema_base_path__ = schema_base_path
        self.crawl()

    def __read_file_contents__(self, path):
        with open (path, "r") as f:
            contents = f.read().strip()
            return contents

    def crawl(self):
        self.collection = []
        folders =  [ f.path for f in os.scandir(self.__schema_base_path__) if f.is_dir() ]
        for folder in folders:
            dbname = os.path.basename(folder)
            readme = os.path.exists(os.path.join(folder,README)) 
            static = not os.path.exists(os.path.join(folder,UPDATES))
            provisioned = os.path.exists(os.path.join(folder,PROVSIONED))
            provisioned = "None" if not provisioned else self.__read_file_contents__(os.path.join(folder,PROVSIONED))
            last_update = "None" if static else json.loads(self.__read_file_contents__(os.path.join(folder,UPDATES))).get("last_processed", "None")
            self.collection.append({'name' : dbname, 'readme' : readme, 'static' : static, 'provisioned' : provisioned, 'last_update' : last_update})


    def set_last_provision(self, dbname, date = None):
        date = datetime.now() if date == None else date 
        provision_file = os.path.join(self.__schema_base_path__, dbname, PROVSIONED)
        with open (provision_file, "w") as f:
            f.write(str(date))
        self.crawl()
        return date 

    def clear_last_provision(self, dbname):
        filespec = os.path.join(self.__schema_base_path__, dbname,PROVSIONED)
        if os.path.exists(filespec):
            os.remove(filespec)
            self.crawl()

if __name__ == '__main__':
    logging.info("MAIN PROGRAM")
    path = os.path.join(".", "schemas")
    dbc = DatabaseCollection(path)
    logging.info(dbc.collection)
    dbc.set_last_provision('tinyu')
    logging.info(dbc.collection)

