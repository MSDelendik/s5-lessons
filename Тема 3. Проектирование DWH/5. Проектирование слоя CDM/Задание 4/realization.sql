alter table cdm.dm_settlement_report add constraint dm_settlement_report_settlement_values_check check (orders_count >=0 
and orders_total_sum >=0 
and orders_bonus_payment_sum >=0 
and orders_bonus_granted_sum >=0
and order_processing_fee >=0
and restaurant_reward_sum >=0
);

alter table cdm.dm_settlement_report alter column orders_count set default 0;
alter table cdm.dm_settlement_report alter column orders_total_sum set default 0;
alter table cdm.dm_settlement_report alter column orders_bonus_payment_sum set default 0;
alter table cdm.dm_settlement_report alter column orders_bonus_granted_sum set default 0;
alter table cdm.dm_settlement_report alter column order_processing_fee set default 0;
alter table cdm.dm_settlement_report alter column restaurant_reward_sum set default 0;