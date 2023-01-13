INSERT INTO public_test.testing_result
SELECT
0 AS id,
current_timestamp AS test_date_time,
'test_01' AS test_name,
CASE WHEN count(*)>0 THEN FALSE ELSE TRUE END AS test_result
FROM (
SELECT * FROM public_test.dm_settlement_report_actual a
FULL JOIN public_test.dm_settlement_report_expected b ON 
a.restaurant_id=b.restaurant_id 
AND a.restaurant_name=b.restaurant_name
AND a.settlement_year=b.settlement_year
AND a.settlement_month=b.settlement_month
AND a.orders_count=b.orders_count
AND a.orders_total_sum=b.orders_total_sum
AND a.orders_bonus_payment_sum=b.orders_bonus_payment_sum
AND a.orders_bonus_granted_sum=b.orders_bonus_granted_sum
AND a.order_processing_fee=b.order_processing_fee
AND a.restaurant_reward_sum=b.restaurant_reward_sum
WHERE a.id IS NULL OR b.id IS NULL)t1