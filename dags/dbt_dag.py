from airflow import DAG
from airflow_dbt.operators.dbt_operator import (
    DbtSeedOperator,
    DbtSnapshotOperator,
    DbtRunOperator,
    DbtTestOperator,
    DbtDocsGenerateOperator
)
from airflow.utils.dates import days_ago

default_args = {
  'dir': '/srv/app/dbt',
  'start_date': days_ago(0)
}

with DAG(dag_id='dbt', default_args=default_args, schedule_interval='@daily') as dag:

  dbt_seed = DbtSeedOperator(
    task_id='dbt_seed',
  )

  dbt_snapshot = DbtSnapshotOperator(
    task_id='dbt_snapshot',
  )

  dbt_run = DbtRunOperator(
    task_id='dbt_run',
  )

  dbt_test = DbtTestOperator(
    task_id='dbt_test',
    retries=0,  # Failing tests would fail the task, and we don't want Airflow to try again
  )

  dbt_docs = DbtDocsGenerateOperator(
    task_id = 'dbt_docs_generate'
  )
  
  dbt_seed >> dbt_snapshot >> dbt_run >> dbt_test >> dbt_docs