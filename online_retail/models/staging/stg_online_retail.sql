SELECT 
    "InvoiceNo" AS order_id,
    "CustomerID" AS customer_id,
    "StockCode" AS stock_code,
    "Description" AS description,
    "Quantity"::INT AS quantity,
    "UnitPrice"::NUMERIC AS unit_price,
    "InvoiceDate" AS invoice_date,
    "Country" AS country
FROM 
    {{ source('public', 'raw_online_retail') }}
WHERE
    "CustomerID" is not null
ORDER BY 
    "InvoiceNo"