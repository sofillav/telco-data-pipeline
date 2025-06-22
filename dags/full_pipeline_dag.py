from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from datetime import datetime
import requests
import os

def download_json():
    url = "https://qversity-raw-public-data.s3.amazonaws.com/mobile_customers_messy_dataset.json"
    local_path = "/opt/airflow/data/raw/mobile_customers_messy_dataset.json"
    os.makedirs(os.path.dirname(local_path), exist_ok=True)
    response = requests.get(url)
    response.raise_for_status()
    with open(local_path, 'wb') as f:
        f.write(response.content)

def load_to_postgres():
    import psycopg2
    import json

    conn = psycopg2.connect(
        dbname="qversity",
        user="qversity-admin",
        password="qversity-admin",
        host="postgres"
    )
    cursor = conn.cursor()
    cursor.execute("DROP TABLE IF EXISTS bronze.bronze_mobile_customers;")
    cursor.execute("CREATE SCHEMA IF NOT EXISTS bronze;")
    cursor.execute("CREATE TABLE bronze.bronze_mobile_customers (data jsonb);")

    with open("/opt/airflow/data/raw/mobile_customers_messy_dataset.json", 'r') as f:
        data = json.load(f)
        for record in data:
            cursor.execute("INSERT INTO bronze.bronze_mobile_customers (data) VALUES (%s);", [json.dumps(record)])
    
    conn.commit()
    cursor.close()
    conn.close()

# dag
default_args = {
    'owner': 'sofiallavayol',
    'start_date': datetime(2025, 6, 1),
}

with DAG(
    dag_id='full_pipeline_dag',
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
    description='Complete pipeline: Bronze -> Silver'
) as dag:

    download = PythonOperator(
        task_id='download_json',
        python_callable=download_json
    )

    load = PythonOperator(
        task_id='load_to_postgres',
        python_callable=load_to_postgres
    )

    dbt_run = BashOperator(
        task_id='silver_dbt_run',
        bash_command='cd /dbt && dbt run --models silver'

    )

    dbt_test = BashOperator(
        task_id='silver_dbt_test',
        bash_command='cd /dbt && dbt test --models silver'
    )   

    download >> load >> dbt_run >> dbt_test
