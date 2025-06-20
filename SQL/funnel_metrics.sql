-- DROP OLD TABLES IF EXIST
DROP TABLE IF EXISTS Conversions;
DROP TABLE IF EXISTS Leads;
DROP TABLE IF EXISTS Campaigns;

-- CREATE Campaigns TABLE
CREATE TABLE Campaigns (
    campaign_id INTEGER PRIMARY KEY,
    campaign_name TEXT NOT NULL,
    platform TEXT,
    start_date TEXT,
    end_date TEXT,
    budget REAL,
    target_audience TEXT,
    objective TEXT,
    status TEXT
);

-- CREATE Leads TABLE
CREATE TABLE Leads (
    lead_id INTEGER PRIMARY KEY,
    campaign_id INTEGER,
    lead_source TEXT,
    lead_date TEXT,
    cost_per_lead REAL,
    FOREIGN KEY (campaign_id) REFERENCES Campaigns(campaign_id)
);

-- CREATE Conversions TABLE
CREATE TABLE Conversions (
    conversion_id INTEGER PRIMARY KEY,
    lead_id INTEGER,
    conversion_date TEXT,
    revenue_generated REAL,
    channel TEXT,
    product_sold TEXT,
    FOREIGN KEY (lead_id) REFERENCES Leads(lead_id)
);

-- INSERT Campaigns
INSERT INTO Campaigns (campaign_id, campaign_name, platform, start_date, end_date, budget, target_audience, objective, status) VALUES
(1, 'Diwali Campaign', 'Facebook', '2023-10-10', '2023-10-30', 50000, 'Young Adults', 'Increase Sales', 'Completed'),
(2, 'New Year Blast', 'Instagram', '2023-12-15', '2024-01-05', 30000, 'Millennials', 'Brand Awareness', 'Completed'),
(3, 'Summer Sale', 'Google Ads', '2024-05-01', '2024-05-31', 40000, 'General Audience', 'Product Launch', 'Running'),
(4, 'Monsoon Offers', 'YouTube', '2024-06-01', '2024-06-30', 25000, 'Families', 'Lead Generation', 'Planned');

-- INSERT Leads
INSERT INTO Leads (lead_id, campaign_id, lead_source, lead_date, cost_per_lead) VALUES
(1, 1, 'Facebook', '2023-10-12', 100),
(2, 1, 'Facebook', '2023-10-15', 120),
(3, 2, 'Instagram', '2023-12-20', 90),
(4, 2, 'Instagram', '2023-12-25', 95),
(5, 3, 'Google', '2024-05-03', 110),
(6, 3, 'Google', '2024-05-10', 105),
(7, 4, 'YouTube', '2024-06-05', 95),
(8, 4, 'YouTube', '2024-06-10', 92);

-- INSERT Conversions
INSERT INTO Conversions (conversion_id, lead_id, conversion_date, revenue_generated, channel, product_sold) VALUES
(1, 1, '2023-10-20', 1000, 'Facebook', 'Smartphone'),
(2, 2, '2023-10-25', 1500, 'Facebook', 'Headphones'),
(3, 3, '2023-12-27', 1200, 'Instagram', 'Smartwatch'),
(4, 5, '2024-05-07', 800, 'Google Ads', 'Tablet'),
(5, 6, '2024-05-11', 1300, 'Google Ads', 'Laptop'),
(6, 7, '2024-06-09', 900, 'YouTube', 'Fitness Band');

-- 🔍 METRIC QUERIES

-- 1. Total Leads per Campaign
SELECT c.campaign_name, COUNT(l.lead_id) AS total_leads
FROM Campaigns c
LEFT JOIN Leads l ON c.campaign_id = l.campaign_id
GROUP BY c.campaign_id;

-- 2. Total Conversions per Campaign
SELECT c.campaign_name, COUNT(cv.conversion_id) AS total_conversions
FROM Campaigns c
LEFT JOIN Leads l ON c.campaign_id = l.campaign_id
LEFT JOIN Conversions cv ON l.lead_id = cv.lead_id
GROUP BY c.campaign_id;

-- 3. Conversion Rate per Campaign
SELECT c.campaign_name,
       ROUND(COUNT(cv.conversion_id) * 1.0 / COUNT(l.lead_id), 2) AS conversion_rate
FROM Campaigns c
LEFT JOIN Leads l ON c.campaign_id = l.campaign_id
LEFT JOIN Conversions cv ON l.lead_id = cv.lead_id
GROUP BY c.campaign_id;

-- 4. ROI per Campaign
SELECT c.campaign_name,
       ROUND(SUM(cv.revenue_generated), 2) AS total_revenue,
       c.budget,
       ROUND(SUM(cv.revenue_generated) - c.budget, 2) AS profit_or_loss,
       ROUND((SUM(cv.revenue_generated) - c.budget) * 100.0 / c.budget, 2) AS ROI_percentage
