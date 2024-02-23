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
    rco.user_id,
    count(rcu.order_id) AS total_pedidos
FROM src_postgres_users AS rco
JOIN src_postgres_orders AS rcu ON rco.user_id = rcu.user_id
GROUP BY rco.user_id
ORDER BY rco.user_id -- Ordena por user_id y fecha del pedido

