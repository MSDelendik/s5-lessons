INSERT INTO dds.dm_restaurants (restaurant_id, restaurant_name, active_from, active_to)
SELECT 
object_value::JSON ->> '_id' AS restaurant_id,
object_value::JSON ->> 'name' AS restaurant_name,
object_value::JSON ->> 'update_ts' AS actual_from,
'2099-12-31'::timestamp AS actual_to
FROM stg.ordersystem_restaurants
WHERE object_value::JSON ->> 'menu' IS NOT null
AND object_value::JSON ->> '_id' NOT IN (SELECT DISTINCT restaurant_id FROM dds.dm_restaurants);;