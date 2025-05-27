import os 

from sqlalchemy import create_engine
import pandas as pd 
from pathlib import Path

DB_PARAMS = {
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT"),
    "database": os.getenv("DB_DATABASE"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
}

conn_str = f"postgresql://{DB_PARAMS['user']}:{DB_PARAMS['password']}@{DB_PARAMS['host']}:{DB_PARAMS['port']}/{DB_PARAMS['database']}"
engine = create_engine(conn_str)


with engine.connect() as conn:
    try:
        df = pd.read_sql_table(DB_PARAMS['database'], conn, chunksize=10)
        print("df already exists")
    except ValueError:
        print("table not found uploading it....")
        
        project_path = Path("/usr/app/")
        df = pd.read_excel(project_path/"data/online_retail.xlsx")
        df.to_sql("raw_online_retail", engine, if_exists="replace", index=False)