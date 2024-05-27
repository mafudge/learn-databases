import pyodbc
import os
import logging 
import sys
import datetime
import re
import time 
import json 
import random 
from datagenerators import DataGenerator


UPDATEFILE = 'updates.json'

logging.basicConfig(format='%(levelname)s: %(asctime)s => %(message)s', level=logging.INFO, stream=sys.stdout)

# TODO Subclass this bitch and used inheritance for speciaL data sets??? 
class DatabaseUpdater():

    '''
    settings = None
    random = None
    __connstr__ = ""
    __odbc_connstr__ = ""
    __schema_base_path__ = ""
    __dbname__ = ""
    __update_filespec__ = ""
    __sql_job_filespec__ = ""
    datagen = None
    '''

    def __init__(self, random_seed, connstr, odbc_connstr, schema_base_path, dbname):
        self.__connstr__ = connstr
        self.__dbname__ = dbname
        self.__odbc_connstr__ = odbc_connstr.replace("master", dbname)
        self.__schema_base_path__ = schema_base_path
        self.__random_seed__ = random_seed
        self.random = random
        self.__update_filespec__ = os.path.join(self.__schema_base_path__, dbname,UPDATEFILE)
        self.__sql_job_filespec__ = os.path.join(self.__schema_base_path__, dbname,"mssql", "up-99-job-{timestamp}-{jobname}.sql")
        self.datagen = DataGenerator(self.__random_seed__, self.__schema_base_path__)
        with open(self.__update_filespec__, "r") as f:
            self.settings =json.load(f)

        self.random.seed(self.__random_seed__) 
        
        logging.info(f"CONNECTION:  {self.__connstr__}")
        logging.info(f"ODBC CONNECTION:  {self.__odbc_connstr__}")
        logging.info(f"UPDATE SETTINGS FILESPEC:  {self.__update_filespec__}")
        logging.info(f"SQL JOB FILESPEC:  {self.__sql_job_filespec__}")

        # Base call
        # This will be used to import helper data sets
        # code dynamically imports modules

        #sys.path.append(self.__schema_base_path__)
        #payroll = __import__(dbname)

    def execute_sql_job(self, filespec):
        cmd = f"{self.__connstr__} -i {filespec}"
        logging.info(f"SHELL CMD: {cmd}")
        buff = os.popen(cmd).read()
        logging.info(buff)

    def execute_query(self, sql_select):
        rows = None 
        with pyodbc.connect(self.__odbc_connstr__) as conn:
            with conn.cursor() as cursor:
                logging.info(f"EXECUTING QUERY: {sql_select}")
                cursor.execute(sql_select)
                rows = cursor.fetchall()
        return rows 

    def get_time_delta(self, string):
        delta = None
        interval = string[-1]
        number = int(string.replace(interval, ""))
        logging.debug(f"INTERVAL:{interval} NUMBER:{number}")
        if interval == 'd':
            delta  = datetime.timedelta(days=number)
        elif interval == 'h':
            delta =  datetime.timedelta(hours=number)
        elif interval == 'm':
            delta =  datetime.timedelta(minutes=number)
        else:
            delta = None
        return delta 

    def parse_datetime(self, string):
        '''
        parses a string time into a timestruct 
        '''
        string = string if string.find(".") <0 else string[:string.find(".")] # remove micro seconds
        string = string if string.find(":") >=0 else string + " 00:00:00" # add missing time
        out_time = time.strptime(string, "%Y-%m-%d %H:%M:%S")
        return datetime.datetime.fromtimestamp(time.mktime(out_time))

    def to_date_id(self, mydatetime):
        t = mydatetime
        return int(f"{t.year:04}{t.month:02}{t.day:02}")

    def to_timestamp(self, mydatetime):
        return int(mydatetime.timestamp())

    def to_datetime_string(self, mydatetime,alldashes=False):
        t=mydatetime
        if not alldashes:
            return f"{t.year:04}-{t.month:02}-{t.day:02} {t.hour:02}:{t.minute:02}:{t.second:02}"
        else:
            return f"{t.year:04}-{t.month:02}-{t.day:02}-{t.hour:02}-{t.minute:02}-{t.second:02}"

    def should_execute(self, job_when, current_date):
        days_of_week = ['mon','tue','wed','thu','fri','sat','sun']
        months_of_year = [ 'na','jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec']
        # 1d
        if self.settings['grain'] == job_when:
            return True
        # 'mon'
        if job_when in days_of_week:
            return job_when == days_of_week[current_date.weekday()]
        # 'feb'
        if job_when in months_of_year:
            return job_when == months_of_year[current_date.month]
        # days=1,15
        if job_when.startswith("days="):
            job_days = job_when[job_when.find("=")+1:].split(",")
            return str(current_date.day) in job_days 
        # months=11,12,1
        if job_when.startswith("months="):
            job_months = job_when[job_when.find("=")+1:].split(",")
            return str(current_date.month) in job_months

        # annual=month-day
        if job_when.startswith("annual="):
            month, day = job_when[job_when.find("=")+1:].split("-")
            return current_date.month == int(month) and current_date.day == int(day)

        return False 

    def get_apply_to_count(self, max_rows, apply_to):
        # apply_to : 75%
        if apply_to.endswith("%"):
            count = int(int(apply_to.replace("%","")) * max_rows / 100)
        # apply_to : 9 
        else:
            count = int(apply_to)
        return count

    def process_to_date(self, end_date):
        current_date = self.parse_datetime(self.settings['last_processed'])
        end_date = self.parse_datetime(end_date)
        timedelta =self.get_time_delta(self.settings['grain'])
        logging.info(f"START DATE/TIME: {self.to_datetime_string(current_date)}")
        logging.info(f"END DATE/TIME: {self.to_datetime_string(end_date)}")
        while current_date < end_date:
            current_date = current_date + timedelta
            logging.info(f"DATE/TIME: {self.to_datetime_string(current_date)}")
            for job in [j for j in self.settings['jobs'] if j.get('active',False) ]:
                if self.should_execute(job['when'], current_date):
                    rows = self.execute_query(job['query_source'])
                    apply_to_count = self.get_apply_to_count(len(rows),job['apply_to_rows'])
                    logging.info(f"JOB: {job['name']} ROWS: {len(rows)} APPLY TO ROWS: {job['apply_to_rows']} COUNT: {apply_to_count}")
                    self.random.shuffle(rows)
                    total_executed = 0
                    job_sql = f"use {self.__dbname__}\n\n"
                    job_sql += job.get("pre_action","") + "\n"
                    for i in range(apply_to_count):
                        rnd = self.random.random()
                        if  rnd <= job['with_probability']:
                            run_code = eval(job.get('run_code','True'))
                            #logging.info(f"\tJOB EXECUTE: {job['name']} Probability: {job['with_probability']} Score: {rnd}")
                            sql = job['action']
                            params = {}
                            if job.get('params',0) != 0:
                                for key in job['params'].keys():
                                    params[key] =eval(job['params'][key])
                                    sql = sql.replace("{" + key + "}", str(params[key]))
                            #logging.info(f"\tEXECUTE SQL: {sql}")                            
                            total_executed +=1
                            job_sql += f"{sql}\n"
                    job_sql += job.get("post_action","") + "\n"
                    logging.info(f"\tTOTAL: Probability: {job['with_probability']} Actual: {total_executed} of {apply_to_count}")
                    if total_executed > 0 and apply_to_count >0:
                        filespec = self.__sql_job_filespec__.replace("{timestamp}", str(self.to_datetime_string(current_date,alldashes=True))).replace("{jobname}",job['name'])                    
                        logging.info(f"\tEXECUTING: {filespec}")
                        yield f"EXECUTING: {filespec}"
                        self.save_job_sql(job_sql, filespec)
                        self.execute_sql_job(filespec)
        self.settings['last_processed'] = self.to_datetime_string(current_date)
        self.save_settings()
        yield f"DONE! Data is current to {self.settings['last_processed']}" 

    def save_settings(self):
        with open (self.__update_filespec__,"w",encoding="utf-8") as f:
            json.dump(self.settings, f, indent=4)

    def save_job_sql(self, job_sql_text, filespec):
        with open (filespec, "w", encoding="utf-8") as f:
            f.write(job_sql_text)


