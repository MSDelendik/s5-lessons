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
    'retries': 0
}

business_dt = '{{ ds }}'

with DAG(
        'dds_insert',
        default_args=args,
        schedule_interval='0/15 * * * *',  # Задаем расписание выполнения дага - каждый 15 минут.
        description='Provide default dag for sprint5',
        catchup=False,
        start_date=datetime.today()
) as dag:

    update_dm_users = PostgresOperator(
        task_id='update_dm_users',
        postgres_conn_id=postgres_conn_id,
        sql="dm_users.sql"),

    update_dm_restaurants = PostgresOperator(
        task_id='update_dm_restaurants',
        postgres_conn_id=postgres_conn_id,
        sql="dm_restaurants.sql"),

    update_dm_timestamps = PostgresOperator(
        task_id='update_dm_timestamps',
        postgres_conn_id=postgres_conn_id,
        sql="dm_timestamps.sql")

[update_dm_users, update_dm_restaurants, update_dm_timestamps]