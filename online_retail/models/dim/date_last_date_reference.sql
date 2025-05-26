
{{ config(materialized='table')}}

SELECT 
    customer_id,
    MAX(invoice_year_month) AS max_date
FROM 
    {{ ref('int_sales_analysis') }}    
