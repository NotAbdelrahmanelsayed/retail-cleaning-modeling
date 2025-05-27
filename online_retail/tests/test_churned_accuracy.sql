SELECT 
    *
FROM 
    {{ ref("fact_customer_behaviour") }}
WHERE 
    recency_day < 90 AND churned = 1