FROM Campaigns c
LEFT JOIN Leads l ON c.campaign_id = l.campaign_id
LEFT JOIN Conversions cv ON l.lead_id = cv.lead_id
GROUP BY c.campaign_id;

-- 5. Revenue by Channel
SELECT channel, SUM(revenue_generated) AS total_channel_revenue
FROM Conversions
GROUP BY channel;

-- 6. Top Performing Product
SELECT product_sold, SUM(revenue_generated) AS total_sales
FROM Conversions
GROUP BY product_sold
ORDER BY total_sales DESC
LIMIT 1;

-- 7. Cost Per Lead per Campaign
SELECT c.campaign_name,
       ROUND(AVG(l.cost_per_lead), 2) AS avg_cost_per_lead,
       SUM(l.cost_per_lead) AS total_lead_cost
FROM Campaigns c
JOIN Leads l ON c.campaign_id = l.campaign_id
GROUP BY c.campaign_id;

-- 8. Average Revenue per Conversion per Campaign
SELECT c.campaign_name,
       ROUND(AVG(cv.revenue_generated), 2) AS avg_revenue_per_conversion
FROM Campaigns c
JOIN Leads l ON c.campaign_id = l.campaign_id
JOIN Conversions cv ON l.lead_id = cv.lead_id
GROUP BY c.campaign_id;

-- 9. Lead to Conversion Time (in days)
SELECT c.campaign_name,
       l.lead_id,
       l.lead_date,
       cv.conversion_date,
       julianday(cv.conversion_date) - julianday(l.lead_date) AS days_to_convert
FROM Campaigns c
JOIN Leads l ON c.campaign_id = l.campaign_id
JOIN Conversions cv ON l.lead_id = cv.lead_id;

-- 10. Active vs Completed Campaigns Count
SELECT status, COUNT(*) AS count
FROM Campaigns
GROUP BY status;

-- 11. Total Revenue by Platform
SELECT platform, SUM(cv.revenue_generated) AS total_platform_revenue
FROM Campaigns c
JOIN Leads l ON c.campaign_id = l.campaign_id
JOIN Conversions cv ON l.lead_id = cv.lead_id
GROUP BY platform;

-- 12. Month-wise Revenue Trend
SELECT strftime('%Y-%m', cv.conversion_date) AS month,
       SUM(cv.revenue_generated) AS monthly_revenue
FROM Conversions cv
GROUP BY month
ORDER BY month;

-- 13. Top 3 Campaigns by ROI
SELECT c.campaign_name,
       ROUND(SUM(cv.revenue_generated) - c.budget, 2) AS profit,
       ROUND((SUM(cv.revenue_generated) - c.budget) * 100.0 / c.budget, 2) AS ROI_percentage
FROM Campaigns c
LEFT JOIN Leads l ON c.campaign_id = l.campaign_id
LEFT JOIN Conversions cv ON l.lead_id = cv.lead_id
GROUP BY c.campaign_id
ORDER BY ROI_percentage DESC
LIMIT 3;

-- 14. Conversion Count per Product
SELECT product_sold, COUNT(*) AS num_conversions
FROM Conversions
GROUP BY product_sold
ORDER BY num_conversions DESC;

-- 15. Leads Without Conversion
SELECT l.lead_id, l.lead_source, c.campaign_name
FROM Leads l
LEFT JOIN Conversions cv ON l.lead_id = cv.lead_id
JOIN Campaigns c ON l.campaign_id = c.campaign_id
WHERE cv.conversion_id IS NULL;

-- 16. Revenue Contribution % per Campaign
WITH total_revenue AS (
    SELECT SUM(cv.revenue_generated) AS total
    FROM Conversions cv
)
SELECT c.campaign_name,
       ROUND(SUM(cv.revenue_generated), 2) AS campaign_revenue,
       ROUND(SUM(cv.revenue_generated) * 100.0 / (SELECT total FROM total_revenue), 2) AS revenue_percent
FROM Campaigns c
JOIN Leads l ON c.campaign_id = l.campaign_id
JOIN Conversions cv ON l.lead_id = cv.lead_id
GROUP BY c.campaign_id
ORDER BY revenue_percent DESC;

-- 17: Daily Lead Flow
SELECT 
    lead_date, 
    COUNT(*) AS leads_per_day
FROM 
    Leads
GROUP BY 
    lead_date
ORDER BY 
    lead_date;

-- 18: Conversion Rate per Platform
SELECT 
    c.platform,
    ROUND(COUNT(cv.conversion_id) * 100.0 / COUNT(DISTINCT l.lead_id), 2) AS platform_conversion_rate
FROM 
    Campaigns c
JOIN 
    Leads l ON c.campaign_id = l.campaign_id
LEFT JOIN 
    Conversions cv ON l.lead_id = cv.lead_id
GROUP BY 
    c.platform;

-- 19: Campaigns with High Spend but Low ROI
SELECT 
    c.campaign_name, 
    c.budget,
    IFNULL(SUM(cv.revenue_generated), 0) AS revenue,
    ROUND((IFNULL(SUM(cv.revenue_generated), 0) - c.budget) * 100.0 / c.budget, 2) AS ROI
