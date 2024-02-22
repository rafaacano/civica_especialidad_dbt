
{{
  config(
    materialized='table'
  )
}}

WITH src_seed_data AS (
    SELECT * 
    FROM {{ source('seed_data', 'personas') }}
    ),

renamed_casted AS (
    SELECT
          name
        , year
        , income
        , education
        , graduation
        , standing
    FROM src_seed_data
    )

SELECT * FROM renamed_casted