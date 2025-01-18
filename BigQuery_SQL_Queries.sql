-- BigQuery SQL Queries for Sessions Table Analysis

--- 1. Count the total number of sessions ---

SELECT 
    COUNT(visitNumber) AS Total_sessions
FROM 
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`;

--- 2. Count sessions for a specific date on July 31, 2017 ---

SELECT 
    COUNT(visitNumber) AS sessions_31july2017
FROM 
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE 
    _TABLE_SUFFIX = '20170731';

--- 3. Count sessions for each device type (desktop, mobile, tablet) ---

SELECT 
    device.deviceCategory,
    COUNT(visitNumber) AS total_sessions_by_devices
FROM 
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
GROUP BY 
    device.deviceCategory
ORDER BY 
    total_sessions_by_devices DESC;

--- 4. Find the top 5 traffic sources ---

SELECT 
    trafficSource.source,
    COUNT(visitNumber) AS total_sessions
FROM 
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
GROUP BY 
    trafficSource.source
ORDER BY 
    total_sessions DESC
LIMIT 5;

--- 5. Find 10 - the most visited pages ---

SELECT 
    hits.page.pagePath AS page_path,
    COUNT(*) AS pageviews
FROM 
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
    UNNEST(hits) AS hits
WHERE 
    hits.type = 'PAGE'
GROUP BY 
    page_path
ORDER BY 
    pageviews DESC
LIMIT 10;

--- 6. Calculate the average session duration ---

SELECT 
    AVG(totals.timeOnSite) AS avg_time_on_site
FROM 
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`;

--- 7. Find the top 5 countries by session count ---

SELECT 
    geoNetwork.country,
    COUNT(visitNumber) AS total_sessions
FROM 
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
GROUP BY 
    geoNetwork.country
ORDER BY 
    total_sessions DESC
LIMIT 5;

--- 8. Transactions and revenue analysis ---

-- Query to find the total number of transactions and total revenue.
SELECT 
    COUNT(totals.transactions) AS total_transactions,
    SUM(totals.transactionRevenue) AS total_incomes
FROM 
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE 
    totals.transactions IS NOT NULL 
    AND totals.transactionRevenue IS NOT NULL;
