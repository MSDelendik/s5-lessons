INSERT INTO dds.dm_timestamps (ts, "year", "month", "day", "date", "time" )
SELECT 
ts,
date_part('year', ts) AS "year",
date_part('month', ts) AS "month",
date_part('day', ts) AS "day",
ts::date AS "date",
ts::time AS "time"
FROM (
SELECT 
(object_value::JSON ->> 'date')::timestamp AS ts
FROM stg.ordersystem_orders
WHERE object_value::JSON ->> 'date' IS NOT NULL) t1
WHERE ts NOT IN (SELECT ts FROM dds.dm_timestamps);