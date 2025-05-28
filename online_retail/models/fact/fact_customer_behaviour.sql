{{ config(materialized='table') }}

WITH aggregated_metrics AS (
    SELECT 
        customer_id,
        COUNT(*) AS total_orders,
        SUM(total_invoice) AS total_spent,
        ROUND(AVG(total_invoice), 3) AS average_order_value
    FROM 
        {{ ref('int_sales_analysis') }}
    GROUP BY 
        customer_id
)

SELECT 
    am.customer_id,
    am.total_orders,
    am.total_spent,
    am.average_order_value,
    DATE_PART('day', ld.snapshot_date - lp.last_order_date) AS recency_day,
    CASE 
        WHEN
            ld.snapshot_date - lp.last_order_date > INTERVAL '90 days' THEN 1
        ELSE 0
    END AS churned

FROM
    aggregated_metrics am 
LEFT JOIN {{ ref('date_customer_last_purchase') }} lp ON am.customer_id = lp.customer_id
CROSS JOIN {{ ref('dim_date_anchor') }} ld -- refer to models/dim/schema.yml