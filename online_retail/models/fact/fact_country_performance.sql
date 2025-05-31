SELECT
    dc.country,
    COUNT(DISTINCT sa.customer_id) AS num_customers,
    COUNT(sa.order_id) AS num_orders,
    SUM(sa.total_invoice) AS total_revenue
FROM
    {{ ref('int_sales_analysis') }} sa
LEFT JOIN 
    {{ ref('dim_customer') }} dc
USING (customer_id, order_id)
WHERE 
    dc.country <> 'Unspecified'
GROUP BY
    dc.country