{{ config(
    materialized='view'
    ) 
    }}

WITH stg_budget_products AS (
    SELECT * 
    FROM {{ source('google_sheets','budget') }}

    ),

renamed_casted AS (
    SELECT
          _row
        , month
        , quantity 
        , _fivetran_synced
    FROM stg_budget_products
    where _fivetran_synced >= '{{ var('budget_date')}}'
    )

SELECT * FROM renamed_casted