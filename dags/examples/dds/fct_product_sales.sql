INSERT INTO dds.fct_product_sales
(product_id, order_id, count, price, total_sum, bonus_payment, bonus_grant)

WITH table_1 AS (SELECT DISTINCT
product_id,
order_id,
price,
quantity,
product_cost,
bonus_payment,
bonus_grant
FROM 
(SELECT 
event_value::JSON ->> 'user_id' AS user_id,
event_value::JSON ->> 'order_id' AS order_id,
(event_value::JSON ->> 'product_payments')::JSON AS json_1
FROM stg.bonussystem_events
WHERE event_type = 'bonus_transaction')t1,
json_to_recordset(t1.json_1) as t2 (product_id TEXT, price NUMERIC(16,2), quantity int, product_cost NUMERIC(16,2), bonus_payment NUMERIC(16,2), bonus_grant NUMERIC(16,2)))


SELECT
min (dp.id) AS product_id,
min (dor.id) AS order_id,
quantity AS count,
price,
product_cost AS total_sum,
bonus_payment,
bonus_grant
FROM table_1 t1
INNER JOIN dds.dm_products dp ON dp.product_id = t1.product_id 
INNER JOIN dds.dm_orders dor ON dor.order_key = t1.order_id
WHERE dp.id NOT IN (SELECT product_id FROM dds.fct_product_sales)
AND dor.id NOT IN (SELECT order_id FROM dds.fct_product_sales)
GROUP BY 3,4,5,6,7;