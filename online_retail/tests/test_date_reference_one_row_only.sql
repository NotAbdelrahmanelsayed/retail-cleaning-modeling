WITH CTE AS (
    SELECT 
        COUNT(*) AS row_counter
    FROM 
        {{ ref('dim_date_anchor') }})
SELECT 
    *
FROM
    CTE
WHERE 
    row_counter <> 1