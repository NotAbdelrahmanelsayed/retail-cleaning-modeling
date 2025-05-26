WITH base AS (
    SELECT 
        *
    FROM 
        {{ ref('stg_online_retail') }}
),
with_id AS(
    SELECT 
        ROW_NUMBER() OVER() AS order_id,
        *
    FROM
        base
)

SELECT * FROM  with_id