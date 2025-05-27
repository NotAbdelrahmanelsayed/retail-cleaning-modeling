from constants import CONN_STR, PROJECT_PATH
from sqlalchemy import create_engine, inspect
import pandas as pd 
import logging  

logging.basicConfig(level=logging.INFO)
log = logging.getLogger("insert_data")


def check_table_exists(engine, table_name):
    """
    function checks if table exists in the database.
    """
    inspector = inspect(engine)
    log.info(f"existing tables {inspector.get_table_names()}")
    log.info(f"{table_name=}")
    return table_name in inspector.get_table_names()


def load_raw_data(path, engine, table_name):
    "function loads raw data to database"
    try:
        df = pd.read_excel(path)
        with engine.connect() as conn:
            df.to_sql(table_name, engine, if_exists="replace", index=False)
    except Exception as e:
        log.error(f"failed to load data into `{table_name}`: {e}")


if __name__ == "__main__":
    engine = create_engine(CONN_STR)
    table_name = "raw_online_retail"
    data_path = PROJECT_PATH/"data/online_retail.xlsx"

    if check_table_exists(engine, table_name):
        log.info(f"table `{table_name}` already exists in the database")
    else:
        log.info(f"uploading table `{table_name}` to database.....")
        load_raw_data(data_path, engine, table_name)