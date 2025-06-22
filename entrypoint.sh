#!/bin/bash

echo ">>> Initializing Airflow database..."
airflow db init

echo ">>> Running database migrations..."
airflow db migrate

echo ">>> Creating admin user (if it doesn't exist)..."
airflow users create --username admin --password admin --firstname Admin --lastname User --role Admin --email admin@example.com

echo ">>> Starting scheduler and webserver..."
airflow scheduler & airflow webserver
