E-Commerce Data Platform on Azure
An end-to-end data engineering project using the Brazilian E-Commerce (Olist) dataset on Microsoft Azure. This project implements a full Lakehouse architecture — from raw ingestion to a star schema data warehouse — following modern data engineering best practices.

🏗️ Architecture Overview
Kaggle (Raw CSVs)
       │
       ▼
Azure Data Factory ──► ADLS Gen2 (Bronze Layer)
                              │
                              ▼
                    Azure Databricks (Silver Layer)
                    Delta Lake / PySpark transforms
                              │
                              ▼
                    Azure Synapse Analytics (Gold Layer)
                    Star Schema Data Warehouse
                              │
                              ▼
                    dbt Core + GitHub Actions (CI/CD)

📐 Star Schema Design
The gold layer is modelled as a star schema with one central fact table and five dimension tables.
Fact Table
TableDescriptionfact_ordersOne row per order item. Contains all measurable metrics — payment value, freight, review score — and foreign keys to all dimensions.
Dimension Tables
TableGrainKey Columnsdim_customersOne row per customercustomer_key, city, state, zip_codedim_productsOne row per productproduct_key, category, weight_g, name_lengthdim_sellersOne row per sellerseller_key, city, state, zip_codedim_dateOne row per calendar datedate_key, year, month, quarter, is_weekenddim_paymentsOne row per payment methodpayment_key, payment_type, installments

🗂️ Project Structure
olist-azure-de/
├── ingestion/
│   └── adf_pipelines/          # ARM templates for ADF pipelines
├── transformation/
│   ├── bronze_to_silver/       # Databricks notebooks (PySpark)
│   └── silver_to_gold/         # dbt models
├── warehouse/
│   └── synapse_ddl/            # Synapse SQL DDL scripts
├── dbt/
│   ├── models/
│   │   ├── staging/            # Source-aligned models
│   │   ├── intermediate/       # Joins and business logic
│   │   └── marts/              # Fact and dimension tables
│   ├── tests/                  # dbt data quality tests
│   └── dbt_project.yml
├── .github/
│   └── workflows/
│       └── dbt_run.yml         # CI/CD pipeline
├── docs/
│   └── schema_diagram.png
└── README.md

⚙️ Tech Stack
LayerToolPurposeIngestionAzure Data FactoryParameterized CSV ingestion from source to bronzeStorageAzure Data Lake Gen2Bronze / Silver / Gold layered storageTransformationAzure Databricks + PySparkData cleaning, joins, Delta Lake writesWarehouseAzure Synapse AnalyticsStar schema, analytical SQL queriesModellingdbt CoreDocumented, tested SQL transformsCI/CDGitHub ActionsAutomated dbt runs on PR mergeSource DataKaggle — Olist Dataset100k orders, 9 source tables

🚀 Getting Started
Prerequisites

Azure subscription with the following services provisioned:

Azure Data Lake Storage Gen2
Azure Data Factory
Azure Databricks workspace
Azure Synapse Analytics workspace


Python 3.9+
dbt Core installed (pip install dbt-synapse)
Kaggle API key configured

1. Download the Dataset
bashkaggle datasets download -d olistbr/brazilian-ecommerce
unzip brazilian-ecommerce.zip -d data/raw/
2. Upload Raw Files to Bronze Layer
bashaz storage blob upload-batch \
  --account-name <your-storage-account> \
  --destination bronze/olist \
  --source data/raw/
3. Run ADF Pipeline
Trigger the pl_ingest_olist_bronze pipeline in Azure Data Factory to land all CSV files into the bronze container with audit columns appended.
4. Run Databricks Notebooks
Execute the notebooks in order:
1. bronze_to_silver/01_clean_orders.ipynb
2. bronze_to_silver/02_clean_customers.ipynb
3. bronze_to_silver/03_clean_products.ipynb
4. bronze_to_silver/04_build_silver_layer.ipynb
5. Run dbt Models
bashcd dbt/
dbt deps
dbt run --target prod
dbt test
dbt docs generate && dbt docs serve

📊 Sample Analytical Queries
Revenue by product category (last 90 days)
sqlSELECT
    p.product_category,
    SUM(f.payment_value)   AS total_revenue,
    COUNT(DISTINCT f.order_id) AS total_orders,
    AVG(f.payment_value)   AS avg_order_value
FROM fact_orders f
JOIN dim_products p ON f.product_key = p.product_key
JOIN dim_date d     ON f.date_key    = d.date_key
WHERE d.order_date >= DATEADD(DAY, -90, GETDATE())
GROUP BY p.product_category
ORDER BY total_revenue DESC;
Monthly revenue trend by state
sqlSELECT
    d.year,
    d.month,
    c.customer_state,
    SUM(f.payment_value) AS revenue
FROM fact_orders f
JOIN dim_customers c ON f.customer_key = c.customer_key
JOIN dim_date d      ON f.date_key     = d.date_key
GROUP BY d.year, d.month, c.customer_state
ORDER BY d.year, d.month;

🧪 Data Quality Tests (dbt)
Tests are defined in dbt/tests/ and run automatically in CI/CD.
TestTableDescriptionnot_nullfact_orders.order_idEvery order must have an IDuniquefact_orders.order_idNo duplicate ordersnot_nullfact_orders.payment_valueNo null revenue rowsaccepted_valuesdim_payments.payment_typeOnly known payment typesrelationshipsfact_orders → dim_customersAll FK keys must resolve

📈 Medallion Layer Summary
LayerLocationFormatDescriptionBronzeabfss://bronze@<account>.dfs.core.windows.net/olist/CSV (raw)Raw files as-is from sourceSilverabfss://silver@<account>.dfs.core.windows.net/olist/DeltaCleaned, typed, dedupedGoldAzure Synapse dedicated SQL poolSQL tablesStar schema, business-ready

🤝 Contributing
Pull requests welcome. Please open an issue first to discuss any major changes.

📄 License
MIT

🙏 Acknowledgements

Olist for making the dataset publicly available on Kaggle
Dataset: Brazilian E-Commerce Public Dataset by Olist
