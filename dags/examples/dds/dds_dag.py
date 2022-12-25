import time
import requests
import json
import pandas as pd

from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python_operator import PythonOperator, BranchPythonOperator
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.hooks.http_hook import HttpHook

postgres_conn_id = 'PG_WAREHOUSE_CONNECTION'

args = {
    "owner": "student",
    'email': ['student@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1
}

business_dt = '{{ ds }}'

with DAG(
        'dds_insert',
        default_args=args,
        description='Provide default dag for sprint5',
        catchup=False,
) as dag:

    update_d_item_table = PostgresOperator(
        task_id='update_dm_users',
        postgres_conn_id=postgres_conn_id,
        sql="sql/dn_users.sql")
(
update_dm_users
)