WITH WHALES AS (
SELECT 
output_address,
SUM(output_value) as total_sent,
COUNT(*) as tx_count
FROM {{ ref('stg_btc_transactions') }}
where output_value > 10
group by output_address
order by total_sent desc

)
SELECT
w.output_address,
w.total_sent,
w.tx_count,
{{convert_to_usd('w.total_sent')}} as total_sent_usd
FROM WHALES w
order by total_sent desc