# Telco Analytics Pipeline

A local data platform built with Docker Compose, featuring Airflow, PostgreSQL, dbt, and Python. This project was developed as the final assignment for the Qversity program, a hands-on academic initiative focused on Data & AI.

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
├── docs/                 # Documentation
│   ├── gold_report.md    # Business questions
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


## Owner

- **Name**: Sofía Llavayol
- **Email**: so.llavayol@gmail.com


## Overview

This project implements a full ELT data pipeline following the Medallion Architecture (bronze, silver, gold), orchestrated using Apache Airflow, transformed with dbt, and stored in PostgreSQL.

At the bronze stage, the pipeline performs the following:

- Downloads a JSON dataset from a public S3 bucket.
- Loads the raw data into a PostgreSQL database under the `bronze` schema for further processing. The table created is named `bronze_mobile_customers`. This table has 5000 rows of type `jsonb`, each of which cointains the customer's information to be processed.

Below we develop on the silver and gold stages.

### Silver stage

The Silver layer focuses on cleaning and structuring the raw JSON data from the `bronze.bronze_mobile_customers` table into a set of well-defined and normalized tables, designed for reliable downstream use.

#### Silver tables

This stage produces four tables:

- `silver_mobile_customers`: One row per customer, containing standardized fields such as name, email, operator, plan type, credit score, and more. Customers are uniquely identified by a surrogate key `customer_sk`, formed with the values `customer_id`, `operator`, `first_name` and `last_name` obtained from the raw data. Each customer is also linked to a city via the `city_sk` foreign key referencing the `silver_cities` table.

- `silver_cities`: A list of unique cities extracted from the raw JSON file, each paired with verified latitude, longitude, and ISO country codes. Inconsistent country/city pairs in the raw data were resolved by treating the city as correct and joining to this validated reference table.

- `silver_payment_history`: Normalized payment history records, with one row per payment. This table handles both structured JSON arrays and string-based representations like `"paid,paid,late,paid"`. Fields include `payment_date`, `status`, and `amount` (null if unknown).

- `silver_contracted_services`: One row per customer and contracted service (DATA, INTERNATIONAL, ROAMING, SMS, VOICE). Handles both structured arrays and comma-separated strings.

#### Data Cleaning Decisions

Some important transformations and cleaning decisions were applied:

- Invalid or inconsistent fields were removed:

   - `record_uuid`, `latitude`, `longitude`, and `customer_id` were excluded from the silver tables due to inconsistencies and low reliability.

   - Instead, we introduced a surrogate key (`customer_sk`) based on a hash of multiple fields (`customer_id`, `operator`, `first_name` and `last_name`) to ensure uniqueness and allow joins.

- Inconsistent city/country pairs in the raw data were resolved by treating the city as correct and matching it to a validated `silver_cities` table containing verified latitude, longitude, and ISO country codes. The original country value from the raw data was retained as `country_raw` in this silver layer to maintain traceability and support downstream quality assurance processes.

- Surrogate Keys: Both customers and cities use surrogate keys (`customer_sk`, `city_sk`) for clean relational joins.

- Credit score filtering: The `credit_score` field was cleaned by enforcing a valid range between 300 and 850. Values outside this range were set to null. Out of 5,000 records, only 46 entries had invalid credit scores, so this cleaning affects less than 1% of the data. This step ensures data quality and consistency for downstream analysis.

- Age filtering: Age values were converted to integers. Values outside the range 0–110 were treated as invalid and set to null. A total of 115 entries had invalid ages, and the final dataset includes only reasonable adult ages between 18 and 80.

- Negative values filtering: fields such as `monthly_data_gb` and `monthly_bill_usd` are expected to contain non-negative numbers. Any values below zero were considered invalid and replaced with null. In total, fewer than 70 entries contained negative values across both fields.

- Invalid dates handling: Dates later than `2025-06-12` (the raw data extraction date) were treated as invalid and set to null. A total of 101 entries had invalid date for `registration_date`, whereas all entries had valid date for `last_payment_date` and `payment_date`. This cleaning affected only the 2% of the data.

- Standardized text fields: Names, cities, operators, plan types, statuses, and device brands were all normalized via dbt macros. This included trimming spaces, fixing casing, and handling missing values consistently. Although fields like `first_name` and `last_name` are not directly required for business analysis, a lightweight normalization step was applied (removes digits, trims spaces, capitalizes the first letter of each word) to prepare them for potential future use cases (e.g., customer communications or deduplication).


#### Macros and Reusability

