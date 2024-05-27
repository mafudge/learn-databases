from dbprovisioner import DatabaseProvisioner
import os
import logging 
import sys

logging.basicConfig(format='%(levelname)s: %(asctime)s => %(message)s', level=logging.INFO, stream=sys.stdout)

_test_ = "DRIVER={ODBC Driver 17 for SQL Server};SERVER=nas.home.michaelfudge.com,11433;DATABASE=master;UID=sa;PWD=wXp55!929ds"

if __name__ == '__main__':

    databases = [
        {"name" : "tinyu", "script" : None}
    ]

    connstr = os.environ['CONNSTR'] if  'CONNSTR' in os.environ.keys() else _test_
    logging.info(f"CONNSTR : {connstr}")
    db = DatabaseProvisioner(connstr)
    for database in databases:
        dbname = database['name']
        dbpath = os.path.join(".","schemas",dbname)
        script = db.initialize(dbpath)
        database['script'] = script
        db.validate(dbpath,dbname)
    for database in databases:
        print(database)    

