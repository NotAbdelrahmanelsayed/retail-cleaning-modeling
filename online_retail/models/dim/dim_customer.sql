SELECT 
    customer_id, 
    country,
    order_id
FROM 
    {{ ref('stg_online_retail' )}}

