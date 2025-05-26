SELECT 
    *
FROM
    {{ ref('int_sales_analysis') }}
WHERE
    total_invoice < 0 
