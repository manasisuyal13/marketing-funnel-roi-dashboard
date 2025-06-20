# 📊 Marketing Funnel & ROI Analytics Dashboard

This project helps you understand how well different marketing campaigns are performing — from how many people saw the ads to how many actually converted into customers.

It walks you through the complete journey:
✅ Start with raw campaign data (CSV)  
✅ Clean and analyze it using Python  
✅ Explore insights with SQL  
✅ Visualize everything in an interactive Power BI dashboard

You’ll track key metrics like:
- Click-through rates (CTR)
- Conversions
- Return on investment (ROI)
- Cost per acquisition (CPA)
... and much more!

### 🔧 What tools are used?
- **Python** for cleaning and calculating important metrics  
- **SQLite (SQL)** for running smart queries on the data  
- **Power BI** for building a dashboard anyone can understand

### 💡 Who is this project for?
- Anyone learning data analysis or business intelligence  
- Students or job seekers building a portfolio  
- Analysts who want to practice with real marketing data  
- Anyone curious about how companies track their ads

By the end, you’ll have a real-world dashboard and a clean codebase that shows your skills with Python, SQL, and Power BI — all in one place!


---

## 🎯 Project Goal

To build a scalable, interactive analytics pipeline that:

- Cleans raw marketing and PPC data
- Calculates critical performance metrics using Python
- Stores and analyzes relational data in SQL/SQLite
- Exports query insights to CSV
- Visualizes trends and KPIs using Power BI

---

## 📁 Folder Structure Breakdown

```
Marketing Funnel Analytics/
├── Data/
│   ├── ppc_campaign_performance_data.csv          # Raw PPC data from ads
│   ├── marketing_campaign_dataset.csv             # Raw marketing data from campaigns
│   ├── ppc_cleaned.csv                            # Cleaned PPC data (from Step 1)
│   ├── marketing_cleaned.csv                      # Cleaned marketing data (from Step 1)
│   ├── metrics_report.csv                         # Funnel-wide KPIs (CTR, CPL, ROI etc.)
│   ├── campaign_level_metrics.csv                 # Each campaign's individual metrics
│   ├── campaigns.db                               # SQLite database with mock + real data
│
├── Scripts/
│   ├── clean_data.py                              # Step 1: Clean and standardize raw CSVs
│   ├── generate_metrics.py                        # Step 2: Generate overall & campaign metrics
│   ├── database_loader.py                         # Step 3: Load sample campaign structure into DB
│   ├── load_csv_to_db.py                          # Step 4: Load real cleaned campaign data into DB
│
├── SQL/
│   ├── funnel_metrics.sql                         # 30 advanced SQL queries
│
├── PowerBI/
│   ├── Marketing_Dashboard.pbix                   # Power BI interactive dashboard
```

---

## 🛠️ Technologies Used

| Category         | Tools & Languages                            |
|------------------|-----------------------------------------------|
| 🐍 Programming    | Python 3.x, pandas, matplotlib, seaborn       |
| 🧠 Querying       | SQL (30 custom queries), SQLite database       |
| 📊 Visualization | Power BI Desktop                              |
| 🗂 DB Management  | SQLite + DB Browser for SQLite (GUI)          |
| 💻 IDE/Tools     | VS Code / Jupyter / Terminal                  |

---

## ✅ Functional Modules (with Explanation)

| Script/File             | Role / Explanation |
|-------------------------|--------------------|
| `clean_data.py`         | Cleans raw PPC + marketing CSVs into structured, lowercase, filled data |
| `generate_metrics.py`   | Computes overall metrics like CTR, ROI, CPL, CPA, Conversion Rate |
| `database_loader.py`    | Creates sample SQL tables (`Campaigns`, `Leads`, `Conversions`) with sample data |
| `load_csv_to_db.py`     | Loads real-world cleaned campaign data into `campaigns.db` as SQL tables |
| `funnel_metrics.sql`    | Contains full SQL logic for advanced insights on performance |

---

## 🔧 Installation & Environment Setup

### 🐍 Install Python & Required Packages

Make sure Python 3.10+ is installed.

Then install dependencies:

```bash
pip install pandas matplotlib seaborn plotly
```

---

### 🧠 Install DB Browser for SQLite (Optional but Useful)

To view or inspect `campaigns.db` visually:

