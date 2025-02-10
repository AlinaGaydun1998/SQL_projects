# SQL Projects

This repository contains SQL projects showcasing various analytical techniques and real-world use cases. Below is a summary of the projects included:

| **Project Name**            | **Description**                                                                                                    | **Dataset**                              | **Key Techniques**                            |
|-----------------------------|--------------------------------------------------------------------------------------------------------------------|------------------------------------------|------------------------------------------------|
| **Sql_Healthcare_Analysis** | Analysis of healthcare data focusing on patient demographics, doctor specialties, admissions, and regional trends. Queries include identifying top diagnoses, calculating admission costs, and analyzing gender distribution by province. | [Hospital Dataset](https://www.sql-practice.com/) | Joins, Aggregations, Filters, CASE Statements |
| **Sql_Window_Functions**    | Demonstrates advanced window functions to analyze customer orders, rank employees, calculate time intervals, and more. The project provides insights into customer behaviors and product performance. | [Northwind Dataset](https://www.sql-practice.com/) | Window Functions (RANK, LAG), CTEs, Subqueries |
| **BigQuery_SQL_Queries**    | Analysis of Google Analytics data, focusing on user sessions, traffic sources, popular pages, and session duration. Includes queries for top traffic sources, pageviews, and country-specific behavior analysis. | [Google Analytics Sample](https://cloud.google.com/bigquery/public-data) | BigQuery, Aggregations, Filters, UNNEST       |
| **Pandas+SQL**              | Combines SQL querying with Pandas for advanced data manipulation and visualization.              | Employee Dataset (MySQL)                 | SQL Queries, Pandas Integration, Matplotlib Visualization |
| **SQL_exercises (Joins & Window Functions)**| Practical training on SQL joins and window functions for structured data analysis.               | Employee Dataset (MySQL)                 | SQL Queries, Window Functions, Data Aggregation|

### Each project file contains structured SQL queries and documentation for easy exploration and learning.

### Overview - SQL_exercises (Joins & Window Functions)

This project is a practical training on SQL queries, focusing on the use of JOINs and window functions. The dataset consists of employee records, including salaries, job titles, and hire dates. The goal was to explore data efficiently using advanced SQL techniques.

🔑 **Key Topics Covered**
- JOINs: Practiced different types of joins (INNER, LEFT, RIGHT) to merge employee, salary, and title data.
- Window Functions: Applied functions like RANK(), NTILE(), and ROW_NUMBER() to analyze salary distributions and hiring trends.
- Aggregations: Used AVG(), MIN(), MAX(), and GROUP BY to calculate key metrics.
- Filtering and Sorting: Leveraged WHERE, ORDER BY, and PARTITION BY for structured data retrieval.

📊 **Example Queries**
- Identified the first hired employee for each job title.
- Calculated the average salary per job position.
- Used NTILE() to group employees into salary tiers.

📕 **Learnings & Challenges**
- Ensured data consistency when using window functions.
- Addressed order dependencies in ranking functions.
- Optimized query performance by refining filtering criteria.

