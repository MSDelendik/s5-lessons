INSERT INTO cdm.dm_settlement_report (
restaurant_id, 
restaurant_name, 
settlement_date, 
orders_count, 
orders_total_sum, 
orders_bonus_payment_sum, 
orders_bonus_granted_sum, 
order_processing_fee, 
restaurant_reward_sum)
SELECT 
b.restaurant_id, 
c.restaurant_name, 
concat_ws('-', d."year",d."month", d."day")::date  AS settlement_date, 
count(DISTINCT order_id) AS orders_count, 
sum(total_sum) AS orders_total_sum, 
sum(bonus_payment) AS orders_bonus_payment_sum, 
sum(bonus_grant) AS orders_bonus_granted_sum, 
sum(total_sum)*0.25 AS order_processing_fee,
sum(total_sum-bonus_payment-(total_sum*0.25)) AS restaurant_reward_sum
FROM dds.fct_product_sales a
JOIN dds.dm_orders b ON a.order_id=b.id
JOIN dds.dm_restaurants c ON b.restaurant_id = c.id
JOIN dds.dm_timestamps d ON b.timestamp_id = d.id
WHERE order_status = 'CLOSED'
GROUP BY 1,2,3
ON CONFLICT ON CONSTRAINT dm_settlement_report_unique
DO UPDATE 
SET res