import pandas as pd
import sqlite3
import os

# 🔹 Paths
base_dir = r"D:\College\MAIN\Data Analyst\Projects\Marketing Funnel Analytics"
data_dir = os.path.join(base_dir, "Data")
db_path = os.path.join(data_dir, "campaigns.db")

# 🔹 Input CSV files
ppc_file = os.path.join(data_dir, "ppc_cleaned.csv")
marketing_file = os.path.join(data_dir, "marketing_cleaned.csv")

# 🔹 Read CSVs into DataFrames
try:
    ppc_df = pd.read_csv(ppc_file)
    marketing_df = pd.read_csv(marketing_file)
    print("✅ Cleaned CSVs loaded successfully.\n")
except FileNotFoundError as e:
    print(f"❌ File not found: {e}")
    exit()

# 🔹 Connect to SQLite DB and insert data
try:
    with sqlite3.connect(db_path) as conn:
        ppc_df.to_sql("ppc_campaign", conn, if_exists="replace", index=False)
        marketing_df.to_sql("marketing_campaign", conn, if_exists="replace", index=False)
        print("✅ Tables 'ppc_campaign' and 'marketing_campaign' inserted into database.")
except Exception as e:
    print(f"❌ Failed to write to database: {e}")
