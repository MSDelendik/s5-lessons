INSERT INTO dds.dm_orders (order_key, order_status, restaurant_id, timestamp_id, user_id)
SELECT 
order_key,
order_status,
b.id AS restaurant_id,
d.id AS timestamp_id,
c.id AS user_id
FROM (
SELECT 
object_id AS order_key,
object_value::JSON ->> 'final_status' AS order_status,
(object_value::JSON ->> 'date')::timestamp AS date_time,
(object_value::JSON ->> 'restaurant')::JSON ->> 'id' AS restaurant_id,
(object_value::JSON ->> 'user')::JSON ->> 'id' AS user_id
FROM stg.ordersystem_orders) t1
INNER JOIN dds.dm_restaurants b ON t1.restaurant_id=b.restaurant_id
INNER JOIN dds.dm_users c ON t1.user_id=c.user_id
INNER JOIN dds.dm_timestamps d ON t1.date_time=d.ts;