👉 https://sqlitebrowser.org/dl/  
Choose: **"Standard installer for 64-bit Windows"**

---

### 📈 Install Power BI Desktop

Free download (Windows only):  
👉 https://powerbi.microsoft.com/en-us/desktop/

---

## 🚀 Execution: How to Run This Project (Step-by-Step)

Navigate to the `Scripts/` folder and run each script below **in order**.

---

### ✅ STEP 1: Clean Raw Campaign Data

```bash
python clean_data.py
```

🔹 **What this does:**
- Reads two raw data files:
  - `ppc_campaign_performance_data.csv`
  - `marketing_campaign_dataset.csv`
- Cleans both datasets by:
  - Converting column names to lowercase and underscore-separated
  - Removing completely empty rows
  - Filling missing values with `0`
  - Parsing the `date` column to standard `datetime` format (if available)
  - Renaming columns to create consistency between datasets
  - Adding missing derived fields like `leads`, `conversions`, or `revenue` where necessary
- Outputs two cleaned files:
  - `ppc_cleaned.csv`
  - `marketing_cleaned.csv`

📁 **Output Location:**  
Cleaned CSVs are saved inside the `Data/` folder.

🎯 **Why it’s important:**
Raw marketing data usually comes with inconsistent column names, null values, and different schemas across departments. This step standardizes the structure so that both datasets can:
- Be analyzed uniformly
- Be joined or merged later
- Work seamlessly with SQL and Power BI

💡 **Tip:** You can open the cleaned files in Excel or VS Code to preview them before analysis.

---


### ✅ STEP 2: Generate Funnel & ROI Metrics

```bash
python generate_metrics.py
```

🔹 **What this does:**
- Reads the cleaned PPC and marketing campaign CSVs (`ppc_cleaned.csv` and/or `marketing_cleaned.csv`)
- Calculates overall performance metrics across all campaigns such as:
  - **CTR** (Click-Through Rate)
  - **CPL** (Cost Per Lead)
  - **CPA** (Cost Per Acquisition)
  - **Conversion Rate** (Clicks → Leads → Conversions)
  - **ROI %** (Return on Investment)
- Computes totals for:
  - Impressions, Clicks, Leads, Conversions
  - Cost and Revenue

- Also generates **campaign-level metrics**:
  - Per-campaign CTR, ROI, CPA, Lead Rate, and Conversion Rate

📁 **Output Files (saved in `/Data/`):**
- `metrics_report.csv` → Overall funnel performance summary
- `campaign_level_metrics.csv` → Individual performance per campaign

🎯 **Why it’s important:**
This step bridges **raw campaign activity** with **business-level KPIs**. It’s essential for understanding how well each campaign performs financially and operationally — before you visualize anything in Power BI.

✅ You can later import both of these CSVs into Power BI to:
- Create summary dashboards
- Compare campaigns visually
- Drill into cost-efficiency and ROI trends

💡 **Pro Tip:** The output CSVs here are “ready-to-visualize” — no further cleaning required.

---


### ✅ STEP 3: Create SQL Tables + Insert Sample Data

```bash
python database_loader.py
```

🔹 **What this does:**
- Reads the SQL script: `SQL/funnel_metrics.sql`
- Creates a new SQLite database file: `campaigns.db` (in the `Data/` folder)
- Executes all commands inside the SQL file:
  - Creates 3 tables:
    - `Campaigns` → contains campaign metadata like name, platform, budget, duration
    - `Leads` → represents leads acquired from each campaign
    - `Conversions` → stores revenue, product, and date of conversions
  - Inserts **mock/sample data** into each table

✅ This database is now ready for:
- Running SQL queries
- Exporting insights (in Step 5)
- Optional Power BI DB connection

🎯 **Why it's important:**
Even if your raw campaign data is from CSVs, this mock SQL database simulates how marketing data would be stored in a real-world backend. You’ll use it to:
- Practice JOINs, filters, aggregations
- Write complex SQL logic
- Export marketing performance insights (revenue, conversions, ROI, etc.)

📁 **Output:**
A new file: `Data/campaigns.db`

📘 **Optional Tip:**
You can open `campaigns.db` using **DB Browser for SQLite** to inspect tables, view relationships, or run ad-hoc queries manually.

---


### ✅ STEP 4: Load Cleaned Data into Database

```bash
python load_csv_to_db.py
```

