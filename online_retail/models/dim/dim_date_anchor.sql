{{ config(materialized='table') }}

SELECT 
    MAX(invoice_date) AS snapshot_date
WHERE
    invoice_date IS NOT NULL
FROM 
    {{ ref('int_sales_analysis') }}    
