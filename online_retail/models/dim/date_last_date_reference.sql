
{{ config(materialized='table')}}

SELECT 
    MAX(invoice_year_month) AS snapshot_date
FROM 
    {{ ref('int_sales_analysis') }}    
