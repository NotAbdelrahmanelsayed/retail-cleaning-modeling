WITH base AS (
    SELECT 
        order_id, 
        customer_id,
        invoice_date,
        quantity * unit_price AS line_total
    FROM 
        {{ ref('stg_online_retail') }}
),

invoice_totals AS (
    SELECT
        order_id,
        customer_id,
        MIN(invoice_date) AS invoice_date,
        SUM(line_total) AS total_invoice
    FROM
        base
    GROUP BY 
        customer_id, order_id
),

customer_sessions AS (
    SELECT 
        customer_id,
        MIN(invoice_date) AS first_order_date,
        MAX(invoice_date) AS last_order_date
    FROM 
        invoice_totals
    GROUP BY 
        customer_id
)

SELECT 
    it.order_id,
    it.customer_id,
    it.total_invoice,
    it.invoice_date,
    DATE_TRUNC('month', it.invoice_date) AS invoice_month,
    cs.first_order_date AS first_order,
    cs.last_order_date AS last_order
FROM 
    invoice_totals it
LEFT JOIN 
    customer_sessions cs
    ON it.customer_id = cs.customer_id
WHERE 
    it.total_invoice > 0 