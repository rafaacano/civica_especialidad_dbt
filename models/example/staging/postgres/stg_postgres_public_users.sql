{{
  config(
    materialized='view'
  )
}}

WITH src_postgres_users AS (
    SELECT * 
    FROM {{ source('postgres', 'users') }}
),
src_postgres_orders AS (
    SELECT * 
    FROM {{ source('postgres', 'orders') }}
)

SELECT
    spu.user_id,
    count(spo.order_id) AS total_pedidos
FROM src_postgres_users AS spu
JOIN src_postgres_orders AS spo ON spu.user_id = spo.user_id
GROUP BY spu.user_id

