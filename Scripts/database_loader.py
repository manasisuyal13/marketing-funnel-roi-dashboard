import sqlite3
import pandas as pd
import os

# Paths
base_dir = r"D:\College\MAIN\Data Analyst\Projects\Marketing Funnel Analytics"
sql_path = os.path.join(base_dir, "SQL", "funnel_metrics.sql")
db_path = os.path.join(base_dir, "Data", "campaigns.db")

# Run SQL script
with sqlite3.connect(db_path) as conn:
    with open(sql_path, 'r') as f:
        sql_script = f.read()
    try:
        conn.executescript(sql_script)
        print("✅ All SQL queries executed successfully.")
    except Exception as e:
        print("❌ Error:", e)

    # 🟡 Optional Preview: Show output from 2–3 queries
    print("\n🔎 Preview: Total Leads per Campaign")
    q1 = """
        SELECT c.campaign_name, COUNT(l.lead_id) AS total_leads
        FROM Campaigns c
        LEFT JOIN Leads l ON c.campaign_id = l.campaign_id
        GROUP BY c.campaign_id;
    """
    df1 = pd.read_sql_query(q1, conn)
    print(df1)

    print("\n🔎 Preview: ROI per Campaign")
    q2 = """
        SELECT c.campaign_name,
               ROUND(SUM(cv.revenue_generated), 2) AS total_revenue,
               c.budget,
               ROUND(SUM(cv.revenue_generated) - c.budget, 2) AS profit_or_loss,
               ROUND((SUM(cv.revenue_generated) - c.budget) * 100.0 / c.budget, 2) AS ROI_percentage
        FROM Campaigns c
        LEFT JOIN Leads l ON c.campaign_id = l.campaign_id
        LEFT JOIN Conversions cv ON l.lead_id = cv.lead_id
        GROUP BY c.campaign_id;
    """
    df2 = pd.read_sql_query(q2, conn)
    print(df2)