🔹 **What this does:**
- Reads the cleaned data files:
  - `marketing_cleaned.csv`
  - `ppc_cleaned.csv`
- Connects to the existing SQLite database file `campaigns.db`
- Creates two new SQL tables:
  - `marketing_campaign` → contains cleaned marketing campaign data
  - `ppc_campaign` → contains cleaned PPC campaign data
- Loads the data from each CSV into its respective table using `to_sql()` with `replace` mode

📁 **Output Location:**  
The new tables are added to the existing `Data/campaigns.db` file.

🎯 **Why it’s important:**
This step lets you store your **real-world cleaned data** alongside the **mock SQL tables** created earlier (`Campaigns`, `Leads`, `Conversions`). This makes `campaigns.db` your **single source of truth**, allowing:
- Advanced SQL analysis
- Consolidated querying
- Optional connection to Power BI via database

💡 **Tip:** You can open `campaigns.db` in **DB Browser for SQLite** to verify that the `marketing_campaign` and `ppc_campaign` tables were loaded correctly.

---


### ✅ STEP 5: Run SQL Insights & Preview Outputs

📁 Open and run:
```bash
python Scripts/database_loader.py
```

🔹 **What this does:**
- Connects to the `campaigns.db` SQLite database
- Executes all SQL table creation and 30 analytical queries from:
  ```plaintext
  SQL/funnel_metrics.sql
  ```
- Displays a few sample query results directly in your terminal:
  - Total leads per campaign
  - ROI per campaign
  - Revenue by channel (you can customize more!)

🎯 **Why it’s important:**
These queries simulate the types of reports and performance dashboards a marketing analyst would generate. It demonstrates your ability to use SQL effectively within a Python project.

💡 **Optional:** You can edit the bottom of `database_loader.py` to preview any of the 30 SQL queries in your console — no need to save CSVs.

---

## 🧠 What Do the 30 SQL Queries Cover?

These 30 SQL queries extract **deep marketing insights** from the `campaigns.db` database. Here's a quick breakdown:

| Query Group                   | What It Shows                                             |
|------------------------------|------------------------------------------------------------|
| 🔢 Campaign Performance       | Total leads, conversions, ROI, and conversion rates        |
| 📈 Revenue & ROI              | Revenue per platform, product, and channel                 |
| 📊 Trend Analysis             | Month-wise revenue, conversion counts, ROI trends          |
| 📍 Lead Insights              | Daily lead flow, time to convert, cost per lead            |
| 💸 Efficiency & Spend         | High-spend low-ROI campaigns, CPA, CPL, CPC                |
| 🔍 Quality Checks             | Duplicate leads, leads without conversions                 |
| 🥇 Rankings & Top Performers  | Top 3 campaigns by ROI, best-performing products/platforms |
| 📉 Drop-off & Delays          | Lead-to-conversion time, campaign launch delays            |
| 📊 Distribution               | Lead & revenue distribution by platform and region         |

🎯 These queries replicate **real-world business intelligence dashboards** — they are powerful tools for any data analyst portfolio.

---

### ✅ STEP 6: Build & Explore the Power BI Dashboard

📂 Open the Power BI file:
```plaintext
PowerBI/Marketing_Dashboard.pbix
```

🔹 **What this does:**
- Opens your interactive dashboard in Power BI
- Visualizes all the cleaned and analyzed data from `/Data/`
- Displays rich visualizations such as:
  - ✅ Funnel chart (Impressions → Clicks → Leads → Conversions)
  - ✅ Pie chart (Revenue by Channel)
  - ✅ Bar chart (ROI or Conversions per Campaign)
  - ✅ Line chart (Monthly Revenue Trends)
  - ✅ Cards (ROI %, CPA, CTR, CPL)
  - ✅ Slicers (Channels, Platforms, Dates)

📁 **Recommended data sources to import:**
- `metrics_report.csv` → overall KPIs
- `campaign_level_metrics.csv` → per-campaign performance
- `ppc_cleaned.csv` and `marketing_cleaned.csv` → raw visual analysis
- Optionally, you can also import SQL query results if you exported any manually

🎯 **Why it’s important:**
This is where your analysis turns into **actionable storytelling**. Executives and hiring managers care about insights, and Power BI helps you:
- Communicate findings clearly
- Make performance trends easy to digest
- Demonstrate business thinking through visuals