To promote consistency and not repeat code, a set of reusable macros was created. These handle common normalization tasks: `normalize_city`, `normalize_country`, `normalize_device_brand`, `normalize_hour`, `normalize_name`, `normalize_operator`, `normalize_plan_type`, `normalize_status`.


### Gold stage

In the Gold layer, a series of analytics-oriented tables were created based on the cleaned and structured data from the Silver layer. These tables are designed to answer specific business questions and support reporting, dashboards, and decision-making.

The following Gold models were added:

- `gold_customer_revenue_metrics`: Contains revenue-related attributes per customer, including monthly bill, operator, plan type, and geographic location. Used to compute ARPU, revenue distribution, and high-value segments.

- `gold_customer_demographics`: Includes age, status, plan type, operator, and geographic information for all customers. Supports demographic breakdowns by plan, location, and operator.

- `gold_device_preferences`: Summarizes device brand usage and preferences across countries, operators, and plan types.

- `gold_contracted_services_analysis`: Explores the services contracted by each customer (e.g., DATA, SMS, VOICE), including common service combinations and revenue implications.

- `gold_payment_behavior`: Merges payment history with credit score information to identify payment issues, pending payments, and correlations with credit score.

- `gold_customer_trends`: Tracks customer acquisition over time by registration date and operator.

These tables allow us to efficiently compute business metrics and generate insights directly from SQL models. All business questions and conclusions derived from these models are answered and documented in `docs/gold_report.md`.

## Quick Start

### Prerequisites
- Docker and Docker Compose installed
- At least 4GB RAM available

### Setup

These instructions were tested and successfully run on Ubuntu Linux.

1. Clone the repo:

```bash
git clone https://github.com/sofillav/qversity-data-2025-montevideo-sofiallavayol.git
cd qversity-data-2025-montevideo-sofiallavayol
```

2. Copy the example environment file and ensure `entrypoint.sh` is executable:

```bash
cp env.example .env
chmod +x entrypoint.sh
```

## Run pipeline

3. Start the containers:

```bash
docker compose up -d
```

4. Wait until Airflow UI is available at http://localhost:8080

5. Login with:

   - Username: `admin`

   - Password: `admin`

6. Unpause the DAG `full_pipeline_dag` and trigger it:

   - From the UI, or

   - Using CLI commands:

```bash
docker compose exec --user airflow airflow airflow dags unpause full_pipeline_dag
docker compose exec --user airflow airflow airflow dags trigger full_pipeline_dag
```

This DAG will:
- Download the JSON file
- Load it into PostgreSQL (bronze schema)
- Run dbt models (silver and gold layers)
- Run dbt tests

## Run tests

The pipeline includes a task that automatically runs `dbt test` to validate the models. You can view the test results in the logs of the corresponding task from the Airflow UI.

To run the tests manually, use the following commands:

```bash
docker compose exec dbt dbt test
```

or

```bash
docker compose exec dbt dbt test --models <model_name>
```

## Using pgAdmin

To explore the created tables visually with pgAdmin, follow the steps below:

1. Visit: http://localhost:5050

2. Login

   - Username: `admin@admin.com`

   - Password: `admin`

3. Register your Postgres server

   - Clic on *Add New Server*.

   - Go to the *General* tab:

      - Name: any name (e.g., `Qversity Postgres`)

   - Go to the  *Connection* tab:

      -  Host name/address: `postgres` (this is the Docker service name)

      -  Port: `5432`

      -  Username: `qversity-admin`

      -  Password: `qversity-admin`

   - Click *Save*

4. Open the Query Tool

   - In the left sidebar, expand: Servers → Databases → qversity → Schemas (e.g., `public_silver`)

   - Right-click the qversity database → *Query Tool*

   - Type and run SQL queries like:

```sql
SELECT * FROM public_silver.silver_mobile_customers LIMIT 10;
```

## Common Commands

### Access Points

- **Airflow UI**: http://localhost:8080 (`admin`/`admin`)
- **Airflow UI**: http://localhost:5050 (`admin@admin.com`/`admin`)
- **PostgreSQL**: localhost:5432 (`airflow`/`airflow`)


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
dbt run --models public_silver
dbt run --models public_gold

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

### Testing

```bash
# Run dbt tests
docker compose exec dbt dbt test

# Run specific test
docker compose exec dbt dbt test --models test_customer_email_validity
```

### Monitoring

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

### Cleanup

```bash
# Stop services
docker compose down

# Remove volumes (⚠️ deletes all data)
docker compose down -v

# Remove images
docker compose down --rmi all
```