FROM 
    Campaigns c
LEFT JOIN 
    Leads l ON c.campaign_id = l.campaign_id
LEFT JOIN 
    Conversions cv ON l.lead_id = cv.lead_id
GROUP BY 
    c.campaign_id
HAVING 
    ROI < 0
ORDER BY 
    ROI ASC;

-- 20: Time Between Campaign Start and First Lead
SELECT 
    c.campaign_name,
    MIN(l.lead_date) AS first_lead_date,
    c.start_date,
    ROUND(julianday(MIN(l.lead_date)) - julianday(c.start_date), 2) AS days_until_first_lead
FROM 
    Campaigns c
JOIN 
    Leads l ON c.campaign_id = l.campaign_id
GROUP BY 
    c.campaign_id;

-- 21: Duplicate Leads Detection
SELECT 
    lead_source, 
    campaign_id, 
    COUNT(*) AS duplicate_count
FROM 
    Leads
GROUP BY 
    lead_source, campaign_id
HAVING 
    duplicate_count > 1;

-- 22: Platform-wise Lead Distribution
SELECT 
    c.platform,
    COUNT(l.lead_id) AS total_leads
FROM 
    Campaigns c
JOIN 
    Leads l ON c.campaign_id = l.campaign_id
GROUP BY 
    c.platform
ORDER BY 
    total_leads DESC;

-- 23: Revenue Generated Per Platform
SELECT 
    c.platform,
    SUM(cv.revenue_generated) AS total_revenue
FROM 
    Campaigns c
JOIN 
    Leads l ON c.campaign_id = l.campaign_id
JOIN 
    Conversions cv ON l.lead_id = cv.lead_id
GROUP BY 
    c.platform
ORDER BY 
    total_revenue DESC;

-- 24: Monthly Conversion Count
SELECT 
    STRFTIME('%Y-%m', cv.conversion_date) AS month,
    COUNT(*) AS conversions
FROM 
    Conversions cv
GROUP BY 
    month
ORDER BY 
    month;

-- 25: Average Revenue per Platform
SELECT 
    c.platform,
    ROUND(AVG(cv.revenue_generated), 2) AS avg_revenue
FROM 
    Campaigns c
JOIN 
    Leads l ON c.campaign_id = l.campaign_id
JOIN 
    Conversions cv ON l.lead_id = cv.lead_id
GROUP BY 
    c.platform;

-- 26: Campaign Duration in Days
SELECT 
    campaign_name,
    start_date,
    end_date,
    JULIANDAY(end_date) - JULIANDAY(start_date) AS campaign_duration_days
FROM 
    Campaigns
ORDER BY 
    campaign_duration_days DESC;

-- 27: Lead Source Effectiveness (Conversion Rate by Source)
SELECT 
    l.lead_source,
    ROUND(COUNT(cv.conversion_id) * 100.0 / COUNT(DISTINCT l.lead_id), 2) AS source_conversion_rate
FROM 
    Leads l
LEFT JOIN 
    Conversions cv ON l.lead_id = cv.lead_id
GROUP BY 
    l.lead_source
ORDER BY 
    source_conversion_rate DESC;

-- 28: Leads without Conversions
SELECT 
    l.lead_id,
    l.lead_source,
    c.campaign_name
FROM 
    Leads l
JOIN 
    Campaigns c ON l.campaign_id = c.campaign_id
LEFT JOIN 
    Conversions cv ON l.lead_id = cv.lead_id
WHERE 
    cv.conversion_id IS NULL;

-- 29: Total Cost, Revenue, and Net Profit
SELECT 
    ROUND(SUM(c.budget), 2) AS total_spent,
    ROUND(SUM(IFNULL(cv.revenue_generated, 0)), 2) AS total_revenue,
    ROUND(SUM(IFNULL(cv.revenue_generated, 0)) - SUM(c.budget), 2) AS net_profit
FROM 
    Campaigns c
LEFT JOIN 
    Leads l ON c.campaign_id = l.campaign_id
LEFT JOIN 
    Conversions cv ON l.lead_id = cv.lead_id;

-- 30: Campaign Performance Ranking by ROI
SELECT 
    c.campaign_name,
    ROUND(SUM(IFNULL(cv.revenue_generated, 0)), 2) AS revenue,
    ROUND((SUM(IFNULL(cv.revenue_generated, 0)) - c.budget) * 100.0 / c.budget, 2) AS ROI,
    RANK() OVER (ORDER BY ((SUM(IFNULL(cv.revenue_generated, 0)) - c.budget) * 100.0 / c.budget) DESC) AS ROI_rank
FROM 
    Campaigns c
LEFT JOIN 
    Leads l ON c.campaign_id = l.campaign_id
LEFT JOIN 
    Conversions cv ON l.lead_id = cv.lead_id
GROUP BY 
    c.campaign_id;
