SELECT *
FROM BTC.BTC_SCHEMA.BTC
LIMIT 100;


select
      max(BLOCK_TIMESTAMP) as max_loaded_at,
      convert_timezone('UTC', current_timestamp()) as snapshotted_at
    from btc.btc_schema.btc;

EXECUTE TASK BTC.BTC_SCHEMA.BTC_LOAD_TASK;

SELECT MAX(BLOCK_TIMESTAMP) AS max_block_timestamp
FROM BTC.BTC_SCHEMA.BTC;

--2026-02-18 11:28:54.000

SELECT *
FROM BTC.DBT_LEEB.STG_BTC
LIMIT 10;

SELECT *
FROM BTC.DBT_LEEB.STG_BTC_OUTPUTS
LIMIT 10;

SELECT * FROM BTC.DBT_LEEB.WHALE_ALERT
order by total_sent desc;

SELECT *
FROM BTC.DBT_LEEB.WHALE_ALERT;

SELECT *
FROM BTC.DBT_LEEB.BTC_USD_MAX
WHERE to_date(replace(snapped_at, ' UTC', '')) = current_date();

