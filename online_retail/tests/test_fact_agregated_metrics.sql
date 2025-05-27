SELECT 
    *
FROM 
    {{ ref("fact_customer_behaviour") }}
WHERE 
    average_order_value < 0 OR total_spent < 0 