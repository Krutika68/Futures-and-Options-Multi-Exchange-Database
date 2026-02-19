- Load Kaggle FO Dataset into PostgreSQL


import pandas as pd
from sqlalchemy import create_engine

# 1. Load CSV file (change path if needed)
csv_file_path = "fo_data.csv"
df = pd.read_csv(csv_file_path)

print("CSV Loaded Successfully")
print("Number of rows:", len(df))


# 2. PostgreSQL connection details
# Replace with your own credentials
username = "postgres"
password = "your_password"
host = "localhost"
port = "5432"
database = "fo_db"

# Create connection engine
engine = create_engine(
    f"postgresql://{username}:{password}@{host}:{port}/{database}"
)

print("Connected to PostgreSQL")


# 3. Load data into table
df.to_sql(
    "fo_data",
    engine,
    if_exists="append",   # append to existing table
    index=False
)

print("Data Loaded Successfully into fo_data table")
