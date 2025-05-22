SELECT 
    "CustomerID" AS customer_id,
    "InvoiceNo" AS invoice_no,
    "StockCode" AS stock_code,
    "Description" AS description,
    "Quantity" AS quantity,
    "UnitPrice" AS unit_price,
    "InvoiceDate" AS date,
    "Country" AS country
FROM 
    {{ source('public', 'raw_online_retail') }}