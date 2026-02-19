# Futures and Options Multi-Exchange Database

A scalable **multi-exchange derivatives database** with ETL pipelines, analytical queries, and optimized schema design for large-scale financial data ingestion and time-series analytics.

---

## 📌 Dataset Source

**Dataset:** NSE Futures & Options Dataset (3 Months)  
**Source:** Kaggle  

The dataset contains contract-level derivatives trading data including symbol, expiry, strike price, open interest, traded volume, and pricing details.

---

## 🏗 Architecture Flow

```
Kaggle CSV Files
↓
Python ETL (pandas + SQLAlchemy)
↓
PostgreSQL 15 (Indexed Tables)
↓
Analytical SQL Queries (Window Functions, Aggregations)
↓
Query Outputs & Performance Analysis

```

This pipeline simulates a real-world financial data ingestion and analytics workflow.

---

## 🗄 Database Design & Rationale

### Normalization Choices

- Single fact table (`fo_data`) stores all derivatives contract-level data  
- Strike price (`strike_pr`) and expiry date (`expiry_dt`) stored as separate indexed columns to optimize option-chain filtering and expiry-based analytics  
- No redundant duplication of contract attributes  
- Multi-exchange support implemented using `exchange_name` column  

### Why Star Schema Was Avoided

- Dataset is highly transactional and time-series driven  
- Most queries operate on aggregated contract-level analytics  
- Joining multiple dimension tables would increase query latency  
- A well-indexed fact table performs efficiently for derivatives time-series workloads  

---

## 🚀 Scalability Strategy (10M+ Rows Ready)

- B-tree indexes on `symbol`, `timestamp`, and `exchange_name`  
- Optional BRIN index on `timestamp` for very large datasets  
- Bulk ingestion using PostgreSQL `COPY` command  
- Query optimization using window functions and indexed filtering  
- Extensible design for partitioning by `expiry_dt`  
- Query performance validated on ~3M+ rows dataset  

**Database Engine:** PostgreSQL 15  

---

## 📂 SQL Scripts

| Script        | Purpose                          |
|---------------|----------------------------------|
| `schema.sql`  | CREATE TABLE definitions         |
| `indexes.sql` | CREATE INDEX statements          |
| `queries.sql` | Analytical queries               |

Partitioning strategy described in documentation.

---

## 📊 Analytical Queries

`queries.sql` contains key financial analytics queries:

1. Top 10 Open Interest changes across exchanges  
2. 7-day rolling volatility (Window Functions)  
3. Cross-exchange comparison (MCX vs NSE)  
4. Option chain aggregation  
5. Maximum traded volume in last 30 days  
6. Open interest ranking  
7. Average traded value per symbol per day  

> Sample outputs (LIMIT 5–10 rows) included in `query_outputs/` directory.

---

## 🔄 Data Loading (ETL Pipeline)

Data ingestion implemented using:

- Python  
- Pandas  
- SQLAlchemy  
- PostgreSQL  

The ETL process:

- Reads Kaggle CSV files  
- Connects to PostgreSQL database  
- Loads structured data into `fo_data` table  
- Demonstrates a practical derivatives data ingestion workflow  

**Script:** `load_data.py`

---

## 🗂 File Structure

```
Futures-and-Options-Multi-Exchange-Database/
│
├── ERD.png                     # Entity-Relationship Diagram
├── README.md                   # Project documentation
├── Reasoning Document.pdf      # Design rationale and decisions
├── schema.sql                  # Table creation scripts
├── indexes.sql                 # Index definitions
├── queries.sql                 # Analytical queries
├── load_data.py                # Python ETL script (CSV → PostgreSQL)
└── query_outputs/              # Sample query outputs

```

---

## 🛠 Project Tech Stack

- **Database:** PostgreSQL 15  
- **SQL:** Window Functions, Aggregations, Indexing  
- **Python:** pandas, SQLAlchemy  
- **Tools:** pgAdmin, Git, GitHub  

---

## 🎯 Project Summary

This repository demonstrates:

- Relational database design and normalization  
- Indexed query optimization  
- Time-series financial analytics  
- Multi-exchange derivatives modeling  
- Scalable architecture for high-volume datasets  
- Practical ETL pipeline (CSV → PostgreSQL ingestion)  
- Performance-aware database engineering  

---






