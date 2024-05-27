from flask import Flask, render_template, abort, redirect, url_for, Response, stream_with_context
from dbprovisioner import DatabaseProvisioner
from dbcollection import DatabaseCollection, README 
from dbupdater import DatabaseUpdater
import markdown 
import os
import logging 
import sys
from datetime import datetime
import re
import time 
import json 
import random 


logging.basicConfig(format='%(levelname)s: %(asctime)s => %(message)s', level=logging.INFO, stream=sys.stdout)

schema_path = os.environ['SCHEMA_PATH'] if  'SCHEMAPATH' in os.environ.keys() else os.path.join(".","schemas")
sql_client_host = os.environ['SQL_CLIENT_HOST'] if  'SQL_CLIENT_HOST' in os.environ.keys() else "mssql"
sql_client_port = os.environ['SQL_CLIENT_PORT'] if  'SQL_CLIENT_PORT' in os.environ.keys() else "1433"
sql_client_user = os.environ['SQL_CLIENT_USER'] if  'SQL_CLIENT_USER' in os.environ.keys() else "sa"
sql_client_pass = os.environ['SQL_CLIENT_PASS'] if  'SQL_CLIENT_PASS' in os.environ.keys() else "SU2orange!"
sql_client_cmd = os.environ['SQL_CLIENT_CMD'] if  'SQL_CLIENT_CMD' in os.environ.keys() else "/opt/mssql-tools18/bin/sqlcmd"
random_seed = int(os.environ['RANDOM_SEED']) if  'RANDOM_SEED' in os.environ.keys() else 0
connstr = f"{sql_client_cmd} -S tcp:{sql_client_host},{sql_client_port} -U {sql_client_user} -P {sql_client_pass} -C "
odbc_connstr = "DRIVER={ODBC Driver 17 for SQL Server};" + f"SERVER={sql_client_host},{sql_client_port};DATABASE=master;UID={sql_client_user};PWD={sql_client_pass}"
conn = { 'host' : sql_client_host, 'port' : sql_client_port, 'user' : sql_client_user, 'pass' : sql_client_pass }

random.seed(random_seed)

logging.info(f"CONNSTR : {connstr}")
logging.info(f"SCHEMA_PATH : {schema_path}")
logging.info(f"RANDOM_SEED : {random_seed}")

app = Flask(__name__)
dbc = DatabaseCollection(schema_path) 
dbp = DatabaseProvisioner(connstr, schema_path)


@app.route("/")
def home():
    dbc.crawl()    
    return render_template('index.html', databases = dbc.collection, conn=conn)

@app.route("/readme/<dbname>")
def readme(dbname):
    filespec = os.path.join(schema_path,dbname,README)
    if os.path.exists(filespec):
        cdn = '<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">'
        head = f'<!DOCTYPE html>\n<html lang="en">\n<head>\n\t{cdn}\n</head>\n<body class="container">\n'
        foot = "</body></html>"
        content = dbc.__read_file_contents__(filespec)
        html = markdown.markdown(content)
        html = head + html + foot
        return html
    else:
        return redirect(url_for('home'))

@app.route("/drop/<dbname>")
def drop(dbname = None):
    if dbname != None:
        rows = dbp.drop(dbname)
        date = datetime.now()
        dbc.clear_last_provision(dbname)
        return Response(stream_template('init.html', rows=rows))    
    else:
        return redirect(url_for('home'))


def stream_template(template_name, **context):
    app.update_template_context(context)
    t = app.jinja_env.get_template(template_name)
    rv = t.stream(context)
    rv.enable_buffering(5)
    return rv


@app.route("/init/<dbname>")
def dbinit(dbname):
    if dbname != None:
        rows = dbp.initialize(dbname)
        date = datetime.now()
        dbc.set_last_provision(dbname, date)
        return Response(stream_template('init.html', rows=rows))    
    else:
        return redirect(url_for('home'))


@app.route("/update/<dbname>")
def dbupdate(dbname):
    updatable = [ c['name'] for c in dbc.collection if not c['static'] ]
    if dbname != None and dbname in updatable:
        dbu = DatabaseUpdater(random_seed, connstr, odbc_connstr, schema_path, dbname)
        rows = dbu.process_to_date('2020-04-15')
        return Response(stream_template('init.html', rows=rows))    
    else:
        return redirect(url_for('home'))

@app.route("/remove/<dbname>")
def removescripts(dbname):
    updatable = [c['name'] for c in dbc.collection if not c['static'] ]
    if dbname != None and dbname in updatable:
        rows = dbp.remove_scripts(dbname)
        return Response(stream_template('init.html', rows=rows))    
    else:
        return redirect(url_for('home'))


if __name__ == "__main__":
    from waitress import serve
    serve(app, host="0.0.0.0", port=8000)


'''
********************************************** CUT HERE ******************************************
'''

@app.route("/stream")
def stream():
    def generate():
        yield "<code>"
        yield "1\n"
        time.sleep(1)
        yield "2\n"
        time.sleep(1)
        yield "3\n"
        time.sleep(1)
        yield "4\n"
        time.sleep(1)
        yield "5\n"
        time.sleep(1)
        yield "</code>"
    return Response(stream_with_context(generate()))


'''
This is obsolete!!!!
'''
@app.route("/prov/<dbname>")
def provision(dbname = None):
    drop = True
    if dbname != None:
        def generate():
            script_path = os.path.join(dbp.__schema_base_path__, dbname,'mssql')
            logging.info(f"PATH: {script_path}")
            yield f"PATH: {script_path}<br>"
            files = os.listdir(script_path)
            downscript = [file for file in files if file.startswith("dn-0")][0]
            if drop:
                logging.info(f"EXECUTE FILE: {downscript}")
                yield f"EXECUTE FILE: {downscript}<br>"
                sql = dbp.__read_file_contents__(os.path.join(script_path, downscript))
                logging.debug(sql)
                dbp.execute(sql)
            upscripts = [file for file in files if file.startswith("up-")]
            upscripts.sort()
            for script in upscripts:
                sql = dbp.__read_file_contents__(os.path.join(script_path, script))
                logging.info(f"EXECUTE FILE: {script}")
                yield f"EXECUTE FILE: {script}<br>"
                logging.debug(sql)
                dbp.execute(sql)
            date = datetime.now()
            dbc.set_last_provision(dbname, date)
            yield f"FINISHED ON: {date}<br>"    
        return Response(generate())
    else:
        return redirect(url_for('home'))
