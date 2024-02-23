{{
  config(
    materialized='view'
  )
}}

WITH src_postgres_orders AS (
    SELECT * 
    FROM {{ source('postgres', 'orders') }}
    ),

renamed_casted AS (
    SELECT
        order_id
        , shipping_service
        , shipping_cost
        , address_id
        , created_at
        , promo_id
        , estimated_delivery_at
        , order_cost
        , user_id
        , order_total
        , delivered_at
        , tracking_id
        , status
        , _fivetran_deleted
        , _fivetran_synced
    FROM src_postgres_orders
    )

SELECT  AVG(DATEDIFF(day,created_at,delivered_at)) AS tiempo_medio_entrega
 FROM renamed_casted