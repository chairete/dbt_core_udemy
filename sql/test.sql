SELECT *
FROM BTC.BTC_SCHEMA.BTC
LIMIT 100;


select
      max(BLOCK_TIMESTAMP) as max_loaded_at,
      convert_timezone('UTC', current_timestamp()) as snapshotted_at
    from btc.btc_schema.btc;

EXECUTE TASK BTC.BTC_SCHEMA.BTC_LOAD_TASK;