if __name__=='__main__':
    random_seed = 0
    print("DatabaseUpdater")
    connstr= "/opt/mssql-tools18/bin/sqlcmd -S tcp:mssql,1433 -U sa -P SU2orange! -C"
    odbc_connstr = "DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost,1433;DATABASE=master;UID=sa;PWD=SU2orange!"

    dbu = DatabaseUpdater(random_seed, connstr, odbc_connstr,"./schemas", "payroll")
    assert dbu.get_time_delta("1d") == datetime.timedelta(days=1)
    assert dbu.get_time_delta("12h") == datetime.timedelta(hours=12)
    assert dbu.get_time_delta("5m") == datetime.timedelta(minutes=5)
    assert dbu.parse_datetime("2010-09-14") == datetime.datetime.fromtimestamp(time.mktime(time.strptime("2010-09-14 00:00:00", "%Y-%m-%d %H:%M:%S")))
    assert dbu.parse_datetime("2010-09-14 14:52:55") == datetime.datetime.fromtimestamp(time.mktime(time.strptime("2010-09-14 14:52:55", "%Y-%m-%d %H:%M:%S")))
    assert dbu.parse_datetime("2010-09-14 14:52:55.9999999") == datetime.datetime.fromtimestamp(time.mktime(time.strptime("2010-09-14 14:52:55", "%Y-%m-%d %H:%M:%S")))
    assert dbu.to_datetime_string(dbu.parse_datetime("2010-05-07 04:02:05")) == "2010-05-07 04:02:05"

    #generated = dbu.process_to_date("2018-01-06")
    #for g in generated:
    #    print(g)
    new_emp = dbu.datagen.payroll_get_new_employee([r[0] for r in dbu.execute_query('select employee_ssn from employees') ])
    print(new_emp)