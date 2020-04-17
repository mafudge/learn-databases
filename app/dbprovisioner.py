import pyodbc
import json 
import os
import glob 
from datetime import datetime, timedelta
import logging 
import sys
import time 

UPDATEFILE = 'updates.json'
#logging.basicConfig(format='%(levelname)s: %(asctime)s => %(message)s', level=logging.INFO, stream=sys.stdout)

class DatabaseProvisioner:

    __connstr__ = ""
    __schema_base_path__ = ""

    def __init__(self, connstr, schema_base_path):
        self.__connstr__ = connstr
        self.__schema_base_path__ = schema_base_path

    def execute(self, file):
        cmd = f"{self.__connstr__} -i {file}"
        logging.info(f"SHELL CMD: {cmd}")
        buff = os.popen(cmd).read()
        logging.info(buff)

    def execute3(self, sql):
        with pyodbc.connect(self.__connstr__, autocommit=True) as conn:
            commands = sql.split("GO\n")
            for command in commands:
                command = command.strip()
                if len(command) > 0:
                    logging.info(f"SQL:\n{command}")
                    conn.execute(command)


    def execute2(self, sql):
        with pyodbc.connect(self.__connstr__, autocommit=True) as conn:
            commands = sql.split("GO\n")
            for command in commands:
                command = command.strip()
                statements = command.split(";")
                for statement in statements:
                    statement = statement.strip()
                    if len(statement) > 0:
                        logging.info(f"SQL:\n{statement}")
                        conn.execute(statement)

    def get_cursor(self):
        with pyodbc.connect(self.__connstr__, autocommit=False) as conn:
            return conn.cursor()

        
    def __read_file_contents__(self, filespec):
        with open (filespec,'r',encoding='utf-8') as f:
            return f.read()

    def remove_scripts(self,dbname):
        update_filespec = os.path.join(self.__schema_base_path__, dbname,UPDATEFILE)
        if os.path.exists(update_filespec):
            generated_filespec = os.path.join(self.__schema_base_path__, dbname,'mssql', "up-99-*.sql")
            logging.info(f"REMOVING GENERATED UPDATE FILES: {generated_filespec}")
            yield f"REMOVING GENERATED UPDATE FILES: {generated_filespec}"
            count = 0
            for f in glob.glob(generated_filespec):
                os.remove(f)
                count +=1 
            time.sleep(1)
            logging.info(f"FILES REMOVED: {count}")
            yield f"FILES REMOVED: {count}"
            logging.info(f"RESETTING UPDATE SETTINGS FILE: {update_filespec}")
            yield f"RESETTING UPDATE SETTINGS FILE: {update_filespec}"
            self.reset_settings_file(update_filespec)
        yield "REMOVE: DONE!"


    def drop(self, dbname):
        script_path = os.path.join(self.__schema_base_path__, dbname,'mssql')
        update_filespec = os.path.join(self.__schema_base_path__, dbname,UPDATEFILE)
        logging.info(f"PATH: {script_path}")
        yield f"DROPPING: {dbname}"
        files = os.listdir(script_path)
        downscript = [file for file in files if file.startswith("dn-0")][0]
        filespec = os.path.join(script_path, downscript)
        logging.info(f"EXECUTE FILE: {filespec}")
        yield f"EXECUTE FILE: {filespec}"
        self.execute(filespec)
        yield "DROP: DONE!"


    def reset_settings_file(self, update_filespec):
        with open(update_filespec, "r", encoding='utf-8') as f:
            data = json.load(f)
        data['last_processed'] = data['epoch']
        with open(update_filespec, "w", encoding='utf-8') as f:
            json.dump(data, f, indent=4)
        

    def initialize(self, dbname, drop=True):
        script_path = os.path.join(self.__schema_base_path__, dbname,'mssql')
        logging.info(f"PATH: {script_path}")
        yield f"INITIALIZING: {dbname}"
        files = os.listdir(script_path)
        downscript = [file for file in files if file.startswith("dn-0")][0]
        if drop:
            update_filespec = os.path.join(self.__schema_base_path__, dbname,UPDATEFILE)
            logging.info(f"PATH: {script_path}")
            yield f"DROPPING: {dbname}"
            files = os.listdir(script_path)
            downscript = [file for file in files if file.startswith("dn-0")][0]
            filespec = os.path.join(script_path, downscript)
            logging.info(f"EXECUTE FILE: {filespec}")
            yield f"EXECUTE FILE: {filespec}"
            self.execute(filespec)
            yield "DROP: DONE!"
        upscripts = [file for file in files if file.startswith("up-")]
        upscripts.sort()
        for script in upscripts:
            filespec = os.path.join(script_path, script)
            logging.info(f"EXECUTE FILE: {filespec}")
            yield f"EXECUTE FILE: {filespec}"
            self.execute(filespec)
        yield "INIT: DONE!"

    def validate(self, dbpath, dbname):
        count_filespec = os.path.join(dbpath,'sql','counts.json')
        logging.info(f"COUNTS FILE: {count_filespec}")
        counts = json.loads(self.__read_file_contents__(count_filespec))
        cursor = self.get_cursor()
        for table in counts.keys():
            sql = f"select count(*) from {dbname}.dbo.{table}";
            count = cursor.execute(sql).fetchone()[0]
            logging.info(f"TABLE: {table} Expect: {counts[table]} Actual: {count}")
            assert count==counts[table]
