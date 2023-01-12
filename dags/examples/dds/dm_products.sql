INSERT INTO dds.dm_products (restaurant_id, product_id, product_name, product_price, active_from, active_to )
SELECT DISTINCT 
id AS restaurant_id,
_id AS product_id,
name AS product_name, 
price AS product_price,
active_from AS active_from,
'2099-12-31'::timestamp AS active_to
FROM (
SELECT 
dr.id,
(object_value::JSON ->> 'menu')::JSON AS json_1,
(object_value::JSON ->> 'update_ts')::timestamp AS active_from
FROM stg.ordersystem_restaurants a
left JOIN dds.dm_restaurants dr ON a.object_id = dr.restaurant_id
WHERE object_value::JSON ->> 'menu' IS NOT NULL
)t1,
json_to_recordset(t1.json_1) as (_id TEXT, category TEXT, name TEXT, price NUMERIC(16,2))
WHERE _id NOT IN (SELECT product_id FROM dds.dm_products);