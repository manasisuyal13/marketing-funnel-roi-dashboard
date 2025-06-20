# clean_data.py

import pandas as pd
import os

def clean_ppc_data(input_file, output_file):
    df = pd.read_csv(input_file)
    df.columns = df.columns.str.strip().str.lower().str.replace(" ", "_")
    df.dropna(how='all', inplace=True)
    df.fillna(0, inplace=True)

    if 'date' in df.columns:
        df['date'] = pd.to_datetime(df['date'], errors='coerce')

    # Create unified columns
    df.rename(columns={
        'campaign_id': 'campaign',
        'platform': 'channel',
        'spend': 'cost'
    }, inplace=True)

    df['leads'] = df.get('clicks', 0)  # Assume leads same as clicks if not present
    df['revenue'] = df.get('revenue', 0)

    output_df = df[['campaign', 'channel', 'impressions', 'clicks', 'leads', 'conversions', 'cost', 'revenue']]
    output_df.to_csv(output_file, index=False)
    print(f"✅ PPC cleaned: {output_file}")


def clean_marketing_data(input_file, output_file):
    df = pd.read_csv(input_file)
    df.columns = df.columns.str.strip().str.lower().str.replace(" ", "_")
    df.dropna(how='all', inplace=True)
    df.fillna(0, inplace=True)

    if 'date' in df.columns:
        df['date'] = pd.to_datetime(df['date'], errors='coerce')

    # Create unified columns
    df.rename(columns={
        'company': 'campaign',
        'channel_used': 'channel',
        'acquisition_cost': 'cost',
        'roi': 'revenue'
    }, inplace=True)

    df['leads'] = df.get('clicks', 0)
    df['conversions'] = (df['conversion_rate'] * df['leads']).round(0)
    df['revenue'] = df.get('revenue', 0)

    output_df = df[['campaign', 'channel', 'impressions', 'clicks', 'leads', 'conversions', 'cost', 'revenue']]
    output_df.to_csv(output_file, index=False)
    print(f"✅ Marketing cleaned: {output_file}")


if __name__ == "__main__":
    base_dir = r"D:\College\MAIN\Data Analyst\Projects\Marketing Funnel Analytics\Data"

    # File 1: PPC campaign
    ppc_input = os.path.join(base_dir, "ppc_campaign_performance_data.csv")
    ppc_output = os.path.join(base_dir, "ppc_cleaned.csv")
    clean_ppc_data(ppc_input, ppc_output)

    # File 2: Marketing campaign
    marketing_input = os.path.join(base_dir, "marketing_campaign_dataset.csv")
    marketing_output = os.path.join(base_dir, "marketing_cleaned.csv")
    clean_marketing_data(marketing_input, marketing_output)
