-- Use the Northwind database
USE northwind.db;

--- 1. Find the previous order for each customer ---

WITH previous_orders AS (
  SELECT 
      customer_id,
      order_id,
      order_date,
      LAG(order_id) OVER (
          PARTITION BY customer_id ORDER BY order_date
      ) AS previous_order_id
  FROM orders
)
SELECT 
    customer_id,
    order_id,
    order_date,
    previous_order_id
FROM previous_orders;

--- 2. Find the first order for each customer ---

WITH first_order AS (
  SELECT 
      customer_id,
      order_id,
      order_date, 
      FIRST_VALUE(order_id) OVER (
          PARTITION BY customer_id ORDER BY order_date
      ) AS first_order_id
  FROM orders
)
SELECT 
    customer_id,
    order_id,
    order_date,
    first_order_id
FROM first_order;

--- 3. Find the top 3 most expensive products in each category ---

WITH costes_product AS (
  SELECT 
      c.category_id,
      c.category_name,
      p.product_id,
      p.product_name,
      p.unit_price,
      RANK() OVER (
          PARTITION BY c.category_id ORDER BY p.unit_price DESC
      ) AS product_rank
  FROM products p
  JOIN categories c 
      ON p.category_id = c.category_id
)
SELECT 
    category_id,
    category_name,
    product_id,
    product_name,
    unit_price,
    product_rank
FROM costes_product
WHERE product_rank <= 3;

--- 4. Calculate the time interval between orders for each customer ---

WITH order_with_lag AS (
  SELECT 
      customer_id,
      order_id,
      order_date,
      LAG(order_date) OVER (
          PARTITION BY customer_id ORDER BY order_id
      ) AS previous_order_date
  FROM orders
)
SELECT 
    customer_id,
    order_id,
    order_date,
    previous_order_date,
    JULIANDAY(order_date) - JULIANDAY(previous_order_date) AS diff_days
FROM order_with_lag;

--- 5. Calculate the average interval between orders for customers by region ---

WITH order_with_lag AS (
  SELECT 
      o.customer_id,
      order_id,
      order_date,
      c.region,
      LAG(order_date) OVER (
          PARTITION BY o.customer_id ORDER BY order_id
      ) AS previous_order_date
  FROM orders o
  JOIN customers c
      ON o.customer_id = c.customer_id
)
SELECT 
    region,
    ROUND(AVG(JULIANDAY(order_date) - JULIANDAY(previous_order_date)), 2) AS avg_diff_days
FROM order_with_lag
GROUP BY region
ORDER BY avg_diff_days ASC;

--- 6. Find the top 3 employees by total number of processed orders ---

WITH employees_orders AS (
  SELECT 
      e.employee_id,
      e.first_name, 
      e.last_name,
      COUNT(o.order_id) AS total_orders
  FROM orders o
  JOIN employees e 
      ON o.employee_id = e.employee_id
  GROUP BY e.employee_id,
      e.first_name, 
      e.last_name
),
rank_employees AS (
  SELECT 
      employee_id,
      first_name, 
      last_name,
      total_orders,
      RANK() OVER (
          ORDER BY total_orders DESC
      ) AS employee_rank
  FROM employees_orders
)
SELECT 
    employee_id,
    first_name, 
    last_name,
    total_orders,
    employee_rank
FROM rank_employees
WHERE employee_rank <= 3;

--- 7. Find the top 3 employees by processed orders in each region ---

WITH employees_orders AS (
  SELECT 
      e.employee_id,
      e.first_name, 
      e.last_name,
      e.region,
      COUNT(o.order_id) AS total_orders
  FROM orders o
  JOIN employees e 
      ON o.employee_id = e.employee_id
  GROUP BY e.employee_id,
      e.first_name, 
      e.last_name
),
rank_employees AS (
  SELECT 
      employee_id,
      first_name, 
      last_name,
      region,
      total_orders,
      RANK() OVER (
          PARTITION BY region
          ORDER BY total_orders DESC
      ) AS employee_rank
  FROM employees_orders
)
SELECT 
    employee_id,
    first_name, 
    last_name,
    total_orders,
    region,
    employee_rank
FROM rank_employees
WHERE employee_rank <= 3;
