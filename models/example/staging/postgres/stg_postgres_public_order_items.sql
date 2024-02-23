{{
  config(
    materialized='view'
  )
}}

WITH src_postgres_order_items AS (
    SELECT * 
    FROM {{ source('postgres', 'order_items') }}
    ),

renamed_casted AS (
    SELECT
          order_id
        , product_id
        , quantity
        , _fivetran_deleted
        , _fivetran_synced AS date_load
    FROM src_postgres_order_items
    )

SELECT * FROM renamed_casted