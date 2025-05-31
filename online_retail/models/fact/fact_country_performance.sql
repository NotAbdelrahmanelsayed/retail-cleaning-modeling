SELECT
    country,
    COUNT(DISTINCT customer_id) AS num_customers,
    COUNT(order_id) AS num_orders,
    SUM(total_invoice) AS total_revenue
FROM
    {{ ref('int_sales_analysis') }}
WHERE 
    country <> 'Unspecified'
GROUP BY
    country
