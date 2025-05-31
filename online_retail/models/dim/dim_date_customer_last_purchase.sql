{{ config(materialized='table') }}

SELECT 
    customer_id,
    MAX(invoice_date) AS last_order_date
FROM 
    {{ ref('int_sales_analysis') }}
GROUP BY 
    customer_id