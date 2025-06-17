# Qversity Project

A data local data platform using Docker Compose with Airflow, PostgreSQL, dbt, and Python.

## Architecture

This project implements a Bronze-Silver-Gold data lakehouse architecture:

- **Bronze Layer**: Raw data ingestion and staging
- **Silver Layer**: Cleaned and standardized data
- **Gold Layer**: Business-ready analytics and aggregations

## Project Structure

```
/
├── dags/                 # Airflow DAG definitions
├── dbt/                  # dbt project
│   ├── models/           # dbt models (bronze, silver, gold)
│   │   ├── bronze/       # Raw data staging
│   │   ├── silver/       # Cleaned data
│   │   └── gold/         # Business analytics
│   ├── tests/            # dbt tests
│   ├── dbt_project.yml   # dbt configuration
│   └── profiles.yml      # Database connections
├── scripts/              # Setup and utility scripts
├── data/                 # Data files
│   ├── raw/              # Raw input data
│   └── processed/        # Processed output data
├── logs/                 # Application logs
├── env.example           # Environment variables template
├── .gitignore            # Python/SQL gitignore
├── docker compose.yml    # Docker environment setup
├── requirements.txt      # Python dependencies
└── README.md             # This file
```

## Quick Start

### Prerequisites
- Docker and Docker Compose installed
- At least 4GB RAM available

### Setup

1. **Clone and setup environment**:
```bash
# Copy environment template
cp env.example .env
```

2. **Manual setup** (alternative):
```bash
# Start services
docker compose up -d
```

## Access Points

- **Airflow UI**: http://localhost:8080 (admin/admin)
- **PostgreSQL**: localhost:5432 (airflow/airflow)

## Common Commands

### Airflow
```bash
# View Airflow logs
docker compose logs -f airflow

# Trigger a DAG manually
docker compose exec airflow airflow dags trigger hello_world_dag
```

### dbt
```bash
# Enter dbt container
docker compose exec dbt bash

# Run all models
dbt run

# Run specific layer
dbt run --models bronze
dbt run --models silver
dbt run --models gold

# Test data quality
dbt test

# Generate documentation
dbt docs generate
dbt docs serve
```

### Database Access
```bash
# Connect to PostgreSQL
docker compose exec postgres psql -U qversity-admin -d qversity

# View created schemas
\dn

# View tables in bronze schema
\dt bronze.*
```

## Testing

```bash
# Run dbt tests
docker compose exec dbt dbt test

# Run specific test
docker compose exec dbt dbt test --models test_customer_email_validity
```

## Development

### Adding New DAGs
1. Create Python files in `dags/`
2. DAGs will be automatically picked up by Airflow

### Adding dbt Models
1. Create SQL files in appropriate layer directories:
   - `dbt/models/bronze/` for raw data
   - `dbt/models/silver/` for cleaned data
   - `dbt/models/gold/` for analytics

### Environment Configuration
- Copy `env.example` to `.env` and customize
- Modify `docker compose.yml` for additional services

## Monitoring

```bash
# View all service logs
docker compose logs -f

# View specific service logs
docker compose logs -f airflow
docker compose logs -f dbt
docker compose logs -f postgres

# Check service status
docker compose ps
```

## Cleanup

```bash
# Stop services
docker compose down

# Remove volumes (⚠️ deletes all data)
docker compose down -v

# Remove images
docker compose down --rmi all
```







## Overview

This project implements a full ELT data pipeline following the Medallion Architecture (bronze, silver, gold), orchestrated using Apache Airflow, transformed with dbt, and stored in PostgreSQL.

At this stage, the pipeline performs the following:

- Downloads a JSON dataset from a public S3 bucket.
- Loads the raw data into a PostgreSQL database under the `bronze` schema for further processing.

Future stages will include cleaning (Silver) and aggregating/analyzing the data (Gold).

## Participant

- **Name**: Sofía Llavayol
- **Email**: so.llavayol@gmail.com

## Quick Start

1. Clone the repo:

```bash
git clone https://github.com/sofillav/qversity-data-2025-montevideo-sofiallavayol.git
cd qversity-data-2025-montevideo-sofiallavayol
```

2. Give the `data` and `logs` directories the proper permissions so Airflow works correctly:

```bash
mkdir -p logs
chmod -R 777 data logs
```

3. Start the pipeline environment:

```bash
docker compose up -d
```

## Run pipeline

Visit http://localhost:8080 (admin/admin) and trigger the `bronze_ingest_dag`. From the Airflow UI:

- Locate the DAG named `bronze_ingest_dag`.
- Trigger it manually.
- The DAG will:
   - Download the `mobile_customers_messy_dataset.json` file from the S3 bucket.
   - Load it into the PostgreSQL database under `bronze.bronze_mobile_customers`.

## Run tests

Will be added in later stages.