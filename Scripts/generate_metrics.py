# generate_metrics.py

import pandas as pd
import os

def generate_metrics():
    base_dir = r"D:\College\MAIN\Data Analyst\Projects\Marketing Funnel Analytics\Data"
    ppc_file = os.path.join(base_dir, "ppc_cleaned.csv")
    marketing_file = os.path.join(base_dir, "marketing_cleaned.csv")

    try:
        ppc_df = pd.read_csv(ppc_file)
        marketing_df = pd.read_csv(marketing_file)
        print(f"✅ Loaded cleaned PPC ({len(ppc_df)}) and Marketing ({len(marketing_df)}) rows.\n")
    except FileNotFoundError as e:
        print(f"❌ File not found: {e}")
        return

    # Combine both datasets
    df = pd.concat([ppc_df, marketing_df], ignore_index=True)
    df.fillna(0, inplace=True)

    # Ensure numeric columns are numeric
    for col in ['impressions', 'clicks', 'leads', 'conversions', 'cost', 'revenue']:
        df[col] = pd.to_numeric(df[col], errors='coerce').fillna(0)

    # Aggregate totals
    total_impressions = df['impressions'].sum()
    total_clicks = df['clicks'].sum()
    total_leads = df['leads'].sum()
    total_conversions = df['conversions'].sum()
    total_cost = df['cost'].sum()
    total_revenue = df['revenue'].sum()

    # Calculated metrics
    metrics = {
        "Total Impressions": total_impressions,
        "Total Clicks": total_clicks,
        "Total Leads": total_leads,
        "Total Conversions": total_conversions,
        "Total Cost": round(total_cost, 2),
        "Total Revenue": round(total_revenue, 2),
        "Click-Through Rate (CTR)%": round((total_clicks / total_impressions) * 100, 2) if total_impressions else 0,
        "Lead Conversion Rate (Leads/Clicks)%": round((total_leads / total_clicks) * 100, 2) if total_clicks else 0,
        "Final Conversion Rate (Conversions/Leads)%": round((total_conversions / total_leads) * 100, 2) if total_leads else 0,
        "Cost Per Click (CPC)": round(total_cost / total_clicks, 2) if total_clicks else 0,
        "Cost Per Lead (CPL)": round(total_cost / total_leads, 2) if total_leads else 0,
        "Cost Per Acquisition (CPA)": round(total_cost / total_conversions, 2) if total_conversions else 0,
        "Return on Investment (ROI)%": round(((total_revenue - total_cost) / total_cost) * 100, 2) if total_cost else 0,
    }

    print("\n📊 Funnel & ROI Metrics Summary:\n")
    for key, val in metrics.items():
        print(f"{key}: {val}")

    # Save summary to CSV
    summary_df = pd.DataFrame(list(metrics.items()), columns=["Metric", "Value"])
    summary_df.to_csv(os.path.join(base_dir, "metrics_report.csv"), index=False)
    print("\n✅ Overall metrics saved to 'metrics_report.csv'.")

    # Campaign-wise metrics
    df['CTR (%)'] = round((df['clicks'] / df['impressions']) * 100, 2)
    df['Lead Rate (%)'] = round((df['leads'] / df['clicks']) * 100, 2)
    df['Conversion Rate (%)'] = round((df['conversions'] / df['leads']) * 100, 2)
    df['CPA'] = round(df['cost'] / df['conversions'], 2).replace([float('inf'), -float('inf')], 0)
    df['ROI (%)'] = round(((df['revenue'] - df['cost']) / df['cost']) * 100, 2).replace([float('inf'), -float('inf')], 0)

    df.to_csv(os.path.join(base_dir, "campaign_level_metrics.csv"), index=False)
    print("📁 Campaign-level metrics saved to 'campaign_level_metrics.csv'.")

if __name__ == "__main__":
    generate_metrics()
