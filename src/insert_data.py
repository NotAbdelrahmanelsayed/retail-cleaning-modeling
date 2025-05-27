from constants import DB_PARAMS, CONN_STR, PROJECT_PATH
from sqlalchemy import create_engine
import pandas as pd 


def check_table_exists(engine, table_name):
    """
    function checks if table exists in the database.
    """
    try:
        with engine.connect as conn:
            df = pd.read_sql_table(table_name, conn, chunksize=10)
            print(df.head(2))
        return True
    except ValueError:
        return False


def load_raw_data(path, engine, table_name):
    "function loads raw data to database"
    df = pd.read_excel(path)
    with engine.connect as conn:
        df.to_sql(table_name, engine, if_exists="replace", index=False)


engine = create_engine(CONN_STR)
table_name = DB_PARAMS['database']
data_path = PROJECT_PATH/"data/online_retail.xlsx"

if __name__ == "__main__":
    if not check_table_exists(engine, table_name):
        load_raw_data(data_path, engine, "raw_online_retail")