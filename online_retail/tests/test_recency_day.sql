SELECT 
    *
FROM 
    {{ ref("fact_customer_behaviour") }}
WHERE 
    recency_day < 0