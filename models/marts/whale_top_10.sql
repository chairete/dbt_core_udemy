WITH BASE AS(
  SELECT *
  FROM {{ ref('whale_alert', v=1) }}
  order by total_sent desc
)
SELECT * FROM BASE