# Dbt Project: `online_retail`

## 📁 Folder Structure

```
online_retail/
├── dbt_project.yml           # DBT configuration
├── profiles.yml              # Connection to PostgreSQL (uses .env variables)
├── models/                   # Core DBT models (Staging → Intermediate → Dimensions → Facts)
├── tests/                    # Custom SQL tests
├── macros/                   # Custom reusable macros (unused)
├── snapshots/                # Snapshot tracking (unused)
├── analyses/                 # Analysis queries (unused)
├── seeds/                    # Seed files (unused)
├── .gitignore
├── .user.yml
└── README.md                 # This file

````

## 🛠 DBT Model Layers

### 🔹 Staging (`staging/`)
- Standardizes raw data
- Filters nulls
- Casts column types

### 🔸 Intermediate (`intermediate/`)
- Calculates invoice totals
- Derives first and last order dates per customer

### 🟦 Dimensions (`dim/`)
- `dim_customer`: Country and order info
- `dim_date_anchor`: Snapshot date for churn analysis
- `dim_date_customer_last_purchase`: Last order date per customer

### 🟨 Facts (`fact/`)
- `fact_customer_behaviour`: Total spend, churn, segment per customer
- `fact_country_performance`: Revenue, orders per country

## 🚀 Usage 

Inside the dbt container run:

```bash
dbt run                # Run DBT models
dbt test               # Test DBT models
dbt docs generate      # Generate DBT documentation
dbt docs serve         # Serve and view documentation
```