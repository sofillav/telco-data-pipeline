from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import json
import psycopg2
import requests
import os

# Paths
url = "https://qversity-raw-public-data.s3.amazonaws.com/mobile_customers_messy_dataset.json"
local_path = "/opt/airflow/data/raw/mobile_customers_messy_dataset.json"

def download_json():
    response = requests.get(url)
    response.raise_for_status()
    os.makedirs(os.path.dirname(local_path), exist_ok=True)
    with open(local_path, 'wb') as file:
        file.write(response.content)

def load_to_postgres():
    with open(local_path, 'r') as file:
        # List of dictionaries
        data = json.load(file)

    # Connect to the PostgreSQL database
    conn = psycopg2.connect(
        host="postgres",
        dbname="qversity",
        user="qversity-admin",
        password="qversity-admin"
    )

    # Open a cursor to run SQL commands
    cur = conn.cursor()

    cur.execute("""
        CREATE SCHEMA IF NOT EXISTS bronze;
        CREATE TABLE IF NOT EXISTS bronze.mobile_customers (
            id SERIAL PRIMARY KEY,
            data JSONB,
            ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
    """)

    for row in data:
        json_row = json.dumps(row)  # Convert Python dictionary to JSON string
        cur.execute(
            "INSERT INTO bronze.mobile_customers (data) VALUES (%s)",
            [json_row]
        )

    # Save changes to the database
    conn.commit()

    cur.close()
    conn.close()


# Dag
with DAG(
    dag_id='bronze_ingest_dag',
    start_date=datetime(2025, 6, 1),
    schedule_interval=None,
    catchup=False
) as dag:

    download = PythonOperator(
        task_id='download_json',
        python_callable=download_json
    )

    load = PythonOperator(
        task_id='load_to_postgres',
        python_callable=load_to_postgres
    )

    download >> load