💡 **Tips for Power BI:**
- Use filters and slicers for dynamic interactivity
- Keep charts uncluttered and focused
- Group visuals by KPI categories for a cleaner layout

✅ Final result: A professional-grade dashboard showing marketing funnel, ROI, and performance metrics from raw data to insights.

---


## 🎯 Project Highlights

✅ **End-to-End Analytics Pipeline**: From raw CSV files to cleaned datasets, SQL analytics, and final Power BI dashboards — all steps are covered.

✅ **Multi-Tech Stack Integration**: Seamlessly combines Python (for data processing), SQL (for querying), and Power BI (for visual storytelling).

✅ **Real + Simulated Data Handling**: Leverages both synthetic (mock) and real marketing datasets to demonstrate flexibility and business realism.

✅ **Expandable Architecture**: Easily extendable to web apps using tools like **Streamlit** or **Flask** for interactive dashboards or user uploads.

✅ **Portfolio-Ready Project**: Clean file structure, modular code, and visually rich dashboards — ideal for showcasing in interviews or on GitHub/LinkedIn.

✅ **SQL & Metric Depth**: Includes 30+ business-relevant queries for ROI, CTR, conversion trends, and lead performance — replicating real-world BI use cases.

✅ **Business & Technical Value**: Bridges the gap between data science and marketing insights, demonstrating both technical skill and business acumen.


---

## 💼 Resume/Portfolio Use

- 🟢 Show this project on GitHub as `marketing-funnel-roi-dashboard`
- 📊 Present Power BI insights in interviews
- 💬 Talk through your SQL queries, Python logic, and dashboard design

---

## 🙋 FAQs

**Q1: Is Power BI database (DB) connection necessary?**  
No. Power BI connects to **CSV files** in this project. While connecting to `campaigns.db` is possible, it's optional and not required for any dashboards here.

**Q2: What is `campaigns.db` used for?**  
It stores both mock and cleaned campaign data in a relational format. This makes it easy to explore insights using SQL queries and tools like **DB Browser for SQLite**.

**Q3: Can I skip some files if I only want the dashboard?**  
Yes! You can skip:
- `database_loader.py` (mock table creation)
- `load_csv_to_db.py` (CSV-to-DB step)  
If you just want to use the cleaned CSVs in Power BI and skip SQL entirely.

**Q4: What's the difference between `metrics_report.csv` and `campaign_level_metrics.csv`?**  
- `metrics_report.csv`: Overall marketing KPIs (CTR, ROI, CPA, etc.)  
- `campaign_level_metrics.csv`: Same KPIs but split by individual campaigns

**Q5: What’s the purpose of the SQL queries in `funnel_metrics.sql`?**  
These 30 queries help explore marketing performance in depth:
- ROI by campaign
- Conversion delays
- Revenue trends by month
- Platform and product performance  
They simulate real BI dashboards and demonstrate your SQL fluency.

**Q6: Can I use this project in interviews or GitHub?**  
Absolutely. This project is structured for:
- **Interviews**: Great to discuss end-to-end logic and dashboard design  
- **GitHub**: Clean codebase with full documentation and visuals  
- **Portfolio**: Highlights your skills in Python, SQL, and Power BI together

**Q7: Can I extend this project with new data later?**  
Yes. Just add new CSVs to the `/Data/` folder, rerun `clean_data.py`, and Power BI will reflect updated results after refresh.

**Q8: Can I turn this into a web app?**  
Yes! Use **Streamlit** or **Flask** to build a web interface where users can upload campaign data and view metrics and charts instantly.

**Q9: Will Power BI auto-refresh if CSVs are updated?**  
Yes. If you use **Transform Data → Refresh Preview**, Power BI can reflect new changes in the source CSVs automatically (especially with relative paths).

**Q10: How long does this project take to build?**  
On average:
- Python setup + cleaning: 1–2 hours  
- SQL logic + testing: 1.5–2.5 hours  
- Power BI visuals: 2–3 hours  
- README + testing: ~1 hour  
🕒 **Total Time: ~6–8 hours** for a complete portfolio-ready analytics project

---

## 🙌 Project Author

**👩‍💻 Manasi Suyal**  
📅 June 2025  
🔗 Technologies: Python, SQLite, SQL, Power BI

> *"From raw campaign data to dashboard-ready insights — this project captures the full power of analytics."*

---
