{{ config(
    materialized='incremental',
    incremental_strategy='append'
) }}
WITH flattend AS (
SELECT
tx.hashkey,
tx.block_number,
tx.block_timestamp,
tx.is_coinbase,
f.value:address::String as output_address,
f.value:value::FLOAT as output_value
FROM {{ ref('stg_btc') }} tx,
LATERAL FLATTEN(input => outputs) AS f
WHERE f.value:address IS NOT NULL

{% if is_incremental() %}
  AND tx.block_timestamp > (SELECT MAX(block_timestamp) FROM {{ this }})
{% endif %}

)
SELECT 
hashkey,
block_number,
block_timestamp,
is_coinbase,
output_address,
output_value
FROM flattend