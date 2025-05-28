{{ config(materialized='table') }}

SELECT 
    MAX(invoice_date) AS snapshot_date

FROM 
    {{ ref('int_sales_analysis') }}    

WHERE
    invoice_date IS NOT NULL
