{{ config(materialized='table')}}

WITH reference AS (
    SELECT 
        MAX(invoice_year_month) AS max_date
    
)
SELECT 
    customer_id,
    COUNT(*) AS total_orders,
    SUM(total_invoice) AS total_spent
FROM 
    {{ ref('int_sales_analysis') }}
GROUP BY 
    customer_id

